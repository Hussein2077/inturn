import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:inturn/core/resource_manager/asset_path.dart';
import 'package:inturn/core/resource_manager/colors.dart';
import 'package:inturn/core/resource_manager/string_manager.dart';
import 'package:inturn/core/utils/app_size.dart';
import 'package:inturn/core/widgets/app_bar.dart';
import 'package:inturn/core/widgets/custom_text_field.dart';
import 'package:inturn/core/widgets/main_button.dart';

class ContactUS extends StatefulWidget {
  const ContactUS({super.key});

  @override
  State<ContactUS> createState() => _ContactUSState();
}

class _ContactUSState extends State<ContactUS> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context, text: StringManager.contactUs.tr()),
      body: Padding(
        padding: EdgeInsets.all(AppSize.defaultSize! * 1.6),
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                CustomTextField(
                  hintText: StringManager.subject.tr(),
                  controller: TextEditingController(),
                  hintStyle: TextStyle(
                      color: AppColors.borderColor,
                      fontSize: AppSize.defaultSize!*1.4 ),
                ),
                // SizedBox(
                //   height: AppSize.defaultSize!,
                // ),
                CustomTextField(
                  hintText: StringManager.message.tr(),
                  height: AppSize.defaultSize! * 10,
                  maxLines: 10,
                  hintStyle: TextStyle(
                      color: AppColors.borderColor,
                      fontSize: AppSize.defaultSize! * 1.4),
                ),
                SizedBox(
                  height: AppSize.defaultSize! * 2.5,
                ),
                MainButton(text: StringManager.send.tr()),
                SizedBox(
                  height: AppSize.defaultSize! * 5,
                ),
                Text(
                  'Our Offices',
                  style: TextStyle(
                      fontSize: AppSize.defaultSize! * 2.5,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primaryColor),
                )
                    .animate()
                    .fadeIn() // uses `Animate.defaultDuration`
                    .scale() // inherits duration from fadeIn
                    .move(delay: 300.ms, duration: 800.ms),
                Text(
                  'Find our offices around the world!',
                  style: TextStyle(
                      fontSize: AppSize.defaultSize! * 1.4,
                      fontWeight: FontWeight.w400,
                      color: AppColors.black),
                )
                    .animate()
                    .fadeIn() // uses `Animate.defaultDuration`
                    .scale() // inherits duration from fadeIn
                    .move(delay: 300.ms, duration: 600.ms),
                SizedBox(
                  height: AppSize.defaultSize! * 2,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(AssetPath.lolipop),
                    SizedBox(
                      width: AppSize.defaultSize! *.7,
                    ),
                    Text(
                      'Copenhagen',
                      style: TextStyle(
                          fontSize: AppSize.defaultSize! * 1.8,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primaryColor),
                    )
                        .animate()
                        .fadeIn() // uses `Animate.defaultDuration`
                        .scale() // inherits duration from fadeIn
                        .move(delay: 300.ms, duration: 800.ms),
            
                  ],
                ),
                Text(
                  'Frederiksberg, Nordhavn, Sydhavn',
                  style: TextStyle(
                      fontSize: AppSize.defaultSize! * 1.4,
                      fontWeight: FontWeight.w400,
                      color: AppColors.black),
                )
                    .animate()
                    .fadeIn() // uses `Animate.defaultDuration`
                    .scale() // inherits duration from fadeIn
                    .move(delay: 300.ms, duration: 600.ms),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
