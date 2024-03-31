abstract class BaseGetInternshipsBySearchEvent {}

class InitEvent extends BaseGetInternshipsBySearchEvent {}

class GetInternshipsBySearchEvent extends BaseGetInternshipsBySearchEvent {
  final String? text;
  final String? skill;
  final String? area;
  final int type;

  GetInternshipsBySearchEvent({this.text, this.skill, this.area,this.type=1});

}
