import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:inturn/core/models/vacancey_model.dart';
import 'package:inturn/core/resource_manager/asset_path.dart';
import 'package:inturn/core/resource_manager/colors.dart';
import 'package:inturn/core/resource_manager/string_manager.dart';
import 'package:inturn/core/utils/app_size.dart';
import 'package:inturn/core/widgets/app_bar.dart';
import 'package:inturn/core/widgets/cached_network_image.dart';
import 'package:inturn/core/widgets/cutom_text.dart';
import 'package:inturn/core/widgets/loading_widget.dart';
import 'package:inturn/features/home/data/model/company_model.dart';
import 'package:inturn/features/home/data/model/matched_model.dart';
import 'package:inturn/features/home/presentation/controller/intern_search_bloc/get_internships_search_bloc.dart';
import 'package:inturn/features/home/presentation/controller/intern_search_bloc/get_internships_search_event.dart';
import 'package:inturn/features/home/presentation/controller/intern_search_bloc/get_internships_search_state.dart';
import 'package:inturn/features/home/presentation/widgets/job_cart.dart';
import 'package:inturn/features/home/presentation/widgets/suggested_view.dart';
import 'package:inturn/features/home/presentation/widgets/suggested_view_in_company.dart';
import 'package:url_launcher/url_launcher.dart';

class CompanyDetails extends StatefulWidget {
  final CompanyModel data;

  const CompanyDetails({super.key, required this.data});

  @override
  State<CompanyDetails> createState() => _CompanyDetailsState();
}

class _CompanyDetailsState extends State<CompanyDetails> {
  @override
  void initState() {
    super.initState();
  }

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
                    CachedNetworkCustom(
                      url: widget.data.coverLogo ?? "",
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
                            backgroundColor: Colors.transparent,
                            child: CachedNetworkCustom(
                              url: widget.data.profileLogo ?? "",
                              width: AppSize.defaultSize!*9.8,
                              height: AppSize.defaultSize! * 9.8,
                            ),
                          ),
                          SizedBox(
                            width: AppSize.defaultSize! * 2,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomText(
                                  text: widget.data.companyName ?? "",
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
                                    text: widget.data.cityName ?? "",
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
                  socialMediaButton(
                      asset: AssetPath.website,

                      onTap: () async {
                        await launchUrl(Uri.parse(widget.data.webSite ?? ""));
                      }),
                  socialMediaButton(
                      asset: AssetPath.facebook2,
                      onTap: () async {
                        await launchUrl(
                            Uri.parse(widget.data.facebookLink ?? ""));
                      }),
                  socialMediaButton(
                      asset: AssetPath.instagram,
                      onTap: () async {
                        await launchUrl(
                            Uri.parse(widget.data.instagramLink ?? ""));
                      }),
                  socialMediaButton(
                      asset: AssetPath.twitter,
                      onTap: () async {
                        await launchUrl(Uri.parse(widget.data.xLink ?? ""));
                      }),
                  socialMediaButton(
                      asset: AssetPath.linkedin,
                      onTap: () async {
                        await launchUrl(
                            Uri.parse(widget.data.linkedInLink ?? ""));
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
                                size: AppSize.defaultSize! * 2.2,
                              ),
                              CustomText(
                                text: widget.data.foundationYear ?? "",
                                color: AppColors.thirdColor,
                                fontSize: AppSize.defaultSize! * 1.4,
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Image.asset(
                                AssetPath.employees,
                                scale: AppSize.defaultSize! * .18,
                              ),
                              CustomText(
                                text: widget.data.countOfEmployees ?? "",
                                color: AppColors.thirdColor,
                                fontSize: AppSize.defaultSize! * 1.4,
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Image.asset(
                                AssetPath.job,
                                scale: AppSize.defaultSize! * .18,
                              ),
                              CustomText(
                                text: ' ${widget.data.jobCount} jobs',
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
                        text: widget.data.bio ?? "",
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
              CustomText(
                text: StringManager.suggestedJobs.tr(),
                fontWeight: FontWeight.w700,
                fontSize: 1.6 * AppSize.defaultSize!,
              ),
              SuggestedInCompanyView(
                companyId: widget.data.companyId ?? 1,
                vacancyId: 0,
              ),
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
          image: DecorationImage(
            scale: AppSize.defaultSize! * .15,
            image: AssetImage(
              asset,
            ),
          )
        ),
      ),
    );
  }
}
