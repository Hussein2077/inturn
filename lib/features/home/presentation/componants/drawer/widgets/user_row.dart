import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:inturn/core/resource_manager/asset_path.dart';
import 'package:inturn/core/resource_manager/routes.dart';
import 'package:inturn/core/resource_manager/string_manager.dart';
import 'package:inturn/core/utils/app_size.dart';

class UserRowDrawer extends StatelessWidget {
  const UserRowDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, Routes.profile);
      },
      child: SizedBox(
        height: AppSize.defaultSize! * 7,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              width: AppSize.defaultSize! * 3.5,
            ),
            CircleAvatar(
              radius: AppSize.defaultSize! * 2,
              backgroundColor: Colors.white,
              child: Image.asset(AssetPath.human),
            ),
            SizedBox(
              width: AppSize.defaultSize! * 2,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Mohamed Ahmed',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: AppSize.defaultSize! * 1.4,
                  ),
                ),
                Text(
                  StringManager.viewProfile.tr(),
                  style: TextStyle(
                    fontSize: AppSize.defaultSize! * 1.2,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
