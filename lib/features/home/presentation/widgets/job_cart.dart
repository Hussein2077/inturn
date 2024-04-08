import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:inturn/core/resource_manager/asset_path.dart';
import 'package:inturn/core/resource_manager/colors.dart';
import 'package:inturn/core/resource_manager/string_manager.dart';
import 'package:inturn/core/utils/app_size.dart';
import 'package:inturn/core/widgets/cutom_text.dart';
import 'package:inturn/core/widgets/main_button.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:percent_indicator/percent_indicator.dart';

class JobCart extends StatelessWidget {
  const JobCart({super.key, this.linearCircle = true});

  final bool linearCircle;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: AppSize.screenWidth,
      child: Material(
        elevation: 10,
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppSize.defaultSize! * 2),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(AppSize.defaultSize! * 1.5),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
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
                    ),
                  ]),
            ),
            linearCircle
                ? LinearPercentIndicator(
                    // width: AppSize.screenWidth!*.88,
                    animation: true,
                    lineHeight: AppSize.defaultSize! * 2.5,
                    animationDuration: 2000,
                    percent: 0.9,
                    padding: EdgeInsets.zero,
                    barRadius: Radius.circular(AppSize.defaultSize! * 2),
                    center: CustomText(
                      text: "90.0% ${StringManager.matched.tr()}",
                      fontSize: AppSize.defaultSize! * 1.3,
                      color: Colors.white,
                    ),
                    linearStrokeCap: LinearStrokeCap.butt,
                    progressColor: Colors.green,
                  )
                : Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        width: AppSize.defaultSize! * 10,
                        height: AppSize.defaultSize! * 2.4,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft:
                                  Radius.circular(AppSize.defaultSize! * 2),
                              bottomLeft:
                                  Radius.circular(AppSize.defaultSize! * 2),
                            ),
                            color: AppColors.homeColor),
                        child: Center(
                          child: CustomText(
                            text: StringManager.viewed.tr(),
                            color: Colors.white,
                            fontSize: AppSize.defaultSize! * 1.3,
                          ),
                        ),
                      ),
                      Container(
                        width: AppSize.defaultSize! * 10,
                        height: AppSize.defaultSize! * 2.4,
                        decoration: const BoxDecoration(color: AppColors.greyColor),
                        child: Center(
                          child: CustomText(
                            text: StringManager.shortlist.tr(),
                            color: Colors.white,
                            fontSize: AppSize.defaultSize! * 1.3,
                          ),
                        ),
                      ),
                      Container(
                        width: AppSize.defaultSize! * 10,
                        height: AppSize.defaultSize! * 2.4,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topRight:
                                  Radius.circular(AppSize.defaultSize! * 2),
                              bottomRight:
                                  Radius.circular(AppSize.defaultSize! * 2),
                            ),
                            color: AppColors.greyColor),
                        child: Center(
                          child: CustomText(
                            text: StringManager.selection.tr(),
                            color: Colors.white,
                            fontSize: AppSize.defaultSize! * 1.3,
                          ),
                        ),
                      ),
                    ],
                  ),
            if(!linearCircle)
              SizedBox(height: AppSize.defaultSize! * 1.2,),
          ],
        ),
      ),
    );
  }
}
