import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smatpay/common/widgets/appbar/appbar.dart';
import 'package:smatpay/features/virtual_account/screens/topup_amount.dart';
import 'package:smatpay/utils/constants/colors.dart';
import 'package:smatpay/utils/helpers/helper_functions.dart';

import '../controllers/create_virtual_account_controller.dart';
import 'create_virtual_account.dart';

class TAccountScreen extends StatefulWidget {
  const TAccountScreen({super.key});

  @override
  State<TAccountScreen> createState() => _TAccountScreenState();
}

class _TAccountScreenState extends State<TAccountScreen> {
  final AccountController _accountController = AccountController();
  Map<String, dynamic>? _profileData;
  bool _isLoading = true;
  String _errorMessage = '';
  String? _currentUserId;


  @override
  void initState() {
    super.initState();
    _loadUserAndData();
  }

  Future<void> _loadUserAndData() async {
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getString('user_id'); // Assuming you store user ID

    if (userId != _currentUserId) {
      // User changed, clear cache and reload
      await _accountController.clearCache();
      setState(() {
        _currentUserId = userId;
        _profileData = null;
        _isLoading = true;
      });
    }

    await _loadInitialData();
  }

  Future<void> _loadInitialData() async {
    try {
      // Force refresh if we have no cached data for current user
      final forceRefresh = _profileData == null;
      final data = await _accountController.fetchProfileDetails(forceRefresh: forceRefresh);

      if (data['virtualAccounts'] == null) {
        data['virtualAccounts'] = [];
      }
      if (mounted) {
        setState(() {
          _profileData = data;
          _isLoading = false;
          _errorMessage = '';
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isLoading = false;
          _errorMessage = e.toString().replaceAll('Exception: ', '');
          if (_profileData == null) {
            _profileData = {'virtualAccounts': []};
          }
        });
      }
    }
  }

  Future<void> _refreshData() async {
    try {
      // Force fresh data fetch
      final freshData = await _accountController.fetchProfileDetails(forceRefresh: true);

      if (mounted) {
        setState(() {
          _profileData = freshData;
        });
      }
    } catch (e) {
      debugPrint('Background refresh failed: $e');
      if (mounted) {
        setState(() {
          _errorMessage = e.toString().replaceAll('Exception: ', '');
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Scaffold(
      backgroundColor: dark ? TColors.secondary : TColors.softGrey,
      appBar: TAppBar(
        title: const Text('Add Money'),
        showBackArrow: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _refreshData, // Now the function is referenced
            tooltip: 'Refresh account data',
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Bank Transfer Section
            _buildPaymentOption(
              context,
              icon: Icons.account_balance,
              title: "Bank Transfer",
              subtitle: "Add money via mobile or internet banking",
            ),
            const SizedBox(height: 20),

            // Account Number Section
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: dark ? TColors.darkerGrey : TColors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "SmatPay Account Number",
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  const SizedBox(height: 8),

                  if (_profileData != null)
                    _buildAccountInfo(_profileData!)
                  else if (_isLoading)
                    const SizedBox(
                      height: 100,
                      child: Center(child: CircularProgressIndicator()),
                    )
                  else if (_errorMessage.isNotEmpty)
                      _buildErrorWidget()
                    else
                      Text(
                        'No account data available',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),

                  const SizedBox(height: 16),
                  if (_profileData != null) _buildActionButtons(),

                ],
              ),
            ),

            // OR Divider
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Row(
                children: [
                  Expanded(child: Divider(color: dark ? TColors.darkGrey : TColors.grey)),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      "OR",
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                  Expanded(child: Divider(color: dark ? TColors.darkGrey : TColors.grey)),
                ],
              ),
            ),

            // Other payment options
            _buildPaymentOption(
              context,
              icon: Icons.money,
              title: "Cash Deposit",
              subtitle: "Fund your account with nearby merchants",
            ),
            const SizedBox(height: 16),

            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const TopUpAmountScreen()),
                );
              },
              child: _buildPaymentOption(
                context,
                icon: Icons.account_balance,
                title: "Top-up with Card/Account",
                subtitle: "Add money directly from your bank card or account",
              ),
            ),
            const SizedBox(height: 16),

            _buildPaymentOption(
              context,
              icon: Icons.phone_android,
              title: "Bank USSD",
              subtitle: "With other banks' USSD code",
            ),
            const SizedBox(height: 16),

            _buildPaymentOption(
              context,
              icon: Icons.qr_code,
              title: "Scan my QR Code",
              subtitle: "Show QR code to any SmatPay user",
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAccountInfo(Map<String, dynamic> data) {
    final virtualAccounts = data['virtualAccounts'] as List;

    if (virtualAccounts.isEmpty) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'No virtual account found',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Theme.of(context).disabledColor,
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: // In your AccountScreen's "Create Account" button:
            ElevatedButton(
              onPressed: () async {
                final result = await Get.to<bool>(() => const CreateVirtualAccountScreen());
                if (result == true) {
                  await _loadInitialData(); // Refresh account data
                }
              },
              child: const Text('Create Virtual Account'),
            )
          ),
        ],
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          virtualAccounts[0]['accountNumber']?.toString() ?? 'Not available',
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        if (virtualAccounts[0]['accountName'] != null)
          Padding(
            padding: const EdgeInsets.only(top: 4),
            child: Text(
              virtualAccounts[0]['accountName'],
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).hintColor,
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildErrorWidget() {
    return Column(
      children: [
        Text(
          'Failed to load account',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.red),
        ),
        const SizedBox(height: 8),
        Text(
          _errorMessage,
          style: Theme.of(context).textTheme.bodySmall,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
        ElevatedButton(
          onPressed: _loadInitialData,
          child: const Text('Retry'),
        ),
      ],
    );
  }

  Widget _buildActionButtons() {
    final virtualAccounts = _profileData?['virtualAccounts'] as List?;
    final hasAccount = virtualAccounts != null && virtualAccounts.isNotEmpty;

    return Row(
      children: [
        Expanded(
          child: OutlinedButton(
            onPressed: hasAccount ? () {
              Clipboard.setData(ClipboardData(
                  text: virtualAccounts[0]['accountNumber']));
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Copied to clipboard')),
              );
            } : null,
            child: const Text("Copy Number"),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: ElevatedButton(
            onPressed: hasAccount ? () {
              // Implement share functionality here
            } : null,
            child: const Text("Share Details"),
          ),
        ),
      ],
    );
  }

  Widget _buildPaymentOption(
      BuildContext context, {
        required IconData icon,
        required String title,
        required String subtitle,
      }) {
    final dark = THelperFunctions.isDarkMode(context);
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: dark ? TColors.darkerGrey : TColors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(icon, size: 30, color: TColors.primary),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                Text(
                  subtitle,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          ),
          Icon(Icons.arrow_forward_ios, size: 16, color: dark ? TColors.grey : TColors.darkGrey),
        ],
      ),
    );
  }
}