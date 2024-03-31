abstract class BaseGetMyApplicationsEvent {}

class InitEvent extends BaseGetMyApplicationsEvent {}

class GetMyApplicationsEvent extends BaseGetMyApplicationsEvent {
final  String type;

GetMyApplicationsEvent(this.type);
}
