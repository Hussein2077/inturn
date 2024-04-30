import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:inturn/core/models/vacancey_model.dart';
import 'package:inturn/core/resource_manager/asset_path.dart';
import 'package:inturn/core/resource_manager/colors.dart';
import 'package:inturn/core/resource_manager/string_manager.dart';
import 'package:inturn/core/utils/app_size.dart';
import 'package:inturn/core/widgets/app_bar.dart';
import 'package:inturn/core/widgets/cutom_text.dart';
import 'package:inturn/features/home/data/model/company_model.dart';
import 'package:inturn/features/home/presentation/widgets/job_cart.dart';
import 'package:url_launcher/url_launcher.dart';

class CompanyDetails extends StatelessWidget {
  final CompanyModel data;
  const CompanyDetails({super.key, required this.data});

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
                                  text: data.companyName??"",
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.black,
                                  fontSize: AppSize.defaultSize! * 1.6),
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
                  socialMediaButton(asset: AssetPath.website, onTap: ()async{
                    await launchUrl(Uri.parse(data.webSite??""));
                  }),
                  socialMediaButton(asset: AssetPath.facebook2, onTap: ()async{
                    await launchUrl(Uri.parse(data.facebookLink??""));
                  }),
                  socialMediaButton(asset: AssetPath.instagram, onTap: ()async{
                    await launchUrl(Uri.parse(data.instagramLink??""));
                  }),
                  socialMediaButton(asset: AssetPath.twitter, onTap: ()async{
                    await launchUrl(Uri.parse(data.xLink??""));
                  }),
                  socialMediaButton(asset: AssetPath.linkedin, onTap: ()async{
                    await launchUrl(Uri.parse(data.linkedInLink??""));
                  }),
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
                                text: data.foundationYear??"",
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
                                text: data.countOfEmployees??"",
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
                        text: data.bio??"",
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
                      child:   JobCart(vacancyModel: VacancyModel(),).animate()
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

  socialMediaButton({required String asset, required Function() onTap}) {
    return InkWell(
      onTap: onTap,
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
