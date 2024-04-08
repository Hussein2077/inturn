import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:inturn/core/resource_manager/string_manager.dart';
import 'package:inturn/core/utils/app_size.dart';
import 'package:inturn/core/widgets/app_bar.dart';
import 'package:inturn/features/home/presentation/widgets/job_cart.dart';
class ApplicationsScreen extends StatelessWidget {
  const ApplicationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context, text: StringManager.applications.tr (),leading: false ),
    body: Column(
      children: [
        Expanded(
          child: ListView.builder(
              itemCount: 10,
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (item, index) {
                return Padding(
                  padding: EdgeInsets.all(AppSize.defaultSize! * 1.2),
                  child: const JobCart(linearCircle: false,).animate()
                      .fadeIn() // uses `Animate.defaultDuration`
                      .scale() // inherits duration from fadeIn
                      .move(delay: 300.ms, duration: 600.ms),
                );
              }),
        ),

      ]
    ),
    );
  }
}
