abstract class BaseGetTopFiveEvent {}

class InitEvent extends BaseGetTopFiveEvent {}

class GetTopFiveEvent extends BaseGetTopFiveEvent {
  final int type;

  GetTopFiveEvent(this.type);
}
class GetMajorEvent extends BaseGetTopFiveEvent {

  GetMajorEvent();
}
