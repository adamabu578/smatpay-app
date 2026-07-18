import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:smatpay/common/widgets/appbar/appbar.dart';
import 'package:smatpay/common/widgets/images/t_circular_image.dart';
import 'package:smatpay/common/widgets/shimmers/shimmer.dart';
import 'package:smatpay/features/personalization/controllers/user_controller.dart';
import 'package:smatpay/features/smatpay/brands/airtime/screen/buyairtime.dart';
import 'package:smatpay/features/smatpay/brands/data_sme/screen/testing_sme.dart';
import 'package:smatpay/features/smatpay/profile/screen/notifications.dart';
import 'package:smatpay/features/virtual_account/screens/account_screen.dart';
import 'package:smatpay/features/virtual_account/screens/wallet_balance_screen.dart';
import 'package:smatpay/utils/constants/colors.dart';
import 'package:smatpay/utils/constants/image_strings.dart';
import 'package:smatpay/utils/helpers/helper_functions.dart';

import '../../../authentication/controllers/profile/profile_controller.dart';
import '../../brands/electricity/electricity.dart';
import '../../brands/transaction/transaction_card.dart';
import '../../brands/transaction/transaction_controller.dart';
import '../../brands/transaction/transaction_screen.dart';
import '../../controllers/wallet_controller.dart';

class TsmatpayHomeScreen extends StatefulWidget {
  const TsmatpayHomeScreen({super.key});

  @override
  State<TsmatpayHomeScreen> createState() => _TsmatpayHomeScreenState();
}

