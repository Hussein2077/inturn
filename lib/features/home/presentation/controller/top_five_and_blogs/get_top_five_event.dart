abstract class BaseGeMatchedVacancyEvent {}

class InitEvent extends BaseGeMatchedVacancyEvent {}

class GeMatchedVacancyEvent extends BaseGeMatchedVacancyEvent {
final String userId;
  GeMatchedVacancyEvent(this.userId);

}
