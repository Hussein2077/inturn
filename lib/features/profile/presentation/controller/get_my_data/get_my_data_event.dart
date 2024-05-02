abstract class BaseGetMyDataEvent {}

class InitEvent extends BaseGetMyDataEvent {}

class GetMyDataEvent extends BaseGetMyDataEvent {
 final String userID;
  GetMyDataEvent(this.userID);
}
class CompleteProfileEvent extends BaseGetMyDataEvent {
 final String userID;
 CompleteProfileEvent(this.userID);
}
