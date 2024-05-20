import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:inturn/core/resource_manager/asset_path.dart';
import 'package:inturn/core/resource_manager/colors.dart';
import 'package:inturn/core/resource_manager/routes.dart';
import 'package:inturn/core/resource_manager/string_manager.dart';
import 'package:inturn/core/utils/app_size.dart';
import 'package:inturn/core/widgets/app_bar.dart';
import 'package:inturn/core/widgets/cutom_text.dart';
import 'package:inturn/core/widgets/main_button.dart';
import 'package:inturn/main.dart';

class ThanksScreen extends StatelessWidget {
  const ThanksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: AppSize.screenHeight,
        width: AppSize.screenWidth,
        child: Stack(
          children: [
            SvgPicture.asset(
              AssetPath.done,
              height: AppSize.screenHeight,
              width: AppSize.screenWidth,
              fit: BoxFit.cover
              ,
            ),
            Padding(
              padding: EdgeInsets.only(bottom: AppSize.defaultSize! * 15),
              child: Align(
                alignment: Alignment.center,
                child: CustomText(
                  text: StringManager.profileCompleted(''),
                  color: Colors.white,
                  fontSize: AppSize.defaultSize! * 2.5,
                  fontWeight: FontWeight.w900,
                  maxLines: 2,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: AppSize.defaultSize! * 15),
              child: Align(
                  alignment: Alignment.center,
                  child: MainButton(
                    text: StringManager.discoverInternships.tr(),
                    color: Colors.white,
                    textColor: AppColors.black,
                    fontSize: AppSize.defaultSize! * 1.8,
                    fontWeight: FontWeight.w500,
                    onTap: () {
                      Navigator.pushNamedAndRemoveUntil(context, Routes.main,(route) => false,
                      arguments: MyApp.userId
                      );
                    },
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
