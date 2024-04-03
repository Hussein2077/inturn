import 'package:flutter/material.dart';
import 'package:inturn/core/resource_manager/colors.dart';
import 'package:inturn/core/utils/app_size.dart';
import 'package:inturn/core/widgets/cutom_text.dart';

class SingleChoice extends StatefulWidget {
  final List<String> choices;

  const SingleChoice({
    super.key,
    required this.choices,
  });

  @override
  State<SingleChoice> createState() => _SingleChoiceState();
}

class _SingleChoiceState extends State<SingleChoice> {
  late String selectedChoice;

  @override
  void initState() {
    super.initState();
    selectedChoice = widget.choices.first;
  }

  @override
  Widget build(BuildContext context) {
    return SegmentedButton<String>(
      segments: widget.choices
          .map((choice) => ButtonSegment<String>(
        icon: const SizedBox(),
        value: choice,
        label: SizedBox(
            width: AppSize.defaultSize!*6 ,
            child: CustomText(text: choice,
            fontWeight: FontWeight.w700,
              color: AppColors.black,
              fontSize: AppSize.defaultSize!*1.6,
            )),
        // You can add icons here if needed
      ))
          .toList(),
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(AppColors.secondaryColor),
        padding: MaterialStateProperty.all(
          EdgeInsets.all(AppSize.defaultSize! * 1.5),
        )
      ),
      showSelectedIcon: false,
      selected: {selectedChoice},
      onSelectionChanged: (Set<String> newSelection) {
        setState(() {
          selectedChoice = newSelection.first;
        });
      },
    );
  }
}
