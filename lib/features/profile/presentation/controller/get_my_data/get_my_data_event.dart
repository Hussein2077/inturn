abstract class BaseGetMyDataEvent {}

class InitEvent extends BaseGetMyDataEvent {}

class GetMyDataEvent extends BaseGetMyDataEvent {
  GetMyDataEvent();
}
class CompleteProfileEvent extends BaseGetMyDataEvent {

 CompleteProfileEvent();
}
