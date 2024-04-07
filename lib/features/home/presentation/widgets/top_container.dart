import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:inturn/core/resource_manager/asset_path.dart';
import 'package:inturn/core/resource_manager/colors.dart';
import 'package:inturn/core/resource_manager/string_manager.dart';
import 'package:inturn/core/utils/app_size.dart';
import 'package:inturn/core/widgets/custom_text_field.dart';
import 'package:inturn/core/widgets/cutom_text.dart';
import 'package:inturn/core/widgets/main_button.dart';

class TopContainer extends StatefulWidget {
  const TopContainer({super.key});

  @override
  State<TopContainer> createState() => _TopContainerState();
}

class _TopContainerState extends State<TopContainer> {
  @override
  Widget build(BuildContext context) {
    return   Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage(AssetPath.backgroundInturn),
            fit: BoxFit.fill),
      ),
      height: AppSize.defaultSize! * 22,
      width: double.infinity,
      child: Column(children: [
        SizedBox(
          height: AppSize.defaultSize! * 3.5,
        ),
        SvgPicture.asset(AssetPath.logo)
            .animate()
            .fadeIn() // uses `Animate.defaultDuration`
            .scale() // inherits duration from fadeIn
            .move(delay: 300.ms, duration: 600.ms),
        SizedBox(
          height: AppSize.defaultSize!,
        ),
        Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          CustomText(
            text: StringManager.searchForIntern.tr(),
            fontWeight: FontWeight.w700,
            color: AppColors.primaryColor,
            // textAlign: TextAlign.start,
            fontSize: AppSize.defaultSize! * 1.6,
          ),
          SizedBox(
            height: AppSize.defaultSize!,
          ),
          SizedBox(
            width: AppSize.defaultSize! * 30,
            child: CustomText(
              text: StringManager.internInformation.tr(),
              fontSize: AppSize.defaultSize! * 1.4,
              color: AppColors.greyColor,
              maxLines: 2,
              textAlign: TextAlign.start,
            ),
          ),
        ]),
        SizedBox(
          height: AppSize.defaultSize!,
        ),
        CustomTextField(
          hintText: StringManager.searchForJobs.tr(),
          fillColor: Colors.white,
          width: AppSize.screenWidth! * .9,
          hintStyle: TextStyle(
              fontSize: AppSize.defaultSize! * 1.3,
              color: AppColors.greyColor),
          suffixIcon: MainButton(
              text: StringManager.search.tr(),
              width: AppSize.defaultSize! * 10,
              padding: AppSize.defaultSize! * .5,
              onTap: () {}),
        )
      ]),
    );
  }
}
