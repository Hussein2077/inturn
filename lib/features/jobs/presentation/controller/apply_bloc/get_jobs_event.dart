abstract class BaseApplyEvent {}

class InitEvent extends BaseApplyEvent {}

class ApplyEvent extends BaseApplyEvent {
  final String? text;
  final String? skill;
  final String? area;
  final int type;
  ApplyEvent( {this.text, this.skill, this.area,  this.type=1,});
}