class _TsmatpayHomeScreenState extends State<TsmatpayHomeScreen>
    with TickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  final GlobalKey<RefreshIndicatorState> _refreshKey =
      GlobalKey<RefreshIndicatorState>();

  // Keep this screen alive when switching bottom nav tabs
  @override
  bool get wantKeepAlive => true;

  // Track if initial load + animation already happened
  static bool _hasAnimated = false;
  static bool _hasLoadedData = false;

  // Animation controllers
  late AnimationController _walletAnim;
  late AnimationController _quickLinksAnim;
  late AnimationController _transactionAnim;

  late Animation<Offset> _walletSlide;
  late Animation<double> _walletFade;
  late Animation<double> _walletScale;

  late Animation<double> _quickLinksFade;
  late Animation<Offset> _quickLinksSlide;

  late Animation<double> _transactionFade;
  late Animation<Offset> _transactionSlide;

  @override
  void initState() {
    super.initState();
    _initAnimations();

    if (!_hasAnimated) {
      // First time — play staggered entrance
      _walletAnim.forward();
      Future.delayed(const Duration(milliseconds: 250), () {
        if (mounted) _quickLinksAnim.forward();
      });
      Future.delayed(const Duration(milliseconds: 450), () {
        if (mounted) _transactionAnim.forward();
      });
      _hasAnimated = true;
    } else {
      // Already animated before — snap to end instantly
      _walletAnim.value = 1.0;
      _quickLinksAnim.value = 1.0;
      _transactionAnim.value = 1.0;
    }

    // Only fetch data on first load
    if (!_hasLoadedData) {
      _hasLoadedData = true;
      Future.microtask(() async {
        final walletCtrl = Get.find<WalletController>();
        final transactionCtrl = Get.find<TransactionController>();
        final profileCtrl = Get.find<ProfileController>();

        await Future.wait([
          walletCtrl.fetchWalletBalance(),
          transactionCtrl.fetchTransactions(forceRefresh: true),
          profileCtrl.loadUserProfile(),
        ]);
      });
    }
  }

  void _initAnimations() {
    _walletAnim = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 700));
    _walletSlide = Tween<Offset>(begin: const Offset(0, 0.4), end: Offset.zero)
        .animate(CurvedAnimation(parent: _walletAnim, curve: Curves.easeOutCubic));
    _walletFade = Tween<double>(begin: 0, end: 1)
        .animate(CurvedAnimation(parent: _walletAnim, curve: Curves.easeOut));
    _walletScale = Tween<double>(begin: 0.92, end: 1.0)
        .animate(CurvedAnimation(parent: _walletAnim, curve: Curves.easeOutBack));

    _quickLinksAnim = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 600));
    _quickLinksFade = Tween<double>(begin: 0, end: 1)
        .animate(CurvedAnimation(parent: _quickLinksAnim, curve: Curves.easeOut));
    _quickLinksSlide = Tween<Offset>(begin: const Offset(0, 0.3), end: Offset.zero)
        .animate(CurvedAnimation(parent: _quickLinksAnim, curve: Curves.easeOutCubic));

    _transactionAnim = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 600));
    _transactionFade = Tween<double>(begin: 0, end: 1)
        .animate(CurvedAnimation(parent: _transactionAnim, curve: Curves.easeOut));
    _transactionSlide = Tween<Offset>(begin: const Offset(0, 0.25), end: Offset.zero)
        .animate(CurvedAnimation(parent: _transactionAnim, curve: Curves.easeOutCubic));
  }

  @override
  void dispose() {
    _walletAnim.dispose();
    _quickLinksAnim.dispose();
    _transactionAnim.dispose();
    super.dispose();
  }

  Future<void> _handleRefresh() async {
    try {
      await Future.wait([
        Get.find<WalletController>().fetchWalletBalance(),
        Get.find<TransactionController>().fetchTransactions(forceRefresh: true),
        Get.find<ProfileController>().loadUserProfile(),
      ]);
      if (_refreshKey.currentState?.mounted ?? false) {
        Get.rawSnackbar(
            message: 'Data refreshed successfully',
            backgroundColor: Colors.green);
      }
    } catch (e) {
      Get.rawSnackbar(
          message: 'Refresh failed: $e', backgroundColor: Colors.red);
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context); // Required for AutomaticKeepAliveClientMixin

    final controller = Get.put(TUserController());
    final profileController = Get.find<ProfileController>();
    final walletController = Get.put(WalletController());
    Get.put(TransactionController());
    final dark = THelperFunctions.isDarkMode(context);

    return Scaffold(
      backgroundColor: dark ? TColors.secondary : TColors.lightGrey,
      appBar: TAppBar(
        title: Row(
          children: [
            Obx(() {
              final networkImage = controller.user.value.profilePicture;
              final image =
                  networkImage.isNotEmpty ? networkImage : TImages.smatpayuser;
              return controller.imageUploading.value
                  ? const TShimmerEffect(width: 80, height: 80, radius: 80)
                  : TCircularImage(
                      image: image,
                      width: 50,
                      height: 50,
                      isNetworkImage: networkImage.isNotEmpty,
                    );
            }),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Welcome back',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: dark ? TColors.grey : TColors.darkerGrey,
                        ),
                  ),
                  const SizedBox(height: 2),
                  Row(
                    children: [
                      Flexible(
                        child: Obx(() {
                          if (profileController.isLoading.value) {
                            return const TShimmerEffect(width: 80, height: 15);
                          }
                          return Text(
                            profileController.firstName.value,
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(
                                  fontWeight: FontWeight.w600,
                                  color: dark ? TColors.white : TColors.black,
                                ),
                            overflow: TextOverflow.ellipsis,
                          );
                        }),
                      ),
                      const SizedBox(width: 6),
                      Image.asset(TImages.wavehand, width: 22, height: 22),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
        actions: [
          GestureDetector(
            onTap: () => Get.to(() => const TNotificationScreen()),
            child: Container(
              height: 38,
              width: 38,
              decoration: BoxDecoration(
                color: dark ? TColors.primary2 : TColors.secondary2,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                Iconsax.notification,
                size: 22,
                color: dark ? TColors.white : TColors.primary,
              ),
            ),
          ),
        ],
      ),
      body: RefreshIndicator(
        key: _refreshKey,
        onRefresh: _handleRefresh,
        color: TColors.primary,
        backgroundColor: TColors.white,
        displacement: 40.0,
        strokeWidth: 2.5,
        triggerMode: RefreshIndicatorTriggerMode.anywhere,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),

                // ─── Wallet Card ─────────────────────────────────
                FadeTransition(
                  opacity: _walletFade,
                  child: SlideTransition(
                    position: _walletSlide,
                    child: ScaleTransition(
                      scale: _walletScale,
                      child:
                          _buildWalletCard(context, walletController, dark),
                    ),
                  ),
                ),

                const SizedBox(height: 28),

                // ─── Quick Links ─────────────────────────────────
                FadeTransition(
                  opacity: _quickLinksFade,
                  child: SlideTransition(
                    position: _quickLinksSlide,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Quick Links',
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(height: 16),
                        _buildQuickLinks(context, dark),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 28),

                // ─── Transactions ────────────────────────────────
                FadeTransition(
                  opacity: _transactionFade,
                  child: SlideTransition(
                    position: _transactionSlide,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // --- Promo Banner ---
                        _buildPromoBanner(context, dark),
                        const SizedBox(height: 28),

                        // --- Pay Bills Row ---
                        Text('Pay Bills',
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(fontWeight: FontWeight.w600)),
                        const SizedBox(height: 14),
                        _buildBillsGrid(context, dark),
                        const SizedBox(height: 28),

                        // --- Recent Transactions ---
                        _buildTransactionSection(context, dark),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ─── Wallet Card ───────────────────────────────────────────────
  Widget _buildWalletCard(
      BuildContext context, WalletController walletController, bool dark) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: TColors.primary,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Stack(
        children: [
          Positioned(
            right: -10,
            top: -10,
            child: Image.asset(TImages.cardvector,
                width: 160,
                height: 160,
                color: TColors.white.withValues(alpha: 0.08)),
          ),
          Padding(
            padding: const EdgeInsets.all(22),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text('Wallet Balance',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: TColors.white.withValues(alpha: 0.8))),
                    const SizedBox(width: 4),
                    Obx(() => GestureDetector(
                          onTap: walletController.toggleBalanceVisibility,
                          child: Icon(
                            walletController.showBalance.value
                                ? Iconsax.eye
                                : Iconsax.eye_slash,
                            color: TColors.white.withValues(alpha: 0.8),
                            size: 20,
                          ),
                        )),
                  ],
                ),
                const SizedBox(height: 8),
                Obx(() {
                  if (walletController.isLoading.value) {
                    return const TShimmerEffect(width: 120, height: 28);
                  }
                  return Text(
                    walletController.showBalance.value
                        ? '₦${walletController.balance.value.toStringAsFixed(2)}'
                        : '₦ ****',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          color: TColors.white,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.bold,
                        ),
                  );
                }),
                const SizedBox(height: 24),
                Row(
                  children: [
                    Expanded(
                        child: _walletBtn(context,
                            icon: TImages.cardreceive,
                            label: 'Fund Wallet',
                            onTap: () => Get.to(() => TAccountScreen()))),
                    const SizedBox(width: 12),
                    Expanded(
                        child: _walletBtn(context,
                            icon: TImages.send,
                            label: 'Withdraw',
                            onTap: () =>
                                Get.to(() => TWalletBalanceScreen()))),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _walletBtn(BuildContext context,
      {required String icon,
      required String label,
      required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 44,
        decoration: BoxDecoration(
            color: TColors.white, borderRadius: BorderRadius.circular(12)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(icon, width: 20, height: 20, color: TColors.primary),
            const SizedBox(width: 8),
            Text(label,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: TColors.primary, fontWeight: FontWeight.w600)),
          ],
        ),
      ),
    );
  }

  // ─── Quick Links ───────────────────────────────────────────────
  Widget _buildQuickLinks(BuildContext context, bool dark) {
    final links = [
      _QuickLink('Account', Icons.account_balance,
          () => Get.to(() => TAccountScreen())),
      _QuickLink('Airtime', Icons.phone_in_talk_sharp,
          () => Get.to(() => const TBuyAirtimeScreen())),
      _QuickLink('Data', Icons.wifi_outlined,
          () => Get.to(() => TTestingSmeDataScreen())),
      _QuickLink('Electricity', Icons.lightbulb,
          () => Get.to(() => const ElectricityPurchaseScreen())),
    ];

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: links.map((link) {
        return GestureDetector(
          onTap: link.onTap,
          child: Column(
            children: [
              Container(
                width: 64,
                height: 64,
                decoration: BoxDecoration(
                  color: dark ? TColors.primary2 : TColors.secondary2,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Icon(link.icon, color: TColors.primary, size: 26),
              ),
              const SizedBox(height: 8),
              Text(link.label,
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall
                      ?.copyWith(fontWeight: FontWeight.w500)),
            ],
          ),
        );
      }).toList(),
    );
  }

  // ─── Promo Banner ────────────────────────────────────────────
  Widget _buildPromoBanner(BuildContext context, bool dark) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            TColors.primary,
            TColors.primary.withValues(alpha: 0.7),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: TColors.white.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Text('NEW',
                      style: TextStyle(
                          color: TColors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 1)),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Refer & Earn Rewards',
                  style: TextStyle(
                      color: TColors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                Text(
                  'Invite friends and earn on every transaction they make',
                  style: TextStyle(
                      color: TColors.white.withValues(alpha: 0.8),
                      fontSize: 12,
                      height: 1.4),
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          Image.asset(TImages.referalgift, width: 65, height: 65),
        ],
      ),
    );
  }

  // ─── Bills Grid ────────────────────────────────────────────────
  Widget _buildBillsGrid(BuildContext context, bool dark) {
    final bills = [
      _BillItem(Iconsax.monitor, 'Cable TV', 'DStv, GOtv'),
      _BillItem(Iconsax.flash_1, 'Electricity', 'Prepaid'),
      _BillItem(Iconsax.teacher, 'Education', 'WAEC, JAMB'),
      _BillItem(Iconsax.gift, 'Gift Cards', 'Send gifts'),
    ];

    return Row(
      children: bills.map((bill) {
        return Expanded(
          child: GestureDetector(
            onTap: () {
              if (bill.label == 'Cable TV') {
                Get.toNamed('/cable-tv');
              } else if (bill.label == 'Electricity') {
                Get.to(() => const ElectricityPurchaseScreen());
              }
            },
            child: Container(
              margin: EdgeInsets.only(
                  right: bill != bills.last ? 8 : 0),
              padding: const EdgeInsets.symmetric(vertical: 14),
              decoration: BoxDecoration(
                color: dark ? TColors.primary2 : TColors.white,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Column(
                children: [
                  Container(
                    width: 38,
                    height: 38,
                    decoration: BoxDecoration(
                      color: dark
                          ? TColors.primary.withValues(alpha: 0.12)
                          : TColors.secondary2,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child:
                        Icon(bill.icon, size: 18, color: TColors.primary),
                  ),
                  const SizedBox(height: 8),
                  Text(bill.label,
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall
                          ?.copyWith(
                              fontWeight: FontWeight.w600, fontSize: 11)),
                  Text(bill.subtitle,
                      style: TextStyle(
                          fontSize: 9,
                          color:
                              dark ? TColors.darkGrey : TColors.darkerGrey)),
                ],
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  // ─── Transactions ──────────────────────────────────────────────
  Widget _buildTransactionSection(BuildContext context, bool dark) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Recent Transactions',
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(fontWeight: FontWeight.w600)),
            GestureDetector(
              onTap: () => Get.to(() => const FullTransactionScreen()),
              child: Text('View All',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: TColors.primary, fontWeight: FontWeight.w500)),
            ),
          ],
        ),
        const SizedBox(height: 14),
        Obx(() {
          final c = TransactionController.instance;
          if (c.isLoading.value) {
            return const TShimmerEffect(width: double.infinity, height: 100);
          }
          if (c.hasError.value) {
            return Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 30),
              decoration: BoxDecoration(
                  color: dark ? TColors.primary2 : TColors.white,
                  borderRadius: BorderRadius.circular(16)),
              child: Column(children: [
                const Icon(Icons.error_outline, color: Colors.red, size: 40),
                const SizedBox(height: 8),
                Text('Failed to load transactions',
                    style: Theme.of(context).textTheme.bodyMedium),
                const SizedBox(height: 12),
                ElevatedButton(
                    onPressed: c.fetchTransactions,
                    child: const Text('Retry')),
              ]),
            );
          }
          if (c.transactions.isEmpty) {
            return Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 30),
              decoration: BoxDecoration(
                  color: dark ? TColors.primary2 : TColors.white,
                  borderRadius: BorderRadius.circular(16)),
              child: Column(children: [
                Image.asset(TImages.notransaction, width: 120, height: 120),
                const SizedBox(height: 12),
                Text('No transactions yet',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: dark ? TColors.grey : TColors.darkerGrey)),
              ]),
            );
          }
          return TransactionCard(
              transaction: c.latestTransaction!, showFullDetails: false);
        }),
      ],
    );
  }
}

class _QuickLink {
  final String label;
  final IconData icon;
  final VoidCallback onTap;
  const _QuickLink(this.label, this.icon, this.onTap);
}

class _BillItem {
  final IconData icon;
  final String label;
  final String subtitle;
  const _BillItem(this.icon, this.label, this.subtitle);
}
