import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:inturn/core/resource_manager/asset_path.dart';
import 'package:inturn/core/resource_manager/colors.dart';
import 'package:inturn/core/resource_manager/routes.dart';
import 'package:inturn/core/resource_manager/string_manager.dart';
import 'package:inturn/core/service/navigator_services.dart';
import 'package:inturn/core/service/service_locator.dart';
import 'package:inturn/core/utils/app_size.dart';
import 'package:inturn/core/utils/methods.dart';
import 'package:inturn/core/widgets/cutom_text.dart';
import 'package:inturn/core/widgets/snack_bar.dart';
import 'package:inturn/features/auth/presentation/controller/login_bloc/login_with_email_and_password_bloc.dart';
import 'package:inturn/features/auth/presentation/controller/login_bloc/login_with_email_and_password_events.dart';
import 'package:inturn/features/auth/presentation/controller/login_bloc/login_with_email_and_password_states.dart';
import 'package:inturn/features/profile/presentation/component/change_password/change_password_screen.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';

AppBar appBar(BuildContext context,
    {required String text,
    bool leading = true,
    bool actions = false,
    Widget? leadingIcon}) {
  return AppBar(
    backgroundColor: Colors.white,
    elevation: 1,
    title: CustomText(
        text: text,
        fontSize: AppSize.defaultSize! * 2,
        fontWeight: FontWeight.w500),
    centerTitle: true,
    leading: leading
        ? leadingIcon ??
            IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Transform.rotate(
                  angle: 180 * 3.14 / 180,
                  child: Image.asset(
                    AssetPath.leading,
                    height: AppSize.defaultSize! * 2.5,
                    width: AppSize.defaultSize! * 2.5,
                  ),
                ))
        : null,
    actions: actions
        ? [
            IconButton(
                onPressed: () async {
                  await Methods.instance.saveUserToken(authToken: null);
                  SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                  await prefs.clear();

                  Navigator.of(getIt<NavigationService>()
                          .navigatorKey
                          .currentContext!)
                      .pushNamedAndRemoveUntil(
                          Routes.login, (Route<dynamic> route) => false);
                },
                icon: Icon(
                  Icons.logout,
                  size: AppSize.defaultSize! * 2,
                ))
          ]
        : null,
  );
}

AppBar profileAppBar(BuildContext context,
    {required String text,
    bool leading = true,
    bool actions = false,
    Widget? leadingIcon}) {
  return AppBar(
    backgroundColor: Colors.white,
    elevation: 1,
    title: CustomText(
        text: text,
        fontSize: AppSize.defaultSize! * 2,
        fontWeight: FontWeight.w500),
    centerTitle: true,
    leading: leading
        ? leadingIcon ??
            IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Transform.rotate(
                  angle: 180 * 3.14 / 180,
                  child: Image.asset(
                    AssetPath.leading,
                    height: AppSize.defaultSize! * 2.5,
                    width: AppSize.defaultSize! * 2.5,
                  ),
                ))
        : null,
    actions: actions
        ? [
            IconButton(
              icon: const Icon(Icons.settings),
              onPressed: () {
                _showSettingsDialog(context);
              },
            ),
          ]
        : null,
  );
}

AppBar homeAppBar(BuildContext context,
    {String? text, void Function()? actionsOnPressed, Widget? widget}) {
  return AppBar(
    backgroundColor: Colors.white,
    elevation: 1,
    title: widget ??
        CustomText(
            text: '$text',
            fontSize: AppSize.defaultSize! * 2,
            fontWeight: FontWeight.w500),
    centerTitle: true,
    leading: IconButton(
      onPressed: () {
        Scaffold.of(context).openDrawer();
      },
      icon: Image.asset(
        AssetPath.menu,
        width: AppSize.defaultSize! * 2,
        height: AppSize.defaultSize! * 2,
      ),
    ),
    actions: [
      IconButton(
        onPressed: actionsOnPressed,
        icon: Image.asset(
          AssetPath.notification,
          width: AppSize.defaultSize! * 2,
          height: AppSize.defaultSize! * 2,
        ),
      )
    ],
  );
}

