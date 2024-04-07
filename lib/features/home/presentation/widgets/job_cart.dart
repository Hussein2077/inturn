import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:inturn/core/resource_manager/asset_path.dart';
import 'package:inturn/core/resource_manager/colors.dart';
import 'package:inturn/core/resource_manager/string_manager.dart';
import 'package:inturn/core/utils/app_size.dart';
import 'package:inturn/core/widgets/cutom_text.dart';
import 'package:inturn/core/widgets/main_button.dart';

class JobCart extends StatelessWidget {
  const JobCart({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 10,
      color: Colors.white,
      borderRadius: BorderRadius.circular(AppSize.defaultSize!),
      child: Padding(
        padding: EdgeInsets.all(AppSize.defaultSize! * 1.5),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          CustomText(
            text: 'Senior UI UX Designer',
            fontWeight: FontWeight.w700,
            color: AppColors.primaryColor,
            // textAlign: TextAlign.start,
            fontSize: AppSize.defaultSize! * 1.6,
          ),
          Row(children: [
            CircleAvatar(
              radius: AppSize.defaultSize! * 1.5,
              child: Image.asset(AssetPath.test),
            ),
            SizedBox(
              width: AppSize.defaultSize! * .5,
            ),
            CustomText(
              text: 'HRS Group',
              fontWeight: FontWeight.w500,
              color: AppColors.primaryColor,
              // textAlign: TextAlign.start,
              fontSize: AppSize.defaultSize! * 1.4,
            ),
          ]),
          Row(children: [
            Icon(
              Icons.location_on_outlined,
              size: AppSize.defaultSize! * 2,
              color: AppColors.greyColor,
            ),
            SizedBox(
              width: AppSize.defaultSize! * .5,
            ),
            CustomText(
              text: 'Cairo, Egypt',
              color: AppColors.greyColor,
              // textAlign: TextAlign.start,
              fontSize: AppSize.defaultSize! * 1.4,
            ),
            SizedBox(
              width: AppSize.defaultSize! * 2,
            ),
            MainButton(
              text: StringManager.internship.tr(),
              onTap: () {},
              color: AppColors.homeColor,
              textColor: Colors.white,
              fontSize: AppSize.defaultSize!,
              height: AppSize.defaultSize! * 2.5,
              width: AppSize.defaultSize! * 10,
            )
          ]),
          SizedBox(
            height: AppSize.defaultSize!,
          ),
          CustomText(
            text:
                '''Experienced (Non-Manager) · 3-4 Yrs of Exp · ui · UI Design · UX Design · Design · UX · adobe · Adobe XD · Xd · Creative/Design/Art · IT/Software Development
              ''',
            maxLines: 10,
            textAlign: TextAlign.start,
            color: AppColors.blackColor,
            fontSize: AppSize.defaultSize! * 1.2,
          )
        ]),
      ),
    );
  }
}
