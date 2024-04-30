import 'package:inturn/features/profile/domain/use_case/edit_profile_uc.dart';

abstract class BaseEditProfileEvent {}

class InitEvent extends BaseEditProfileEvent {}

class EditProfileEvent extends BaseEditProfileEvent {
  final EditPersonalInfoParams data;
  EditProfileEvent(this.data);
}
