abstract class BaseGetJobsEvent {}

class InitEvent extends BaseGetJobsEvent {}

class GetJobsEvent extends BaseGetJobsEvent {
  final String? text;
  final String? skill;
  final String? area;
  final int type;
  GetJobsEvent( {this.text, this.skill, this.area,  this.type=1,});
}
