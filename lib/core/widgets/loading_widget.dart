import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:inturn/core/resource_manager/colors.dart';
import 'package:inturn/core/utils/app_size.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key, this.height, this.width, this.size});
final double? height;
final double? width;
final double? size;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height:height,
        width:width,
        child: Center(
          child: LoadingAnimationWidget.twistingDots(
            leftDotColor: AppColors.primaryColor,
            rightDotColor:AppColors.black,
            size:size?? (AppSize.defaultSize??10)*7,
          ),
        ),
      ),
    );
  }
}
