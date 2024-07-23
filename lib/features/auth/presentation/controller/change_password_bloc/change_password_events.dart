
import 'package:equatable/equatable.dart';
import 'package:inturn/core/resource_manager/themes/enums.dart';

abstract class BaseChangePasswordEvent extends Equatable {
  const BaseChangePasswordEvent();

  @override
  List<Object> get props => [];
}
class ResetPasswordEvent extends BaseChangePasswordEvent{
  final String password ;
  final String code ;
  final String email ;
  final PhoneOrEmail phoneOrEmailType ;
  const ResetPasswordEvent({ required this.code, required this.email,  required this.password,required this.phoneOrEmailType});
}
class VerifyCodeEvent extends BaseChangePasswordEvent{
  final String email ;
  final String code ;
  final PhoneOrEmail phoneOrEmailType ;
  final bool fromForgot;
  const VerifyCodeEvent({  required this.email,required this.code,this.phoneOrEmailType=PhoneOrEmail.email, required this.fromForgot});
}
class VerifyCodeSignUpEvent extends BaseChangePasswordEvent{
  final String phone ;
  final String code ;
  const VerifyCodeSignUpEvent({  required this.phone,required this.code});
}
class SendCodeEvent extends BaseChangePasswordEvent{
  final String phoneOrEmail ;
final PhoneOrEmail phoneOrEmailType ;
  const SendCodeEvent( {  required this.phoneOrEmail,this.phoneOrEmailType=PhoneOrEmail.phone,});
}
class SendCodeForForgotEvent extends BaseChangePasswordEvent{
  final String phoneOrEmail ;
final PhoneOrEmail phoneOrEmailType ;
  const SendCodeForForgotEvent( {  required this.phoneOrEmail,this.phoneOrEmailType=PhoneOrEmail.phone,});
}