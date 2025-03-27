import 'package:smatpay/common/widgets/appbar/appbar.dart';
import 'package:smatpay/features/smatpay/brands/smile/widgets/smiletopupdata.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class TSmileTopUpScreen extends StatelessWidget {
  const TSmileTopUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: TAppBar(
        title: Text('Buy Smile TopUp'),
        showBackArrow: true,
        actions: [Icon(Iconsax.message_question)],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            children: [
              SizedBox(
                height: 50,
              ),
              TSmileTopUpData(
                title: 'SmileVoice ONLY 65',
                amount: 'N600',
                duration: '30 days',
              ),
              TSmileTopUpData(
                title: 'SmileVoice ONLY 135',
                amount: 'N1250',
                duration: '30 days',
              ),
              TSmileTopUpData(
                title: 'SmileVoice ONLY 150',
                amount: 'N1800',
                duration: '60 days',
              ),
              TSmileTopUpData(
                title: 'SmileVoice ONLY 175',
                amount: 'N2400',
                duration: '90 days',
              ),
              TSmileTopUpData(
                title: 'SmileVoice ONLY 430',
                amount: 'N3850',
                duration: '60 days',
              ),
              TSmileTopUpData(
                title: 'SmileVoice ONLY 500',
                amount: 'N6050',
                duration: '90 days',
              ),
              TSmileTopUpData(
                title: '1GB FlexiDaily',
                amount: 'N330',
                duration: '1 day',
              ),
              TSmileTopUpData(
                title: '2.5GB FlexiDaily       ',
                amount: 'N550',
                duration: '2 days',
              ),
              TSmileTopUpData(
                title: '1GB FlexiWeekly       ',
                amount: 'N550',
                duration: '7 day',
              ),
              TSmileTopUpData(
                title: '2GB FlexiDaily       ',
                amount: 'N1000',
                duration: '7 day',
              ),
              TSmileTopUpData(
                title: 'International SmileVoice ONLY 23',
                amount: 'N220',
                duration: '3 days',
              ),
              TSmileTopUpData(
                title: 'International SmileVoice ONLY 60',
                amount: 'N550',
                duration: '7 days',
              ),
              TSmileTopUpData(
                title: 'International SmileVoice ONLY 125',
                amount: 'N1100',
                duration: '7 days',
              ),
              TSmileTopUpData(
                title: '1.5GB Bigga',
                amount: 'N1100',
                duration: '30 days',
              ),
              TSmileTopUpData(
                title: '2GB Bigga',
                amount: 'N1320',
                duration: '30 days',
              ),
              TSmileTopUpData(
                title: '3GB Bigga',
                amount: 'N1650',
                duration: '30 days',
              ),
              TSmileTopUpData(
                title: '5GB Bigga',
                amount: 'N2200',
                duration: '30 days',
              ),
              TSmileTopUpData(
                title: '6.5GB Bigga',
                amount: 'N2750',
                duration: '30 days',
              ),
              TSmileTopUpData(
                title: '10GB Bigga',
                amount: 'N3300',
                duration: '30 days',
              ),
              TSmileTopUpData(
                title: '15GB Bigga',
                amount: 'N9900',
                duration: '30 days',
              ),
              TSmileTopUpData(
                title: 'Freedom Best Effort',
                amount: 'N44000',
                duration: '30 days',
              ),
              TSmileTopUpData(
                title: '35GB 360',
                amount: 'N20900',
                duration: '60 days',
              ),
              TSmileTopUpData(
                title: '90GB Jumbo',
                amount: 'N22000',
                duration: '60 days',
              ),
              TSmileTopUpData(
                title: '160GB Jumbo',
                amount: 'N37400',
                duration: '90 days',
              ),
              TSmileTopUpData(
                title: 'Freedom 3Mbps',
                amount: 'N27500',
                duration: '30 days',
              ),
              TSmileTopUpData(
                title: 'Freedom 6Mbps',
                amount: 'N33000',
                duration: '30 days',
              ),
              TSmileTopUpData(
                title: '20GB Bigger',
                amount: 'N5500',
                duration: '30 days',
              ),
              TSmileTopUpData(
                title: '25GB Bigger',
                amount: 'N6600',
                duration: '30 days',
              ),
              TSmileTopUpData(
                title: '30GB Bigger',
                amount: 'N8800',
                duration: '30 days',
              ),
              TSmileTopUpData(
                title: '40GB Bigger',
                amount: 'N11000',
                duration: '30 days',
              ),
              TSmileTopUpData(
                title: '60GB Bigger',
                amount: 'N14850',
                duration: '30 days',
              ),
              TSmileTopUpData(
                title: '75GB Bigger',
                amount: 'N16500',
                duration: '30 days',
              ),
              TSmileTopUpData(
                title: 'Unlimited Lite',
                amount: 'N13200',
                duration: '30 days',
              ),
              TSmileTopUpData(
                title: 'Unlimited Essentials',
                amount: 'N19800',
                duration: '30 days',
              ),
              TSmileTopUpData(
                title: '2GB Midnight',
                amount: 'N1100',
                duration: '7 days',
              ),
              TSmileTopUpData(
                title: '3GB Midnight',
                amount: 'N1650',
                duration: '7 days',
              ),
              TSmileTopUpData(
                title: '2GB Weekend Only',
                amount: 'N1650',
                duration: '1 Weekend',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
