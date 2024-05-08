import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:inturn/core/resource_manager/colors.dart';
import 'package:inturn/core/resource_manager/string_manager.dart';
import 'package:inturn/core/utils/app_size.dart';
import 'package:inturn/core/widgets/app_bar.dart';
import 'package:inturn/core/widgets/area_drop_down.dart';

class FiltersScreen extends StatefulWidget {
  const FiltersScreen({super.key});

  static int? careerLevel;
  static int? workPlace;

  @override
  State<FiltersScreen> createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {

  List<Map> careerLevel = [
    {"name": StringManager.all.tr(), "isChecked": true, "id": 0},
    {"name": StringManager.internship.tr(), "isChecked": false, "id": 1},
    {"name": StringManager.freshGraduate.tr(), "isChecked": false, "id": 2},
  ];

  List<Map> workPlace = [
    {"name": StringManager.all.tr(), "isChecked": true, "id": 0},
    {"name": StringManager.onSite.tr(), "isChecked": false, "id": 1},
    {"name": StringManager.remotely.tr(), "isChecked": false, "id": 2},
    {"name": StringManager.hybrid.tr(), "isChecked": false, "id": 3},
  ];

  @override
  Widget build(BuildContext context) {
    log('${FiltersScreen.workPlace}huss ${FiltersScreen.careerLevel}');
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appBar(context, text: StringManager.filterResults.tr()),
      body: Padding(
        padding: EdgeInsets.all(AppSize.defaultSize!),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(StringManager.city.tr(), style: TextStyle(fontWeight: FontWeight.bold, fontSize: AppSize.defaultSize! * 1.7),),
            Padding(
              padding: EdgeInsets.symmetric(vertical: AppSize.defaultSize! * 2,),
              child: const Center(child: CitiesDropDown(showCountry: false,)),
            ),
            Container(
              color: AppColors.breakLineColor,
              width: AppSize.screenWidth!,
              height: 1,
            ),

            Padding(
              padding: EdgeInsets.symmetric(vertical: AppSize.defaultSize! * 2,),
              child: Text(StringManager.careerLevel.tr(), style: TextStyle(fontWeight: FontWeight.bold, fontSize: AppSize.defaultSize! * 1.7),),
            ),

            Column(
              children: List.generate(
                careerLevel.length,
                    (index) => CheckboxListTile(
                  controlAffinity: ListTileControlAffinity.leading,
                  contentPadding: EdgeInsets.zero,
                      checkboxShape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5)),
                      checkColor: AppColors.secondaryColor,
                      activeColor: AppColors.primaryColor,
                  dense: true,
                  title: Text(
                    careerLevel[index]["name"],
                    style: const TextStyle(
                      fontSize: 16.0,
                      color: Colors.black,
                    ),
                  ),
                  value: careerLevel[index]["isChecked"],
                  onChanged: (value) {
                    setState(() {
                      for (var element in careerLevel) {
                        element["isChecked"] = false;
                      }
                      FiltersScreen.careerLevel = careerLevel[index]["id"];
                      careerLevel[index]["isChecked"] = value;
                    });
                  },
                ),
              ),
            ),

            SizedBox(height: AppSize.defaultSize!,),

            Container(
              color: AppColors.breakLineColor,
              width: AppSize.screenWidth!,
              height: 1,
            ),

            Padding(
              padding: EdgeInsets.symmetric(vertical: AppSize.defaultSize! * 2,),
              child: Text(StringManager.workplace.tr(), style: TextStyle(fontWeight: FontWeight.bold, fontSize: AppSize.defaultSize! * 1.7),),
            ),

            Column(
              children: List.generate(
                workPlace.length,
                    (index) => CheckboxListTile(
                  controlAffinity: ListTileControlAffinity.leading,
                  contentPadding: EdgeInsets.zero,
                  checkboxShape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5)),
                  checkColor: AppColors.secondaryColor,
                  activeColor: AppColors.primaryColor,
                  dense: true,
                  title: Text(
                    workPlace[index]["name"],
                    style: const TextStyle(
                      fontSize: 16.0,
                      color: Colors.black,
                    ),
                  ),
                  value: workPlace[index]["isChecked"],
                  onChanged: (value) {
                    setState(() {
                      for (var element in workPlace) {
                        element["isChecked"] = false;
                      }
                      FiltersScreen.workPlace = workPlace[index]["id"];
                      workPlace[index]["isChecked"] = value;
                    });
                  },
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}
