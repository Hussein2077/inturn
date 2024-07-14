import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:inturn/core/resource_manager/asset_path.dart';
import 'package:inturn/core/resource_manager/routes.dart';
import 'package:inturn/core/service/navigator_services.dart';
import 'package:inturn/core/service/service_locator.dart';
import 'package:inturn/core/utils/app_size.dart';
import 'package:inturn/core/utils/methods.dart';
import 'package:inturn/features/auth/presentation/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

AppBar appBar(BuildContext context,
    {required String text, bool leading = true, bool actions = false, Widget? leadingIcon}) {
  return AppBar(
    backgroundColor: Colors.white,
    elevation: 1,
    title: Text(
      text,
      style: TextStyle(
          fontSize: AppSize.defaultSize! * 2, fontWeight: FontWeight.w500),
    ),
    centerTitle: true,
    leading: leading
        ? leadingIcon ?? IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Transform.rotate(
              angle: 180 * 3.14 / 180,

              child: Image.asset(AssetPath.leading,
                  height: AppSize.defaultSize! * 2.5,
                  width: AppSize.defaultSize! * 2.5,
              ),
            )
          )
        : null,
    actions: actions
        ? [
            IconButton(
                onPressed: () async {

                  await Methods.instance.saveUserToken(authToken: null);
                  SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                  await prefs.clear();

                  // PersistentNavBarNavigator.pushNewScreen(
                  //   getIt<NavigationService>().navigatorKey.currentContext!,
                  //   screen: const LoginScreen(),
                  //   withNavBar: false,
                  //   // OPTIONAL VALUE. True by default.
                  //   pageTransitionAnimation: PageTransitionAnimation.fade,
                  // );
                  Navigator.of(getIt<NavigationService>()
                          .navigatorKey
                          .currentContext!)
                      .pushNamedAndRemoveUntil(
                          Routes.login, (Route<dynamic> route) => false);
                },
                icon:   Icon(Icons.logout,size: AppSize.defaultSize!*2,))
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
        Text(
          '$text',
          style: TextStyle(
              fontSize: AppSize.defaultSize! * 2, fontWeight: FontWeight.w500),
        ),
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
/*
 AppBar(
          leading: IconButton(
            icon: const Icon(
              Icons.menu,
              color: AppColors.primaryColor,
            ),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          ),
          title: Image.asset(AssetPath.logo,scale: 3,),
          centerTitle: true,
          actions: [
            IconButton(
              icon: const Icon(
                Icons.notifications,
                color: AppColors.primaryColor,
              ),
              onPressed: () {},
            ),
          ],
        ),
 */
