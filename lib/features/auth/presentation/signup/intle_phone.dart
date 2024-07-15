import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl_phone_field/countries.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:intl_phone_field/phone_number.dart';
import 'package:inturn/core/resource_manager/colors.dart';
import 'package:inturn/core/resource_manager/string_manager.dart';
import 'package:inturn/core/utils/app_size.dart';
import 'package:inturn/core/widgets/main_button.dart';
import 'package:inturn/features/auth/presentation/controller/change_password_bloc/change_password_bloc.dart';
import 'package:inturn/features/auth/presentation/controller/change_password_bloc/change_password_events.dart';
class IntlPhone extends StatelessWidget {
  const IntlPhone({super.key, this.suffixIcon, this.onChanged, this.onSubmitted});
final Widget? suffixIcon;
final void Function(PhoneNumber)? onChanged;
  final void Function(String)? onSubmitted;
  static Country? country ;
  @override
  Widget build(BuildContext context) {
    return IntlPhoneField(
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp("[0-9]")),

      ],
      onSubmitted: onSubmitted,
      decoration: InputDecoration(
        labelText: 'Phone Number',
        labelStyle: TextStyle(
            color: AppColors.black,
            fontSize: AppSize.defaultSize! * 1.4),
        hintText: '1123456789',
        hintStyle: TextStyle(
          fontSize: AppSize.defaultSize! * 1.4,
        ),
        suffixIcon: suffixIcon ,

        border: OutlineInputBorder(
          borderSide:
          const BorderSide(color: AppColors.greyColor),
          borderRadius: BorderRadius.all(
              Radius.circular(AppSize.defaultSize!)),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide:
          const BorderSide(color: AppColors.primaryColor),
          borderRadius: BorderRadius.all(
              Radius.circular(AppSize.defaultSize!)),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide:
          const BorderSide(color: AppColors.greyColor),
          borderRadius: BorderRadius.all(
              Radius.circular(AppSize.defaultSize!)),
        ),
      ),
      initialCountryCode: 'EG',
      onCountryChanged: (countryCode) {
        IntlPhone.country =  countryCode;

      },
      onChanged:onChanged,

    );
  }
}
