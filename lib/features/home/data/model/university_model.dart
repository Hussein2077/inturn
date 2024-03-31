import 'package:inturn/core/models/options_model.dart';

class UniversityModel extends OptionsModel{
  final int? universityId;
  final String? universityName;
  final String? universityNameAr;

  UniversityModel(

      {
    required this.universityId,
    required this.universityName,
    required this.universityNameAr,
  });

  factory UniversityModel.fromJson(Map<String, dynamic> json) {
    return UniversityModel(
      universityId: json['universityId'],
      universityName: json['universityName'],

      universityNameAr: json['universityNameAr'],
    );
  }



}