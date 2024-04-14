import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:inturn/core/resource_manager/asset_path.dart';
import 'package:inturn/core/resource_manager/colors.dart';
import 'package:inturn/core/resource_manager/string_manager.dart';
import 'package:inturn/core/utils/app_size.dart';
import 'package:inturn/core/widgets/cutom_text.dart';
import 'package:inturn/core/widgets/main_button.dart';

class CompanyCart extends StatelessWidget {
  const CompanyCart({super.key, this.width, this.description = false});

  final double? width;
  final bool description;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? AppSize.screenWidth! * .8,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppSize.defaultSize! * 2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            child: Image.asset(
              AssetPath.test2,
              fit: BoxFit.fitWidth,
              width: AppSize.screenWidth,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(AppSize.defaultSize!),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                    text: 'HRS Group',
                    fontWeight: FontWeight.w500,
                    color: AppColors.thirdColor,
                    fontSize: AppSize.defaultSize! * 1.4),
                CustomText(
                    text: 'Software Development',
                    color: AppColors.greyColor,
                    fontSize: AppSize.defaultSize! * 1.2),
                SizedBox(
                  height: AppSize.defaultSize! * 1.5,
                ),
                Row(
                  children: [
                    Icon(
                      Icons.shopping_bag_sharp,
                      size: AppSize.defaultSize! * 2,
                    ),
                    CustomText(
                      text: '35 jobs',
                      color: AppColors.thirdColor,
                      fontSize: AppSize.defaultSize! * 1.4,
                    ),
                  ],
                ),
                SizedBox(
                  height: AppSize.defaultSize! * 1.5,
                ),
                if (description)
                  CustomText(
                    text:
                        'Reinventing the way businesses and , stay and pay in today’s dynamic global marketplace. HRS’ advanced platform technology...',
                    color: AppColors.greyColor,
                    maxLines: 20,
                    textAlign: TextAlign.start,
                    fontSize: AppSize.defaultSize! * 1.3,
                  ),
                if (description)
                  MainButton(text: StringManager.moreAboutTheCompany.tr(),

                  textColor: AppColors.black,
                    fontWeight: FontWeight.w700,
                  )
              ],
            ),
          )
        ],
      ),
    );
  }
}
