
import 'package:equatable/equatable.dart';

abstract class BaseChangePasswordEvent extends Equatable {
  const BaseChangePasswordEvent();

  @override
  List<Object> get props => [];
}
class ChangePasswordEvent extends BaseChangePasswordEvent{
  final String password ;
  const ChangePasswordEvent({  required this.password});
}
class VerifyCodeEvent extends BaseChangePasswordEvent{
  final String email ;
  final String code ;
  const VerifyCodeEvent({  required this.email,required this.code});
}
class SendCodeEvent extends BaseChangePasswordEvent{
  final String email ;
  const SendCodeEvent({  required this.email});
}