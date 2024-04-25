import 'package:flutter/material.dart';
import 'package:inturn/core/resource_manager/colors.dart';
import 'package:inturn/core/utils/app_size.dart';
import 'package:inturn/core/widgets/cutom_text.dart';

class MultiSegmentedButton extends StatefulWidget {
  final List<String> segments;
  final Function(List<int>) onValueChanged;
  final List<int> initialSelectedIndices;
  final double? width;

  const MultiSegmentedButton({
    Key? key,
    required this.segments,
    required this.onValueChanged,
    this.width,
    this.initialSelectedIndices = const [],
  }) : super(key: key);

  @override
  MultiSegmentedButtonState createState() => MultiSegmentedButtonState();
}
class MultiSegmentedButtonState extends State<MultiSegmentedButton> {
  late List<int> _selectedIndices;

  @override
  void initState() {
    super.initState();
    _selectedIndices = List.from(widget.initialSelectedIndices);
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.start,
      direction: Axis.horizontal,
      spacing: AppSize.defaultSize! * 1.5,
      children: List.generate(
        widget.segments.length,
            (index) => GestureDetector(
          onTap: () {
            setState(() {
              if (_selectedIndices.contains(index)) {
                _selectedIndices.remove(index);
              } else {
                _selectedIndices.add(index);
              }
              widget.onValueChanged(_selectedIndices);
            });
          },
          child: Container(
            margin: EdgeInsets.all(AppSize.defaultSize! * 0.5),
            height: AppSize.defaultSize! * 4.5,
            width: widget.width ?? AppSize.defaultSize! * 16,
            decoration: BoxDecoration(
              color: _selectedIndices.contains(index)
                  ? AppColors.secondaryColor
                  : Colors.white,
              borderRadius: BorderRadius.circular(AppSize.defaultSize! * 1.5),
              border: Border.all(
                color: AppColors.secondaryColor,
                width: 2,
              ),
            ),
            child: Center(
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