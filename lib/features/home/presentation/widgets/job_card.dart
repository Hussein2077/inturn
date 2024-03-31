import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:inturn/core/models/vacancey_model.dart';
import 'package:inturn/core/resource_manager/asset_path.dart';
import 'package:inturn/core/resource_manager/colors.dart';
import 'package:inturn/core/resource_manager/string_manager.dart';
import 'package:inturn/core/utils/app_size.dart';
import 'package:inturn/core/widgets/vacancy_details.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class JobCard extends StatefulWidget {
  const JobCard({
    Key? key,
    required this.jobSlider,
  }) : super(key: key);
  final VacancyModel jobSlider;

  @override
  State<JobCard> createState() => _JobCardState();
}

class _JobCardState extends State<JobCard> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        PersistentNavBarNavigator.pushNewScreen(
          context,
          screen: VacancyDetails(vacancyModel: widget.jobSlider),
          withNavBar: false,
          // OPTIONAL VALUE. True by default.
          pageTransitionAnimation: PageTransitionAnimation.fade,
        );
      },
      child: Container(
        height: AppSize.screenHeight! * .2,
        width: AppSize.screenWidth,
        color: AppColors.containerColor,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.all(AppSize.defaultSize! * 2),
              child: SizedBox(
                height: AppSize.defaultSize! * 6,
                width: AppSize.defaultSize! * 6,
                child: Image.asset(
                  AssetPath.slogan,
                  height: AppSize.defaultSize! * 8,
                  width: AppSize.defaultSize! * 8,
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: AppSize.defaultSize!,
                  ),
                  child: Text(
                    widget.jobSlider.name ?? "",
                    style: TextStyle(
                        color: AppColors.primaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: AppSize.defaultSize! * 1.5),
                  ),
                ),
                Row(
                  children: [
                    Text(
                      widget.jobSlider.createDate!.substring(0, 10),
                      style: TextStyle(
                          color: AppColors.greyColor,
                          fontWeight: FontWeight.w600,
                          fontSize: AppSize.defaultSize! * 1.2),
                    ),
                    SizedBox(
                      width: AppSize.defaultSize!,
                    ),
                    Text(
                      widget.jobSlider.type!,
                      style: TextStyle(
                          color: AppColors.black,
                          fontWeight: FontWeight.w600,
                          fontSize: AppSize.defaultSize! * 1.2),
                    ),
                  ],
                ),
                // SizedBox(height: AppSize.defaultSize!*.3,),
                Text(
                  widget.jobSlider.provinceName ?? "",
                  style: TextStyle(
                      color: AppColors.mainFontColor,
                      fontSize: AppSize.defaultSize! * 1.4),
                ),
                SizedBox(
                  height: AppSize.defaultSize! * .3,
                ),
                Text(
                  widget.jobSlider.major ?? "",
                  style: TextStyle(
                      color: AppColors.mainFontColor,
                      fontSize: AppSize.defaultSize! * 1.4),
                ),
                SizedBox(
                  height: AppSize.defaultSize! * .3,
                ),
                Text(
                  '${widget.jobSlider.minSalary ?? 1000} EGP - ${widget.jobSlider.maxSalary ?? 5000} EGP',
                  style: TextStyle(
                      color: AppColors.mainFontColor,
                      fontSize: AppSize.defaultSize! * 1.4),
                ),
                SizedBox(
                  height: AppSize.screenHeight! * .02,
                ),
                Padding(
                  padding: EdgeInsets.all(AppSize.defaultSize! * .6),
                  child: InkWell(
                    onTap: () {},
                    child: Container(
                        height: AppSize.screenHeight! * .05,
                        width: AppSize.screenWidth! * .4,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(
                                AppSize.defaultSize! * .5),
                            border: Border.all(color: AppColors.primaryColor)),
                        child: Center(
                          child: Text(
                            StringManager.viewJob.tr(),
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: AppSize.defaultSize! * 1.4,
                            ),
                          ),
                        )),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
