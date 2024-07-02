import 'dart:developer';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:inturn/core/resource_manager/colors.dart';
import 'package:inturn/core/resource_manager/string_manager.dart';
import 'package:inturn/core/utils/app_size.dart';
 import 'package:inturn/core/widgets/cutom_text.dart';

class AcademicYearsDropDown extends StatefulWidget {
  const AcademicYearsDropDown({
    super.key,    this.initValue,
  });
  final String? initValue;
  static String? selectedValue;


  @override
  State<AcademicYearsDropDown> createState() => _AcademicYearsDropDownState();
}

class _AcademicYearsDropDownState extends State<AcademicYearsDropDown> {

@override
  void initState() {
    if(widget.initValue != null){
      AcademicYearsDropDown.selectedValue = widget.initValue;
    }
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return   Container(
      height: AppSize.defaultSize! * 5,
      decoration: BoxDecoration(
          border:
          Border.all(color: AppColors.borderColor.withOpacity(.4)),
          borderRadius: BorderRadius.circular(AppSize.defaultSize! * 2)),
      child: Center(
        child: DropdownButton2<String>(
          value: AcademicYearsDropDown.selectedValue,

          buttonStyleData: ButtonStyleData(
              width: AppSize.screenWidth! * .9,
              decoration: BoxDecoration(
                borderRadius:
                BorderRadius.circular(AppSize.defaultSize! * 2),
              )),
          dropdownStyleData: DropdownStyleData(
              width: AppSize.screenWidth! * .9,
              decoration: BoxDecoration(
                borderRadius:
                BorderRadius.circular(AppSize.defaultSize! * 2),
              ),
              // padding: EdgeInsets.symmetric(horizontal: 10),
              maxHeight: AppSize.screenHeight! * .5),
          underline: const SizedBox(),
          iconStyleData: IconStyleData(
            iconSize: AppSize.defaultSize! * 2.5,
          ),
          onChanged: (String? newValue) {
            log('newValue: $newValue');
            setState(() {
              AcademicYearsDropDown.selectedValue = newValue!;
            });

          },
          hint: Padding(
            padding: EdgeInsets.only(left: AppSize.defaultSize!),
            child: CustomText(
              text: StringManager.academicYear.tr(),
              fontSize: AppSize.defaultSize!,
            ),
          ),

          items: StringManager.academicYears.map<DropdownMenuItem<String>>(
                  (String value) {
                return DropdownMenuItem(
                  value: value,
                  child: Padding(
                    padding: EdgeInsets.only(left: AppSize.defaultSize!),
                    child: Text(
                      value ?? "",
                      style: TextStyle(
                        fontSize: AppSize.defaultSize!,
                      ),
                    ),
                  ),
                );
              }).toList(),
        ),
      ),
    );
  }
}
