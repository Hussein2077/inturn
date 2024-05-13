abstract class BaseGetMyApplicationsEvent {}

class InitEvent extends BaseGetMyApplicationsEvent {}

class GetMyApplicationsEvent extends BaseGetMyApplicationsEvent {
final  String userId;

GetMyApplicationsEvent(this.userId);
}
