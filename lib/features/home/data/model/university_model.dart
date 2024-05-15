
import 'package:equatable/equatable.dart';

class UniversityModel extends Equatable{
  final int? universityId;
  final String? universityName;
  final String? universityNameAr;

  UniversityModel({
      this.universityId,
      this.universityName,
      this.universityNameAr,
  });

  factory UniversityModel.fromJson(Map<String, dynamic> json) {
    return UniversityModel(
      universityId: json['universityId'],
      universityName: json['universityNameEn'],
      universityNameAr: json['universityNameAr'],
    );
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['universityId'] = universityId;
    map['universityNameEn'] = universityName;
    map['universityNameAr'] = universityNameAr;
    return map;
  }

  @override
  // TODO: implement props
  List<Object?> get props => [
    universityId,
    universityName,
    universityNameAr
  ];

}