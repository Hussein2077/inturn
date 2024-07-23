import 'dart:async';
import 'dart:developer';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inturn/core/resource_manager/colors.dart';
import 'package:inturn/core/resource_manager/string_manager.dart';
import 'package:inturn/core/utils/app_size.dart';
import 'package:inturn/core/widgets/main_button.dart';
import 'package:inturn/core/widgets/snack_bar.dart';
import 'package:inturn/features/auth/presentation/controller/change_password_bloc/change_password_bloc.dart';
import 'package:inturn/features/auth/presentation/controller/change_password_bloc/change_password_events.dart';
import 'package:inturn/features/auth/presentation/signup/sign_up.dart';

class SendCodeButton extends StatefulWidget {
  const SendCodeButton({super.key, required this.text, required this.color, required this.readOnly,});
  final String text ;
  final Color color ;
  final bool readOnly ;
  @override
  State<SendCodeButton> createState() => _SendCodeButtonState();
}

class _SendCodeButtonState extends State<SendCodeButton> {

  @override
  Widget build(BuildContext context) {
    return        MainButton(
      text:widget.text ,
      width: AppSize.defaultSize! * 10,

      // height: AppSize.defaultSize! * 2,
      color: widget.color,

      


      fontSize: AppSize.defaultSize! * 1.2,
      textColor: Colors.white,
      onTap: () {
        log('messagemessagemessage${SignUpScreen.otpVisible}');
        if(SignUpScreen.phoneNumber.length != 10){
          errorSnackBar(context, StringManager.enterPhone.tr());

        }
        if (SignUpScreen.phoneNumber.length == 10 &&  !widget.readOnly ) {
          BlocProvider.of<ResetPasswordFlowBloc>(context)
              .add(SendCodeEvent(phoneOrEmail: '0${SignUpScreen.phoneNumber}'));

        }
      },
    );
  }
}
