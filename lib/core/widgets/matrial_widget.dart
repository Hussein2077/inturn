import 'package:flutter/material.dart';
import 'package:inturn/core/utils/app_size.dart';

class MaterialWidget extends StatelessWidget {
  const MaterialWidget({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Material(
        elevation: 10,
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppSize.defaultSize! * 2),
        child: Padding(
            padding: EdgeInsets.all(AppSize.defaultSize! * 1.5), child: child));
  }
}
