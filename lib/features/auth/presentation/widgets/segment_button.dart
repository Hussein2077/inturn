import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:inturn/core/resource_manager/colors.dart';
import 'package:inturn/core/utils/app_size.dart';
import 'package:inturn/core/widgets/cutom_text.dart';

class CustomSegmentedButton extends StatefulWidget {
  final List<String> segments;
  final Function(int) onValueChanged;
  final int initialSelectedIndex;
final double? width;
  const CustomSegmentedButton({
    super.key,
    required this.segments,
    required this.onValueChanged,
    this.width,
    this.initialSelectedIndex = 0,
  });

  @override
  CustomSegmentedButtonState createState() => CustomSegmentedButtonState();
}

class CustomSegmentedButtonState extends State<CustomSegmentedButton> {
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.initialSelectedIndex;
  }

  @override
  Widget build(BuildContext context) {
    log('${_selectedIndex}sdbadva');
    return Wrap(
      alignment: WrapAlignment.start,
      direction: Axis.horizontal,
      spacing: AppSize.defaultSize! * 1.5,
      children: List.generate(
        widget.segments.length,
        (index) => GestureDetector(
          onTap: () {
            setState(() {
              _selectedIndex = index;
              widget.onValueChanged(_selectedIndex);
            });

          },
          child: Container(
            margin: EdgeInsets.all(AppSize.defaultSize! * 0.5),
            height: AppSize.defaultSize! * 4.5,
            // width: widget.width??AppSize.defaultSize! * 16,
            decoration: BoxDecoration(
              color: _selectedIndex == index
                  ? AppColors.secondaryColor
                  : Colors.white,
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
        ),
      ),
    );
  }
}
