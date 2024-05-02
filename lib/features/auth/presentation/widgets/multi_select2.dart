
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:inturn/core/resource_manager/colors.dart';
import 'package:inturn/core/utils/app_size.dart';
import 'package:inturn/core/widgets/cutom_text.dart';
import 'package:inturn/features/auth/presentation/add_info_flow/skills.dart';
import 'package:inturn/features/home/data/model/major_model.dart';

class CustomSegmentedButton2 extends StatefulWidget {
  final List<String> segments;
  final Function(List<int>) onValueChanged;
  final List<int> initialSelectedIndexes;
  final double? width;
  final Function (int index) onTapClose;
  const CustomSegmentedButton2({
    super.key,
    required this.segments,
    required this.onValueChanged,
    required this.onTapClose,

    this.width,
    this.initialSelectedIndexes = const [],
  });

  @override
  CustomSegmentedButtonState createState() => CustomSegmentedButtonState();
}

class CustomSegmentedButtonState extends State<CustomSegmentedButton2> {
  late Set<int> _selectedIndexes;

  @override
  void initState() {
    super.initState();
    _selectedIndexes = widget.initialSelectedIndexes.toSet();
  }

  @override
  Widget build(BuildContext context) {
    _selectedIndexes = widget.initialSelectedIndexes.toSet();

    return Wrap(
      alignment: WrapAlignment.start,
      direction: Axis.horizontal,
      spacing: AppSize.defaultSize! * 1.5,
      children: List.generate(
        widget.segments.length,
            (index) => Stack(
              children: [
SizedBox(height: AppSize.defaultSize!*7,),
                Container(
                  margin: EdgeInsets.all(AppSize.defaultSize! * .5),
                  height: AppSize.defaultSize! * 4.5,
                  decoration: BoxDecoration(
                    // color: _selectedIndexes.contains(index)
                    //     ? AppColors.secondaryColor
                    //     : Colors.white,
                    color: AppColors.secondaryColor,
                    borderRadius: BorderRadius.circular(AppSize.defaultSize! * 1.5),
                    border: Border.all(color: AppColors.secondaryColor, width: 2),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(AppSize.defaultSize!),
                    child: CustomText(
                      text: widget.segments[index],
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Positioned(
                  top: -AppSize.defaultSize!*.2, // Position it outside the top boundary of the container
                  right: AppSize.defaultSize!*.5, // Position it outside the right boundary of the container
                  child:  CircleAvatar(
                    radius: AppSize.defaultSize! * 1.2,
                    backgroundColor: Colors.white,
                    child:   InkWell(
                      onTap:(){
                        widget.onTapClose!(index);
                      } ,
                      child: Icon(
                        Icons.close,
                        color: AppColors.primaryColor,
                        size: AppSize.defaultSize! * 1.7,
                      ),
                    ),
                  ),
                ),
              ],
            ),
      ),
    );
  }
}
