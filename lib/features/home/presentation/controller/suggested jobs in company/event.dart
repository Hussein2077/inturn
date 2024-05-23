abstract class SuggestedInCompanyEvent {}

class InitEvent extends SuggestedInCompanyEvent {}
class GetSuggestedInCompanyBySearchEvent extends SuggestedInCompanyEvent {
  final int? companyId;

  final String? userId;

  GetSuggestedInCompanyBySearchEvent({
    this.companyId,
    this.userId
  });

}