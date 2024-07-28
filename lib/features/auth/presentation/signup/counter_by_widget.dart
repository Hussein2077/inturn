import 'dart:async';
import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inturn/core/resource_manager/colors.dart';
import 'package:inturn/core/resource_manager/string_manager.dart';
import 'package:inturn/core/resource_manager/themes/enums.dart';
import 'package:inturn/core/utils/app_size.dart';
import 'package:inturn/features/auth/presentation/add_info_flow/personal_info.dart';
import 'package:inturn/features/auth/presentation/controller/change_password_bloc/change_password_bloc.dart';
import 'package:inturn/features/auth/presentation/controller/change_password_bloc/change_password_events.dart';
import 'package:inturn/features/auth/presentation/signup/sign_up.dart';
class CounterByMinute extends StatefulWidget {

  const CounterByMinute({
    super.key,
this.email
  });
final String? email;
  @override
  State<CounterByMinute> createState() => _CounterByMinuteState();
}

class _CounterByMinuteState extends State<CounterByMinute> {
  late Timer _timer;
  int _start = 60; // 5 minutes in seconds
  bool isRepeatingTime = true;
  String? phone;
  @override
  void initState() {
    super.initState();
    if (isRepeatingTime) {
      startTimer();
    }
  }

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
          (Timer timer) => setState(
            () {
          if (_start < 1) {
            timer.cancel();
            isRepeatingTime = false;
          } else {
            _start = _start - 1;
          }
        },
      ),
    );
  }

  void resetTimerAndResendCode() {
    _timer.cancel();
    setState(() {
      _start = 60;
      isRepeatingTime = true;
      if(widget.email!=null){
        PersonalInfo.otpVisibleNotifier.value ++;
        BlocProvider.of<ResetPasswordFlowBloc>(context)
            .add(SendCodeEvent(phoneOrEmail: widget.email!,phoneOrEmailType: PhoneOrEmail.email));
      }else {
        BlocProvider.of<ResetPasswordFlowBloc>(context)
          .add(SendCodeEvent(phoneOrEmail: '0${SignUpScreen.phoneNumber}'));
      }
      // BlocProvider.of<SendCodeBloc>(context)
      //     .add(SendPhoneEvent(phone: widget.phone));
      // Reset to 5 minutes
    });
    startTimer();
  }

  String _formatTime(int time) {
    int minutes = time ~/ 60;
    int seconds = time % 60;
    return '$minutes:${seconds.toString().padLeft(2, '0')}';
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    log('${widget.email}emaillll');
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        InkWell(
          onTap: () async {
            log('${isRepeatingTime}isRepeatingTime');
            if(!isRepeatingTime) {
              resetTimerAndResendCode();
            }
          },
          child: Text(
            StringManager.resend.tr(),
            style: TextStyle(
                color:
                isRepeatingTime ? AppColors.greyColor : AppColors.primaryColor,
                fontSize: AppSize.defaultSize! + 6,
                fontWeight: FontWeight.bold),
          ),
        ),
        Text(
          _formatTime(_start),
          // style: Theme.of(context).textTheme.titleMedium,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}