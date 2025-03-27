import 'package:smatpay/utils/constants/colors.dart';
import 'package:flutter/material.dart';

class SaveAsBeneficiarySwitch extends StatefulWidget {
  const SaveAsBeneficiarySwitch({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SaveAsBeneficiarySwitchState createState() =>
      _SaveAsBeneficiarySwitchState();
}

class _SaveAsBeneficiarySwitchState extends State<SaveAsBeneficiarySwitch> {
  bool _isSaved = false;

  void _toggleSave(bool value) {
    setState(() {
      _isSaved = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          _isSaved ? "Saved as Beneficiary" : "Save as Beneficiary",
          style: TextStyle(
            fontSize: 14,
            //  fontWeight: FontWeight.bold,
            color: _isSaved ? TColors.primary : TColors.darkGrey,
          ),
        ),
        const SizedBox(width: 10),
        Transform.scale(
          //scale: 0.8,
          scaleX: 0.7,
          scaleY: 0.6,
          child: Switch(
            value: _isSaved,
            onChanged: _toggleSave,
            activeColor: TColors.primary,
            inactiveThumbColor: TColors.white,
            inactiveTrackColor: TColors.darkGrey,
          ),
        ),
      ],
    );
  }
}
