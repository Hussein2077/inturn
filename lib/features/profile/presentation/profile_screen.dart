import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:inturn/core/resource_manager/asset_path.dart';
import 'package:inturn/core/resource_manager/colors.dart';
import 'package:inturn/core/resource_manager/string_manager.dart';
import 'package:inturn/core/utils/app_size.dart';
import 'package:inturn/core/widgets/app_bar.dart';
import 'package:inturn/core/widgets/column_with_text_field.dart';
import 'package:inturn/core/widgets/main_button.dart';
import 'package:inturn/core/widgets/major_drop_down.dart';
import 'package:inturn/core/widgets/university.dart';
import 'package:inturn/features/profile/presentation/widgets/upload_cv.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late TextEditingController firstNameController;
  late TextEditingController lastNameController;
  late TextEditingController universityController;
  late TextEditingController majorController;
  DateTime selectedDate = DateTime.now();
  String selectedValue = 'Option 1';

  @override
  void initState() {
    firstNameController = TextEditingController();
    lastNameController = TextEditingController();
    universityController = TextEditingController();
    majorController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    universityController.dispose();
    majorController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context, text: StringManager.profile.tr(),),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: AppSize.defaultSize! * 2),
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: AppSize.defaultSize! * 3.5,
                  backgroundColor: Colors.white,
                  child: Image.asset(
                    AssetPath.human,
                    height: AppSize.defaultSize! * 6,
                    width: AppSize.defaultSize! * 6,
                  ),
                ),
                SizedBox(
                  height: AppSize.defaultSize! * .5,
                ),
                Text(
                  StringManager.changeProfilePicture.tr(),
                  style: TextStyle(
                    fontSize: AppSize.defaultSize! * 1.4,
                  ),
                ),
                Row(
                  children: [
                    ColumnWithTextField(
                      text: StringManager.firstName.tr(),
                      controller: firstNameController,
                      width: AppSize.screenWidth! * .4,
                    ),
                    const Spacer(),
                    ColumnWithTextField(
                      text: StringManager.secondName.tr(),
                      controller: lastNameController,
                      width: AppSize.screenWidth! * .4,
                    ),
                  ],
                ),
                ColumnWithTextField(
                  text: StringManager.dateOfBirth.tr(),
                  readOnly: true,
                  hintText: selectedDate.toString().substring(0, 10),
                  suffixIcon: const Icon(Icons.calendar_month_outlined),
                  onTap: () {
                    _selectDate(context);
                  },
                ),
                SizedBox(
                  height: AppSize.defaultSize! * 3,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    dropDownSignUp(
                        text: StringManager.educationLevel.tr(),
                        hintText: StringManager.selectEdu.tr()),
                    dropDownSignUp(
                        text: StringManager.graduationYear.tr(),
                        hintText: StringManager.selectGrad.tr()),
                  ],
                ),
                SizedBox(
                  height: AppSize.defaultSize! * 3,
                ),
                const UniversityDropDown(),
                SizedBox(
                  height: AppSize.defaultSize! * 3,
                ),
                const MajorDropDown(),
                SizedBox(
                  height: AppSize.defaultSize! * 3,
                ),
                const UploadCV(),
                SizedBox(
                  height: AppSize.defaultSize! * 3,
                ),
                MainButton(text: StringManager.saveChanges.tr()),
                SizedBox(
                  height: AppSize.defaultSize! * 5,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate, // Refer step 1
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  Widget dropDownSignUp({required String text, required String hintText}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          text,
          style: TextStyle(
              fontSize: AppSize.defaultSize! * 1.4,
              fontWeight: FontWeight.w700),
        ),
        SizedBox(
          height: AppSize.defaultSize! * .3,
        ),
        Container(
          width: AppSize.screenWidth! * .4,
          decoration: BoxDecoration(
              border: Border.all(color: AppColors.borderColor),
              borderRadius: BorderRadius.circular(AppSize.defaultSize! * .5)),
          child: Center(
            child: DropdownButton<String>(
              value: selectedValue,
              underline: const SizedBox(),
              onChanged: (String? newValue) {
                setState(() {
                  selectedValue = newValue!;
                });
              },
              hint: Text(
                hintText,
                style: TextStyle(
                  fontSize: AppSize.defaultSize!,
                ),
              ),
              icon: Padding(
                padding: EdgeInsets.only(left: AppSize.defaultSize! * 3),
                child: Icon(
                  Icons.keyboard_arrow_down_sharp,
                  size: AppSize.defaultSize! * 3,
                ),
              ),
              items: <String>['Option 1', 'Option 2', 'Option 3', 'Option 4']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(
                    value,
                    style: TextStyle(
                      fontSize: AppSize.defaultSize!,
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ),
      ],
    );
  }
}
