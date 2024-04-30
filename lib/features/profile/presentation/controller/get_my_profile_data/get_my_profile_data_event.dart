abstract class BaseGetMyProfileDataEvent {}

class InitEvent extends BaseGetMyProfileDataEvent {}

class GetMyProfileDataEvent extends BaseGetMyProfileDataEvent {
  final String userID;
  GetMyProfileDataEvent(this.userID);
}
