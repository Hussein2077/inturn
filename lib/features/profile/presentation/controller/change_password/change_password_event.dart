
import 'package:equatable/equatable.dart';

abstract class BaseChangePasswordBaseEvent extends Equatable {
  const BaseChangePasswordBaseEvent();

  @override
  List<Object> get props => [];
}

class ChangePasswordEvent extends BaseChangePasswordBaseEvent{
  final String oldPassword ;
  final String newPassword ;
  final String id ;
  const ChangePasswordEvent({ required this.oldPassword, required this.newPassword,  required this.id});
}