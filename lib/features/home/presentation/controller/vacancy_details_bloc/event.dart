abstract class BaseGetVacancyDetailsEvent {}

class InitEvent extends BaseGetVacancyDetailsEvent {}

class GetVacancyDetailsEvent extends BaseGetVacancyDetailsEvent {
  final int id;

  GetVacancyDetailsEvent(this.id);
}
