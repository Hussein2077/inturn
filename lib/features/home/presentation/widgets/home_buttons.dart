import 'package:flutter/material.dart';
import 'package:inturn/core/resource_manager/colors.dart';
import 'package:inturn/core/utils/app_size.dart';

class HomePageButtons extends StatelessWidget {
  const HomePageButtons({Key? key, required this.text, this.onPressed}) : super(key: key);
  final String text;
final void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: AppSize.screenWidth!,
      height: AppSize.defaultSize!*8,
      child: Padding(
        padding: EdgeInsets.all( AppSize.defaultSize!*.6),
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            elevation: 0,
            shape:   RoundedRectangleBorder(
              side: const BorderSide(
                color:AppColors. borderColor,
              ),
              borderRadius: BorderRadius.all(
                Radius.circular(AppSize.defaultSize!*.6),
              ),
            ),
          ),
          child: Text(
            text,
            style:   TextStyle(
              color: AppColors.primaryColor,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.bold,
              fontSize: AppSize.defaultSize!*1.9,
            ),
          ),
        ),
      ),
    );
  }
}