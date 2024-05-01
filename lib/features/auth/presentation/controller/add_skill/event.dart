import 'package:equatable/equatable.dart';

abstract class AddSkillsEvent  {
  const AddSkillsEvent();

  @override
  List<Object> get props => [];
}
class SendSkillsIdEvent extends AddSkillsEvent {
  final List <int> skills;

  const SendSkillsIdEvent({required this.skills});

}