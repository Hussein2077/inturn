import 'package:flutter/material.dart';
import 'package:inturn/core/resource_manager/asset_path.dart';
import 'package:inturn/core/utils/app_size.dart';

AppBar appBar(BuildContext context, {required String text,bool leading =true,List<Widget>? actions}) {
  return AppBar(
    backgroundColor: Colors.white,
    elevation: 1,
    title: Text(text,  style: TextStyle(fontSize: AppSize.defaultSize!*2,fontWeight: FontWeight.w500),),
    centerTitle: true,
    leading:leading? IconButton(
      onPressed: () {
        Navigator.pop(context);
      },
      icon: const Icon(Icons.arrow_back_ios),
    ):null,
    actions: actions,
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
          style: TextStyle(fontSize: AppSize.defaultSize!*2,fontWeight: FontWeight.w500),
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
