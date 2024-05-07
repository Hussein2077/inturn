abstract class BaseApplyEvent {}

class InitEvent extends BaseApplyEvent {}

class ApplyEvent extends BaseApplyEvent {
  final String userID;
  final int vacancyID;
  ApplyEvent( { required this.userID, required this.vacancyID});
}
