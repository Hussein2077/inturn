
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
  const ResetPasswordEvent({ required this.code, required this.email,  required this.password});
}
class VerifyCodeEvent extends BaseChangePasswordEvent{
  final String email ;
  final String code ;
  const VerifyCodeEvent({  required this.email,required this.code});
}
class SendCodeEvent extends BaseChangePasswordEvent{
  final String phoneOrEmail ;
final PhoneOrEmail phoneOrEmailType ;
  const SendCodeEvent( {  required this.phoneOrEmail,this.phoneOrEmailType=PhoneOrEmail.phone,});
}