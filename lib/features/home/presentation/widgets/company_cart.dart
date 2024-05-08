import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:inturn/core/resource_manager/asset_path.dart';
import 'package:inturn/core/resource_manager/colors.dart';
import 'package:inturn/core/resource_manager/string_manager.dart';
import 'package:inturn/core/utils/app_size.dart';
import 'package:inturn/core/widgets/cached_network_image.dart';
import 'package:inturn/core/widgets/cutom_text.dart';
import 'package:inturn/core/widgets/main_button.dart';
import 'package:inturn/features/home/data/model/company_model.dart';
import 'package:inturn/features/home/presentation/componants/compony_details.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class CompanyCart extends StatelessWidget {
  const CompanyCart({super.key, this.width, this.description = false, required this.data});

  final double? width;
  final bool description;
  final CompanyModel? data;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        PersistentNavBarNavigator.pushNewScreen(
          context,
          screen: CompanyDetails(data: data!,),
          withNavBar: false,
          // OPTIONAL VALUE. True by default.
          pageTransitionAnimation: PageTransitionAnimation.fade,
        );
      },
      child: Container(
        width: width ?? AppSize.screenWidth! * .8,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(AppSize.defaultSize! * 2),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CachedNetworkCustom(url: data?.profileLogo ?? "",
              width: AppSize.screenWidth,
              height: AppSize.defaultSize! * 8,
            ),

            Padding(
              padding: EdgeInsets.all(AppSize.defaultSize!),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                      text: data?.companyName??"",
                      fontWeight: FontWeight.w500,
                      color: AppColors.thirdColor,
                      fontSize: AppSize.defaultSize! * 1.4),
                  SizedBox(
                    height: AppSize.defaultSize! * 1.5,
                  ),
                  Row(
                    children: [
                      Image.asset(AssetPath.job,
                        scale: 2,
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
      ),
    );
  }
}
