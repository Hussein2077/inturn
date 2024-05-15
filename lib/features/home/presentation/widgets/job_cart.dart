import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:inturn/core/models/vacancey_model.dart';
import 'package:inturn/core/resource_manager/asset_path.dart';
import 'package:inturn/core/resource_manager/colors.dart';
import 'package:inturn/core/resource_manager/string_manager.dart';
import 'package:inturn/core/utils/app_size.dart';
import 'package:inturn/core/widgets/cached_network_image.dart';
import 'package:inturn/core/widgets/cutom_text.dart';
import 'package:inturn/core/widgets/main_button.dart';
import 'package:inturn/features/home/data/model/matched_model.dart';
import 'package:inturn/features/home/presentation/componants/job_details.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class JobCart extends StatefulWidget {
  const JobCart(
      {super.key,
      this.linearCircle = true,
      this.skillRequired,
      this.height,
      required this.vacancyModel});

  final bool linearCircle;
  final Widget? skillRequired;
  final double? height;

  final MatchedVacancyWrapper vacancyModel;

  @override
  State<JobCart> createState() => _JobCartState();
}

class _JobCartState extends State<JobCart> {
  double percent = 0.0;

  @override
  void initState() {
    if (widget.linearCircle) {
      percent = (widget.vacancyModel.matchmakingPercentage) / 100;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        PersistentNavBarNavigator.pushNewScreen(
          context,
          screen: JobDetailsScreen(
            matchedVacancyWrapper: widget.vacancyModel,
          ),
          withNavBar: false,
          pageTransitionAnimation: PageTransitionAnimation.fade,
        );
      },
      child: SizedBox(
        width: AppSize.screenWidth,
        height: widget.height,
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
                        text: widget.vacancyModel.matchedVacancy.title ?? "",
                        fontWeight: FontWeight.w700,
                        color: AppColors.primaryColor,
                        // textAlign: TextAlign.start,
                        fontSize: AppSize.defaultSize! * 1.6,
                      ),
                      Row(children: [
                        CachedNetworkCustom(
                          height: AppSize.defaultSize! * 3,
                          width: AppSize.defaultSize! * 3,
                          url: widget.vacancyModel.matchedVacancy.company
                                  ?.profileLogo! ??
                              "",
                        ),
                        SizedBox(
                          width: AppSize.defaultSize! * .5,
                        ),
                        CustomText(
                          text: widget.vacancyModel.matchedVacancy.company
                                  ?.companyName ??
                              "",
                          fontWeight: FontWeight.w500,
                          color: AppColors.primaryColor,
                          // textAlign: TextAlign.start,
                          fontSize: AppSize.defaultSize! * 1.4,
                        ),
                      ]),
                      Row(children: [
                        Image.asset(
                          AssetPath.location,
                          height: AppSize.defaultSize! * 2,
                          width: AppSize.defaultSize! * 2,
                        ),
                        SizedBox(
                          width: AppSize.defaultSize! * .5,
                        ),
                        CustomText(
                          text: widget.vacancyModel.matchedVacancy.cityName! ??
                              "",
                          color: AppColors.greyColor,
                          // textAlign: TextAlign.start,
                          fontSize: AppSize.defaultSize! * 1.4,
                        ),
                        SizedBox(
                          width: AppSize.defaultSize! * 2,
                        ),
                        MainButton(
                          text: widget.vacancyModel.matchedVacancy
                                      .vacancyLevelId ==
                                  1
                              ? StringManager.internship.tr()
                              : StringManager.fullTime.tr(),
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
                      widget.skillRequired ?? const SizedBox(),
                      CustomText(
                        text: widget
                                .vacancyModel.matchedVacancy.responsibilities ??
                            "",
                        maxLines: 10,
                        textAlign: TextAlign.start,
                        color: AppColors.blackColor,
                        fontSize: AppSize.defaultSize! * 1.2,
                      ),
                    ]),
              ),
              widget.linearCircle
                  ? LinearPercentIndicator(
                      // width: AppSize.screenWidth!*.88,
                      animation: true,
                      lineHeight: AppSize.defaultSize! * 2.5,
                      animationDuration: 2000,
                      percent: percent,
                      padding: EdgeInsets.zero,
                      barRadius: Radius.circular(AppSize.defaultSize! * 2),
                      center: CustomText(
                        text:
                            "${widget.vacancyModel.matchmakingPercentage.toString().contains('.') ? widget.vacancyModel.matchmakingPercentage.toString().substring(0, 5) : widget.vacancyModel.matchmakingPercentage}% ${StringManager.matched.tr()}",
                        fontSize: AppSize.defaultSize! * 1.3,
                        color: Colors.white,
                      ),
                      linearStrokeCap: LinearStrokeCap.butt,
                      progressColor:
                          percent >= .5 ? Colors.green : Colors.yellow,
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
                            color: widget.vacancyModel.matchedVacancy
                                        .vacancyLevelId !=
                                    1
                                ? AppColors.homeColor
                                : AppColors.greyColor,
                          ),
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
                          decoration: BoxDecoration(
                            color: (widget.vacancyModel.matchedVacancy
                                            .vacancyLevelId ==
                                        5 ||
                                    widget.vacancyModel.matchedVacancy
                                            .vacancyLevelId ==
                                        2)
                                ? AppColors.yellowColor
                                : AppColors.greyColor,
                          ),
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
                            color: widget.vacancyModel.matchedVacancy
                                        .vacancyLevelId ==
                                    2
                                ? Colors.green
                                : widget.vacancyModel.matchedVacancy
                                            .vacancyLevelId ==
                                        3
                                    ? Colors.red
                                    : AppColors.greyColor,
                          ),
                          child: Center(
                            child: CustomText(
                              text: widget.vacancyModel.matchedVacancy
                                          .vacancyLevelId ==
                                      3
                                  ? StringManager.rejected.tr()
                                  : StringManager.selection.tr(),
                              color: Colors.white,
                              fontSize: AppSize.defaultSize! * 1.3,
                            ),
                          ),
                        ),
                      ],
                    ),

              // Row(
              //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //         children: [
              //           Container(
              //             width: AppSize.defaultSize! * 10,
              //             height: AppSize.defaultSize! * 2.4,
              //             decoration: BoxDecoration(
              //                 borderRadius: BorderRadius.only(
              //                   topLeft:
              //                       Radius.circular(AppSize.defaultSize! * 2),
              //                   bottomLeft:
              //                       Radius.circular(AppSize.defaultSize! * 2),
              //                 ),
              //                 color: widget.vacancyModel.matchedVacancy
              //                             .vacancyLevelId ==
              //                         1
              //                     ? AppColors.homeColor
              //                     : AppColors.greyColor),
              //             child: Center(
              //               child: CustomText(
              //                 text: StringManager.viewed.tr(),
              //                 color: Colors.white,
              //                 fontSize: AppSize.defaultSize! * 1.3,
              //               ),
              //             ),
              //           ),
              //           Container(
              //             width: AppSize.defaultSize! * 10,
              //             height: AppSize.defaultSize! * 2.4,
              //             decoration:
              //                 const BoxDecoration(color: AppColors.greyColor),
              //             child: Center(
              //               child: CustomText(
              //                 text: StringManager.shortlist.tr(),
              //                 color: Colors.white,
              //                 fontSize: AppSize.defaultSize! * 1.3,
              //               ),
              //             ),
              //           ),
              //           Container(
              //             width: AppSize.defaultSize! * 10,
              //             height: AppSize.defaultSize! * 2.4,
              //             decoration: BoxDecoration(
              //                 borderRadius: BorderRadius.only(
              //                   topRight:
              //                       Radius.circular(AppSize.defaultSize! * 2),
              //                   bottomRight:
              //                       Radius.circular(AppSize.defaultSize! * 2),
              //                 ),
              //                 color: AppColors.greyColor),
              //             child: Center(
              //               child: CustomText(
              //                 text: StringManager.selection.tr(),
              //                 color: Colors.white,
              //                 fontSize: AppSize.defaultSize! * 1.3,
              //               ),
              //             ),
              //           ),
              //         ],
              //       ),
              if (!widget.linearCircle)
                SizedBox(
                  height: AppSize.defaultSize! * 1.2,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
