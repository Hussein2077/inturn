abstract class BaseGetMyDataEvent {}

class InitEvent extends BaseGetMyDataEvent {}

class GetMyDataEvent extends BaseGetMyDataEvent {
 final int userID;
  GetMyDataEvent(this.userID);
}
