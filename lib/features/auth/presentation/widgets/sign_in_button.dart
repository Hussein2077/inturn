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
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(AppSize.defaultSize! * 1.5),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppSize.defaultSize! * 1.5),
          border:   Border.all(color: AppColors.borderColor),
        ),
        height: AppSize.defaultSize! * 5,
        width: double.maxFinite, // AppSize.screenWidth! * .9,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            logo,

            SizedBox(
              width:  AppSize.defaultSize! * 20,
              child: CustomText(
                text: text,
                fontSize: AppSize.defaultSize! * 1.4,
                textAlign: TextAlign.center,
                color: AppColors.primaryColor,
                fontWeight: FontWeight.w600,
              ),
            ),

            SizedBox(width: AppSize.defaultSize!*5 ,),
          ],
        ),
      ),
    );
  }
}
