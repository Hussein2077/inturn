import 'package:flutter/material.dart';
import 'package:inturn/core/resource_manager/colors.dart';
import 'package:inturn/core/utils/app_size.dart';
import 'package:inturn/core/widgets/cutom_text.dart';

class CustomSignInButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final Widget logo;

  const CustomSignInButton({
    super.key,
    required this.onPressed,
    required this.text,
    required this.logo,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: AppSize.defaultSize! * 4.8,
      width: double.maxFinite, // AppSize.screenWidth! * .9,
      child: ElevatedButton.icon(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          disabledForegroundColor: Colors.white,
          disabledBackgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSize.defaultSize! * 1.5),
            side: const BorderSide(color: Colors.grey), // Border color
          ), // Text color
        ),
        icon: logo,
        label: CustomText(
          text: text,
          fontSize: AppSize.defaultSize! * 1.6,
          color: AppColors.primaryColor,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
