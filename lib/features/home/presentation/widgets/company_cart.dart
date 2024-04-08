import 'package:flutter/material.dart';
import 'package:inturn/core/resource_manager/asset_path.dart';
import 'package:inturn/core/resource_manager/colors.dart';
import 'package:inturn/core/utils/app_size.dart';
import 'package:inturn/core/widgets/cutom_text.dart';

class CompanyCart extends StatelessWidget {
  const CompanyCart({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: AppSize.screenWidth! * .8,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppSize.defaultSize! * 2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            child: Image.asset(
              AssetPath.test2,
              fit: BoxFit.fitWidth,
              width: AppSize.screenWidth,
            ),
          ),
         Padding(
           padding:   EdgeInsets.all(AppSize.defaultSize!),
           child: Column(
             crossAxisAlignment: CrossAxisAlignment.start,
             children: [
               CustomText(
                   text: 'HRS Group',
                   fontWeight: FontWeight.w500,
                   color: AppColors.thirdColor,
                   fontSize: AppSize.defaultSize! * 1.4),
               CustomText(
                   text: 'Software Development',
                   color: AppColors.greyColor,
                   fontSize: AppSize.defaultSize! * 1.2),
               SizedBox(
                 height: AppSize.defaultSize! * 1.5,
               ),
               Row(
                 children: [
                   Icon(Icons.shopping_bag_sharp,
                     size: AppSize.defaultSize! * 2,
                   ),
                   CustomText(
                     text: '35 jobs',
                     color: AppColors.thirdColor,
                     fontSize:  AppSize.defaultSize! * 1.4,
                   )
                 ],
               )
             ],
           ),
         )
        ],
      ),
    );
  }
}
