import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:inturn/core/resource_manager/asset_path.dart';
import 'package:inturn/core/resource_manager/colors.dart';
import 'package:inturn/core/resource_manager/string_manager.dart';
import 'package:inturn/core/utils/app_size.dart';

class TakeQuiz extends StatelessWidget {
  const TakeQuiz({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: AppSize.defaultSize! * 1.6,
          horizontal: AppSize.defaultSize! * .8),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.backGroundColor,
          border: Border.all(
            color: AppColors.borderColor,
            width: 0.5,
          ),
          borderRadius: BorderRadius.circular(AppSize.defaultSize!),
        ),
        height: AppSize.defaultSize! * 12,
        child: Padding(
          padding: EdgeInsets.all(AppSize.defaultSize! * 2),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(AssetPath.illustration),
              Column(
                children: [
                  Text(
                    StringManager.takeQuiz.tr(),
                    style: TextStyle(
                      color: AppColors.primaryColor,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.bold,
                      fontSize: AppSize.defaultSize! * 2.1,
                    ),
                  ),
                  Text(
                    StringManager.youCanTakeQuiz.tr(),
                    style: TextStyle(
                      color: AppColors.mainFontColor,
                      fontFamily: 'Poppins',
                      fontSize: AppSize.defaultSize! * 1.2,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