void _showSettingsDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Settings'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: Image.asset(
                AssetPath.changePassword,
                width: AppSize.defaultSize! * 2.5,
                height: AppSize.defaultSize! * 2.5,
              ),
              title: CustomText(
                text: StringManager.changePassword.tr(),
                color: AppColors.primaryColor,
                fontSize: AppSize.defaultSize! * 1.4,
                fontWeight: FontWeight.bold,
              ),
              onTap: () {
                Navigator.of(context).pop();
                PersistentNavBarNavigator.pushNewScreen(
                  context,
                  screen: const ChangePasswordScreen(),
                  withNavBar: false,
                  pageTransitionAnimation: PageTransitionAnimation.fade,
                );
                // Implement your change password functionality here
              },
            ),
            ListTile(
              leading: Icon(
                Icons.logout,
                size: AppSize.defaultSize! * 2,
              ),
              title: CustomText(
                text: StringManager.logOut.tr(),
                color: AppColors.primaryColor,
                fontSize: AppSize.defaultSize! * 1.4,
                fontWeight: FontWeight.bold,
              ),
              onTap: () async {
                Navigator.of(context).pop();
                _showLogoutConfirmationDialog(context);
              },
            ),
            BlocListener<LoginWithEmailAndPasswordBloc,
                LoginWithEmailAndPasswordState>(
              listener: (context, state) {
                if (state is DeleteAccountSuccessMessageState) {
                  EasyLoading.dismiss();
                  successSnackBar(context, state.successMessage);
                  Future.delayed(const Duration(milliseconds: 5), () async {
                    await Methods.instance.saveUserToken(authToken: null);
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    await prefs.clear();
                  });
                  Navigator.of(getIt<NavigationService>()
                          .navigatorKey
                          .currentContext!)
                      .pushNamedAndRemoveUntil(
                          Routes.login, (Route<dynamic> route) => false);
                } else if (state is DeleteAccountErrorMessageState) {
                  EasyLoading.dismiss();
                  errorSnackBar(context, state.errorMessage);
                } else if (state is DeleteAccountLoadingState) {
                  EasyLoading.show();
                }
              },
              child: ListTile(
                leading: const Icon(Icons.delete),
                title: CustomText(
                  text: StringManager.deleteAccount.tr(),
                  color: AppColors.primaryColor,
                  fontSize: AppSize.defaultSize! * 1.4,
                  fontWeight: FontWeight.bold,
                ),
                onTap: () async {
                  Navigator.of(context).pop();
                  BlocProvider.of<LoginWithEmailAndPasswordBloc>(context)
                      .add(DeleteAccountEvent());
                },
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            child: Text('Cancel'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

void _showLogoutConfirmationDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: CustomText(
          text: StringManager.confirmLogout.tr(),
          color: AppColors.primaryColor,
          fontSize: AppSize.defaultSize! * 1.4,
          fontWeight: FontWeight.bold,
        ),
        content: CustomText(
          text: StringManager.areYouSureLogout.tr(),
          color: AppColors.primaryColor,
          fontSize: AppSize.defaultSize! * 1.3,
          fontWeight: FontWeight.normal,
        ),
        actions: [
          TextButton(
            child: CustomText(
              text: StringManager.cancel.tr(),
              color: AppColors.primaryColor,
              fontSize: AppSize.defaultSize! * 1.4,
              fontWeight: FontWeight.bold,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: CustomText(
              text: StringManager.logOut.tr(),
              color: AppColors.primaryColor,
              fontSize: AppSize.defaultSize! * 1.4,
              fontWeight: FontWeight.bold,
            ),
            onPressed: () async {
              Navigator.of(context).pop();
              await Methods.instance.saveUserToken(authToken: null);
              SharedPreferences prefs = await SharedPreferences.getInstance();
              await prefs.clear();

              Navigator.of(
                      getIt<NavigationService>().navigatorKey.currentContext!)
                  .pushNamedAndRemoveUntil(
                      Routes.login, (Route<dynamic> route) => false);
            },
          ),
        ],
      );
    },
  );
}
