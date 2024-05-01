import 'package:flutter/material.dart';
import 'package:inturn/core/resource_manager/colors.dart';
import 'package:inturn/core/utils/app_size.dart';
import 'package:inturn/core/widgets/cutom_text.dart';

class CustomSegmentedButton2 extends StatefulWidget {
  final List<String> segments;
  final Function(List<int>) onValueChanged;
  final List<int> initialSelectedIndexes;
  final double? width;

  const CustomSegmentedButton2({
    super.key,
    required this.segments,
    required this.onValueChanged,
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
            (index) => GestureDetector(
          onTap: () {
            setState(() {

              if (_selectedIndexes.contains(index)) {
                _selectedIndexes.remove(index);
              } else {
                _selectedIndexes.add(index);
              }
              widget.onValueChanged(_selectedIndexes.toList());
            });
          },
          child: Container(
            margin: EdgeInsets.all(AppSize.defaultSize! * 0.5),
            height: AppSize.defaultSize! * 4.5,
            decoration: BoxDecoration(
              color: _selectedIndexes.contains(index)
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
