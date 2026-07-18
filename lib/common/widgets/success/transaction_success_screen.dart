import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:smatpay/utils/constants/colors.dart';
import 'package:smatpay/utils/constants/image_strings.dart';
import 'package:smatpay/utils/helpers/helper_functions.dart';

class TransactionSuccessScreen extends StatefulWidget {
  final String title;
  final String message;
  final String transactionId;
  final VoidCallback? onDone;
  final bool showViewReceipt;
  final VoidCallback? onViewReceipt;

  const TransactionSuccessScreen({
    Key? key,
    this.title = 'Payment Successful!',
    required this.message,
    required this.transactionId,
    this.onDone,
    this.showViewReceipt = false,
    this.onViewReceipt,
  }) : super(key: key);

  @override
  State<TransactionSuccessScreen> createState() => _TransactionSuccessScreenState();
}

class _TransactionSuccessScreenState extends State<TransactionSuccessScreen>
    with TickerProviderStateMixin {
  late AnimationController _slideController;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _slideController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _slideController, curve: Curves.easeOut));
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _slideController, curve: Curves.easeOut),
    );

    // Start animation after Lottie has a moment to load
    Future.delayed(const Duration(milliseconds: 300), () {
      if (mounted) _slideController.forward();
    });
  }

  @override
  void dispose() {
    _slideController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    final doneCallback = widget.onDone ?? () => Get.back();

    return Scaffold(
      backgroundColor: dark ? TColors.secondary : TColors.softGrey,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              const Spacer(flex: 1),

              // --- Lottie Animation ---
              Lottie.asset(
                TImages.paymentSuccessfulAnimation,
                width: 180,
                height: 180,
                repeat: false,
              ),

              const SizedBox(height: 16),

              // --- Animated Content ---
              FadeTransition(
                opacity: _fadeAnimation,
                child: SlideTransition(
                  position: _slideAnimation,
                  child: Column(
                    children: [
                      // Title
                      Text(
                        widget.title,
                        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      const SizedBox(height: 8),

                      // Message
                      Text(
                        widget.message,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: dark ? TColors.grey : TColors.darkerGrey,
                            ),
                      ),
                      const SizedBox(height: 28),

                      // Transaction ID Card
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(18),
                        decoration: BoxDecoration(
                          color: dark ? TColors.primary2 : TColors.white,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Column(
                          children: [
                            Text(
                              'Transaction ID',
                              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                    color: dark ? TColors.grey : TColors.darkerGrey,
                                  ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              widget.transactionId,
                              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Roboto',
                                    letterSpacing: 0.5,
                                  ),
                            ),
                            const SizedBox(height: 12),
                            GestureDetector(
                              onTap: () {
                                Clipboard.setData(ClipboardData(text: widget.transactionId));
                                Get.rawSnackbar(
                                  message: 'Transaction ID copied!',
                                  backgroundColor: TColors.primary,
                                  duration: const Duration(seconds: 2),
                                );
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.copy, size: 14, color: TColors.primary),
                                  const SizedBox(width: 6),
                                  Text(
                                    'Copy',
                                    style: TextStyle(
                                      color: TColors.primary,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 13,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const Spacer(flex: 2),

              // --- Buttons ---
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: doneCallback,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    backgroundColor: TColors.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  child: const Text(
                    'Done',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ),
              ),

              if (widget.showViewReceipt)
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: TextButton(
                    onPressed: widget.onViewReceipt,
                    child: const Text(
                      'View Receipt',
                      style: TextStyle(
                        fontSize: 15,
                        color: TColors.primary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),

              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
