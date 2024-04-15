import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:inturn/core/resource_manager/asset_path.dart';
import 'package:inturn/core/resource_manager/colors.dart';
import 'package:inturn/core/resource_manager/string_manager.dart';
import 'package:inturn/core/utils/app_size.dart';
import 'package:inturn/core/widgets/app_bar.dart';
import 'package:inturn/core/widgets/cutom_text.dart';
import 'package:inturn/features/home/presentation/widgets/job_cart.dart';

class CompanyDetails extends StatelessWidget {
  const CompanyDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(AppSize.defaultSize! * 1.6),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: AppSize.defaultSize! * 2,
              ),
              SizedBox(
                height: AppSize.defaultSize! * 17,
                child: Stack(
                  children: [
                    Image.asset(
                      AssetPath.test3,
                      width: AppSize.screenWidth,
                      height: AppSize.defaultSize! * 10,
                    ),
                    Positioned(
                      top: AppSize.defaultSize! * 7,
                      left: AppSize.defaultSize! * 5,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          CircleAvatar(
                              radius: AppSize.defaultSize! * 4.8,
                              child: Image.asset(
                                AssetPath.test4,
                                height: AppSize.defaultSize! * 10,
                                width: AppSize.defaultSize! * 10,
                              )),
                          SizedBox(
                            width: AppSize.defaultSize! * 2,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomText(
                                  text: 'HRS Group',
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.black,
                                  fontSize: AppSize.defaultSize! * 1.6),
                              CustomText(
                                  text: 'Software Development',
                                  color: AppColors.greyColor,
                                  fontSize: AppSize.defaultSize! * 1.2),
                              SizedBox(
                                height: AppSize.defaultSize! * .3,
                              ),
                              Row(
                                children: [
                                  Image.asset(
                                    AssetPath.location,
                                    height: AppSize.defaultSize! * 2,
                                    width: AppSize.defaultSize! * 2,
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
                                ],
                              ),
                              SizedBox(
                                height: AppSize.defaultSize! * .3,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
          
                    // SvgPicture.asset(AssetPath.test, height: AppSize.defaultSize!*10,),
                  ],
                ),
              ),
              SizedBox(
                height: AppSize.defaultSize! * 2,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  socialMediaButton(asset: AssetPath.website),
                  socialMediaButton(asset: AssetPath.facebook2),
                  socialMediaButton(asset: AssetPath.instagram),
                  socialMediaButton(asset: AssetPath.twitter),
                  socialMediaButton(asset: AssetPath.linkedin),
                ],
              ),
              SizedBox(
                height: AppSize.defaultSize! * 2,
              ),
              Material(
                elevation: 10,
                color: Colors.white,
                borderRadius: BorderRadius.circular(AppSize.defaultSize! * 2),
                child: Padding(
                  padding: EdgeInsets.all(AppSize.defaultSize! * 1.5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        text: StringManager.companyOverview.tr(),
                        fontWeight: FontWeight.w700,
                        color: AppColors.black,
                      ),
                      SizedBox(
                        height: AppSize.defaultSize! * 1.5,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.date_range_outlined,
                                color: AppColors.lightGreyColor,
                                size: AppSize.defaultSize! * 2,
                              ),
                              CustomText(
                                text: ' 2004',
                                color: AppColors.thirdColor,
                                fontSize: AppSize.defaultSize! * 1.4,
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Image.asset(
                                AssetPath.employees,
                                scale: 2,
                              ),
                              CustomText(
                                text: ' 51-150',
                                color: AppColors.thirdColor,
                                fontSize: AppSize.defaultSize! * 1.4,
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Image.asset(
                                AssetPath.job,
                                scale: 2,
                              ),
                              CustomText(
                                text: ' 35 jobs',
                                color: AppColors.thirdColor,
                                fontSize: AppSize.defaultSize! * 1.4,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: AppSize.defaultSize! * 2,
              ),
              Material(
                elevation: 10,
                color: Colors.white,
                borderRadius: BorderRadius.circular(AppSize.defaultSize! * 2),
                child: Padding(
                  padding: EdgeInsets.all(AppSize.defaultSize! * 1.5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        text: StringManager.companyBio.tr(),
                        fontWeight: FontWeight.w700,
                        color: AppColors.black,
                      ),
                      SizedBox(
                        height: AppSize.defaultSize! * 1.5,
                      ),
                      CustomText(
                        text:
                            '''HRS is reinventing the way businesses and governments work, stay and pay in today’s dynamic global marketplace. HRS’ advanced platform technology is extending its reach beyond hospitality to meetings, office space management, payment efficiency and crisis recovery. Beyond cost savings in the global post-pandemic economy, HRS clients gain from an unrivaled focus on essential aspects including safety, security and satisfaction. HRS is also recognized for its award-winning Green Stay Initiative, technology that helps corporate hotel programs achieve their NetZero targets, and its groundbreaking Crew & Passengers Solution, which leverages automation to elevate experiences for air and rail operations. Founded in 1972, HRS works with 35 percent of the global Fortune 500, as well as the world’s leading hotel chains, regional hospitality groups and payment providers.''',
                        lineHeight: AppSize.defaultSize! * .2,
                        maxLines: 100,
                        fontSize: AppSize.defaultSize! * 1.2,
                        color: AppColors.primaryColor,
                        textAlign: TextAlign.start,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: AppSize.defaultSize! * 2,
              ),
              CustomText(text: StringManager.anotherSuggestedJobs.tr(),
                fontWeight: FontWeight.w700,
                fontSize: 1.6 * AppSize.defaultSize!,
              ),
              ListView.builder(
                  itemCount: 10,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (item, index) {
                    return Padding(
                      padding: EdgeInsets.symmetric(vertical:AppSize.defaultSize! ),
                      child: const JobCart().animate()
                          .fadeIn() // uses `Animate.defaultDuration`
                          .scale() // inherits duration from fadeIn
                          .move(delay: 300.ms, duration: 600.ms),
                    );
                  }),
            ],
          ),
        ),
      ),
    );
  }

  socialMediaButton({required String asset}) {
    return InkWell(
      child: Container(
        height: AppSize.defaultSize! * 4,
        width: AppSize.defaultSize! * 6,
        decoration: BoxDecoration(
          color: AppColors.lightGreyColor,
          borderRadius: BorderRadius.circular(AppSize.defaultSize! * 1.5),
        ),
        child: Image.asset(
          asset,
          scale: 2,

          // height: AppSize.defaultSize! * 1,
          // width: AppSize.defaultSize! * 1
        ),
      ),
    );
  }
}
