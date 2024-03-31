import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:inturn/core/resource_manager/colors.dart';
import 'package:inturn/core/resource_manager/routes.dart';
import 'package:inturn/core/resource_manager/string_manager.dart';
import 'package:inturn/core/utils/app_size.dart';
import 'package:inturn/core/utils/methods.dart';
import 'package:inturn/core/widgets/drop_down_custom.dart';
import 'package:inturn/features/home/presentation/componants/drawer/widgets/drawer-buttons.dart';
import 'package:inturn/features/home/presentation/componants/drawer/widgets/user_row.dart';
import 'package:inturn/features/main_screen.dart';

class HomeDrawer extends StatefulWidget {
  const HomeDrawer({super.key});

  @override
  State<HomeDrawer> createState() => _HomeDrawerState();
}

class _HomeDrawerState extends State<HomeDrawer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.secondaryBackGroundColor,
      width: AppSize.screenWidth! * .8,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: AppSize.defaultSize! * 3,
          ),
          const UserRowDrawer(),
          const Divider(
            thickness: 1,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: AppSize.defaultSize!),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomDrawerButton(
                  text: StringManager.home.tr(),
                  onPressed: () {
                    MainScreen.mainIndex = 0;
                    Navigator.pushNamedAndRemoveUntil(
                        context, Routes.main, (Route<dynamic> route) => false);
                  },
                ),
                CustomDrawerButton(
                  text: StringManager.jobs.tr(),
                  onPressed: () {
                    MainScreen.mainIndex = 2;
                    Navigator.pushNamedAndRemoveUntil(
                        context, Routes.main, (Route<dynamic> route) => false);
                  },
                ),
                CustomDrawerButton(
                  text: StringManager.companies.tr(),
                  onPressed: () {},
                ),
                CustomDrawerButton(
                  text: StringManager.blog.tr(),
                  onPressed: () {
                    MainScreen.mainIndex = 3;
                    Navigator.pushNamedAndRemoveUntil(
                        context, Routes.main, (Route<dynamic> route) => false);
                  },
                ),
                CustomDrawerButton(
                  text: StringManager.cvBuilder.tr(),
                  onPressed: () {
                    Navigator.pushNamedAndRemoveUntil(
                        context,
                        Routes.cvBuilderScreen,
                        (Route<dynamic> route ) => false);
                  },
                ),
                CustomDrawerButton(
                  text: StringManager.myApplications.tr(),
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.pushNamed(context, Routes.myApplications);
                  },
                ),
                CustomDropdownButton2(
                  hint: StringManager.options.tr(),
                  value: null,
                  buttonDecoration: BoxDecoration(
                    border: Border.all(color: Colors.transparent),
                  ),
                  // dropdownWidth: AppSize.screenWidth! * .71,
                  dropdownElevation: 0,
                  buttonWidth: AppSize.screenWidth! * .75,
                  dropdownItems: [
                    StringManager.search.tr(),
                    StringManager.contactUs.tr(),
                  ],
                  dropdownDecoration: const BoxDecoration(
                    color: AppColors.secondaryBackGroundColor,
                  ),
                  icon: const Icon(
                    Icons.keyboard_arrow_down_rounded,
                    color: AppColors.greyColor,
                  ),
                  iconEnabledColor: AppColors.black,
                  onChanged: (String? value) {
                    switch (value) {
                      case StringManager.search:
                        // Navigator.pushNamed(context, Routes.search);
                        break;
                      case StringManager.contactUs:
                        Navigator.pop(context);
                        Navigator.pushNamed(context, Routes.contactUs);
                        break;
                      default:
                        //do nothing
                        break;
                    }
                  },
                ),
              ],
            ),
          ),
          const Spacer(),
          InkWell(
            onTap: () {
              Methods.instance.saveUserToken(authToken: null);
              Navigator.pushNamed(context, Routes.login);
            },
            child: Center(
              child: Container(
                height: AppSize.defaultSize! * 4,
                width: AppSize.screenWidth! * .6,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                        BorderRadius.circular(AppSize.defaultSize! * .5),
                    border: Border.all(color: AppColors.primaryColor)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.logout,
                      color: AppColors.primaryColor,
                      size: AppSize.defaultSize! * 1.5,
                    ),
                    SizedBox(
                      width: AppSize.defaultSize!,
                    ),
                    Text(
                      StringManager.logOut.tr(),
                      style: TextStyle(
                        color: AppColors.primaryColor,
                        fontWeight: FontWeight.w600,
                        fontSize: AppSize.defaultSize! * 1.2,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            height: AppSize.screenHeight! * .05,
          ),
        ],
      ),
    );
  }
}
