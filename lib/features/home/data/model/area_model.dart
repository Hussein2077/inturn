import 'package:equatable/equatable.dart';

class AreaModel extends Equatable {
final  int? areaId;
final  int? cityId;
final  String? areaNameEn;
final String? areaNameAr;

  const AreaModel({
    this.areaId,
    this.areaNameEn,
    this.areaNameAr,
    this.cityId,
  });

factory AreaModel.fromJson(Map<String, dynamic> json) {
  return AreaModel(
    areaId: json['areaId']??1,
    areaNameEn: json['areaNameEn']  ??"",
    areaNameAr: json['areaNameAr']??"",
    cityId: json['cityId']??1,
  );
}



  @override
  List<Object?> get props => [areaId, areaNameEn, areaNameAr, cityId];
}
