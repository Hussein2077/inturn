import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:inturn/core/models/profile_data_model.dart';
import 'package:inturn/core/resource_manager/string_manager.dart';
import 'package:inturn/core/utils/app_size.dart';
import 'package:inturn/features/auth/presentation/widgets/segment_button.dart';
class ProfileJobLevel extends StatefulWidget {
  const ProfileJobLevel({super.key, required this.profileDataModel});
final ProfileDataModel profileDataModel;
static   int jop = 0;

  @override
  State<ProfileJobLevel> createState() => _ProfileJobLevelState();
}

class _ProfileJobLevelState extends State<ProfileJobLevel> {
  void _onValueChangedJop(int newValue) {
    setState(() {
      ProfileJobLevel.jop = newValue;
    });
  }
  @override
  Widget build(BuildContext context) {
    return CustomSegmentedButton(
            width: AppSize.defaultSize! * 15,
            initialSelectedIndex:
            (widget.profileDataModel?.jobLevelId ?? 1) > 0
                ? (widget.profileDataModel?.jobLevelId ??
                1) -
                1
                : 0,
            segments: [
              StringManager.internship.tr(),
              StringManager.entryLevel.tr()
            ],
            onValueChanged: (index) =>
                _onValueChangedJop(index ),
          );
        }
}

