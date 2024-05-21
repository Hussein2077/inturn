import 'package:flutter/material.dart';
import 'package:inturn/core/resource_manager/colors.dart';
import 'package:inturn/core/utils/app_size.dart';
import 'package:inturn/core/widgets/cutom_text.dart';
import 'package:inturn/features/auth/presentation/add_info_flow/fields_of_work.dart';
import 'package:inturn/features/home/data/model/major_model.dart';

class MultiSegmentedButton extends StatefulWidget {
  final List<MajorModel> segments;
  final List<int>? ids;
  final Function(List<int>) onValueChanged;
  final List<int> initialSelectedIndices;
  final double? width;
  final int initialIndex;
static int selectedIndex = 0;
  const MultiSegmentedButton({
    super.key,
    required this.segments,
    required this.initialIndex,
      this.ids,
    required this.onValueChanged,
    this.width,
    this.initialSelectedIndices = const [],
  });

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
        widget.segments[widget.initialIndex].positions.length,
            (index) => GestureDetector(
          onTap: () {
            setState(() {

              MultiSegmentedButton.selectedIndex=index;
              if (_selectedIndices.contains(index)) {
                FieldsInfo.majorsId.remove(widget.ids![index]);
                _selectedIndices.remove(index);
              } else {
                FieldsInfo.majorsId.add(widget.ids![index]);
                _selectedIndices.add(index);
              }
              widget.onValueChanged(_selectedIndices);
            });
          },
          child: Container(
            margin: EdgeInsets.all(AppSize.defaultSize! * 0.5),
            height: AppSize.defaultSize! * 4.5,
            // width: widget.width ?? AppSize.defaultSize! * 16,
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
            child: Padding(
              padding: EdgeInsets.all(AppSize.defaultSize!),
              child: CustomText(
                text: widget.segments[widget.initialIndex].positions[index].majorNameEn,
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