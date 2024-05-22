import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:inturn/core/resource_manager/asset_path.dart';
import 'package:inturn/core/resource_manager/colors.dart';
import 'package:inturn/core/utils/app_size.dart';
import 'package:inturn/core/widgets/cutom_text.dart';

class CustomAccordion extends StatefulWidget {
  const CustomAccordion(
      {super.key, required this.text, required this.widgetItems});

  final String text;

  final Widget widgetItems;

  @override
  State<CustomAccordion> createState() => _CustomAccordionState();
}

class _CustomAccordionState extends State<CustomAccordion> {
  Widget closeIcon = Transform.rotate(
    angle: 180 * 3.14 / 180,
    child: SvgPicture.asset(
      AssetPath.collapsed,
    ),
  );

  Widget openIcon = SvgPicture.asset(
    AssetPath.collapsed,
  );
  bool visible = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(AppSize.defaultSize!),
      child: Column(
        children: [
          InkWell(
            borderRadius:   BorderRadius.circular(AppSize.defaultSize!  ),
            onTap: () {
              setState(() {
                visible = !visible;
              });
            },
            child: SizedBox(
              height: AppSize.defaultSize! * 4,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomText(
                    text: widget.text,
                    color: AppColors.thirdColor,
                    fontSize: AppSize.defaultSize! * 1.4,
                    fontWeight: FontWeight.w400,
                  ),
                  if (visible) openIcon else closeIcon
                ],
              ),
            ),
          ),
          Visibility(visible: visible, child: widget.widgetItems)
        ],
      ),
    );
  }
}
