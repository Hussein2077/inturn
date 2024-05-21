abstract class BaseGetInternshipsBySearchEvent {}

class InitEvent extends BaseGetInternshipsBySearchEvent {}

class GetInternshipsBySearchEvent extends BaseGetInternshipsBySearchEvent {
  final String? title;
  final int? companyId;
  final int? cityId;
  final int? countryId;
  final int? vacancyLevelId;
  final int? vacancyWorkPlace;

final String? userId;

  GetInternshipsBySearchEvent( {
    this.title,
    this.companyId,
    this.cityId,
    this.countryId,
    this.vacancyLevelId,
    this.userId,
    this.vacancyWorkPlace,
});

}
