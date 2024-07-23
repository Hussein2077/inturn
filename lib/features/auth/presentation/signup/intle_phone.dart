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
  const IntlPhone({super.key, this.suffixIcon, this.onChanged, this.onSubmitted,   this.readOnly});
final Widget? suffixIcon;
final bool? readOnly;
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
      countries: const [
        Country(
          name: "Egypt",
          nameTranslations: {
            "sk": "Egypt",
            "se": "Egypt",
            "pl": "Egipt",
            "no": "Egypt",
            "ja": "エジプト",
            "it": "Egitto",
            "zh": "埃及",
            "nl": "Egypt",
            "de": "Ägypt",
            "fr": "Égypte",
            "es": "Egipt",
            "en": "Egypt",
            "pt_BR": "Egito",
            "sr-Cyrl": "Египат",
            "sr-Latn": "Egipat",
            "zh_TW": "埃及",
            "tr": "Mısır",
            "ro": "Egipt",
            "ar": "مصر",
            "fa": "مصر",
            "yue": "埃及"
          },
          flag: "🇪🇬",
          code: "EG",
          dialCode: "20",
          minLength: 10,
          maxLength: 10,
        ),
      ],
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
      readOnly: readOnly??false,

      onCountryChanged: (countryCode) {
        IntlPhone.country =  countryCode;

      },
      onChanged:onChanged,

    );
  }
}
