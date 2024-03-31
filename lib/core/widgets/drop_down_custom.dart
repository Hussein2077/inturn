import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:inturn/core/resource_manager/colors.dart';
import 'package:inturn/core/utils/app_size.dart';

class CustomDropdownButton2 extends StatelessWidget {
  const CustomDropdownButton2({
    required this.hint,
    required this.value,
    required this.dropdownItems,
    required this.onChanged,
    this.selectedItemBuilder,
    this.hintAlignment,
    this.valueAlignment,
    this.buttonHeight,
    this.buttonWidth,
    this.buttonPadding,
    this.buttonDecoration,
    this.buttonElevation,
    this.icon,
    this.iconSize,
    this.iconEnabledColor,
    this.iconDisabledColor,
    this.itemHeight,
    this.itemPadding,
    this.dropdownHeight,
    this.dropdownWidth,
    this.dropdownPadding,
    this.dropdownDecoration,
    this.dropdownElevation,
    this.scrollbarRadius,
    this.scrollbarThickness,
    this.scrollbarAlwaysShow,
    this.offset = Offset.zero,
    super.key, this.dropdownColor,
  });
  final String hint;
  final String? value;
  final List<String> dropdownItems;
  final ValueChanged<String?>? onChanged;
  final DropdownButtonBuilder? selectedItemBuilder;
  final Alignment? hintAlignment;
  final Alignment? valueAlignment;
  final double? buttonHeight, buttonWidth;
  final EdgeInsetsGeometry? buttonPadding;
  final BoxDecoration? buttonDecoration;
  final int? buttonElevation;
  final Widget? icon;
  final double? iconSize;
  final Color? iconEnabledColor;
  final Color? iconDisabledColor;
  final Color? dropdownColor;
  final double? itemHeight;
  final EdgeInsetsGeometry? itemPadding;
  final double? dropdownHeight, dropdownWidth;
  final EdgeInsetsGeometry? dropdownPadding;
  final BoxDecoration? dropdownDecoration;
  final int? dropdownElevation;
  final Radius? scrollbarRadius;
  final double? scrollbarThickness;
  final bool? scrollbarAlwaysShow;
  final Offset offset;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton2<String>(
        //To avoid long text overflowing.
        isExpanded: true,
        hint: Container(
          alignment: hintAlignment,
          child: Text(
            hint,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            style: TextStyle(
                fontSize: AppSize.defaultSize!*1.6,
                fontWeight: FontWeight.w600,
                color: AppColors.black.withOpacity(.8)
            ),
          ),
        ),
        value: value,
        items: dropdownItems
            .map((String item) => DropdownMenuItem<String>(
          value: item,
          child: Container(
            alignment: valueAlignment,
            child: Text(
              item,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style:   TextStyle(
                fontSize: AppSize.defaultSize!*1.4,
              ),
            ),
          ),
        ))
            .toList(),
        onChanged: onChanged,
        selectedItemBuilder: selectedItemBuilder,
        buttonStyleData: ButtonStyleData(
          height: buttonHeight ?? AppSize.defaultSize!*4,
          width: buttonWidth ?? AppSize.defaultSize!*14,
          padding: buttonPadding ??   EdgeInsets.only(left: AppSize.defaultSize!*1.4, right: AppSize.defaultSize!*1.4),
          decoration: buttonDecoration ??
              BoxDecoration(
                borderRadius: BorderRadius.circular(AppSize.defaultSize!*1.4),
                border: Border.all(
                  color: Colors.black45,
                ),
              ),
          elevation: buttonElevation,
        ),
        iconStyleData: IconStyleData(
          icon: icon ?? const Icon(Icons.arrow_forward_ios_outlined),
          iconSize: iconSize ?? AppSize.defaultSize! * 3,
          iconEnabledColor: iconEnabledColor,
          iconDisabledColor: iconDisabledColor,
        ),
        dropdownStyleData: DropdownStyleData(
          //Max height for the dropdown menu & becoming scrollable if there are more items. If you pass Null it will take max height possible for the items.
          maxHeight: dropdownHeight ?? AppSize.defaultSize!*20,
          width: dropdownWidth ?? AppSize.defaultSize!*14,
          padding: dropdownPadding,
          decoration: dropdownDecoration ??
              BoxDecoration(
                color: dropdownColor,
                borderRadius: BorderRadius.circular(AppSize.defaultSize!*1.4),
              ),
          elevation: dropdownElevation ?? 8,
          //Null or Offset(0, 0) will open just under the button. You can edit as you want.
          offset: offset,
          scrollbarTheme: ScrollbarThemeData(
            radius: scrollbarRadius ??   Radius.circular(AppSize.defaultSize!*4),
            thickness: scrollbarThickness != null
                ? MaterialStateProperty.all<double>(scrollbarThickness!)
                : null,
            thumbVisibility: scrollbarAlwaysShow != null
                ? MaterialStateProperty.all<bool>(scrollbarAlwaysShow!)
                : null,
          ),
        ),
        menuItemStyleData: MenuItemStyleData(
          height: itemHeight ?? AppSize.defaultSize!*4,
          padding: itemPadding ??   EdgeInsets.only(left: AppSize.defaultSize!*1.4, right: AppSize.defaultSize!*1.4),
        ),
      ),
    );
  }
}
/*

{
    "message"
    "data": {
        "id": 15",
        "name": "Mohamed",
        "email": "mohamed@gmail.com",
        "phone": "01000000000",
        "image": "https://i.pravatar.cc/150?img=1",
        "age":22,
        "edu_level":'bachelor',
        "grd_year":'2023',
        "university":'2023',
        "major":'2023',
        "city":[
        {
        'name':'cairo',
        'id':1
        }, {
        'name':'cairo',
        'id':1
        }, {
        'name':'cairo',
        'id':1
        },
        ],
        "skill":[
      flutter,

        ],
        cv builder
        Experience
    }
}

 */