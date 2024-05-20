abstract class SuggestedEvent {}

class InitEvent extends SuggestedEvent {}
class GetSuggestedBySearchEvent extends SuggestedEvent {
  final int? companyId;

  final String? userId;

  GetSuggestedBySearchEvent({
    this.companyId,
    this.userId
  });

}