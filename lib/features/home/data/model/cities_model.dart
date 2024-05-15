import 'package:inturn/core/models/vacancey_model.dart';

class Country {
  final int countryId;
  final String countryNameEn;
  final String countryNameAr;
  List<CityModel>? cities;


  Country({
    required this.countryId,
    required this.countryNameEn,
    required this.countryNameAr,
    this.cities,
  });

  factory Country.fromJson(Map<String, dynamic> json) => Country(
    countryId: json['countryId'],
    countryNameEn: json['countryNameEn'],
    countryNameAr: json['countryNameAr'],
    cities: json['citys'] != null
        ? List<CityModel>.from(json['citys'].map((x) => CityModel.fromJson(x)))
        : null,
  );

  Map<String, dynamic> toJson() => {
    'countryId': countryId,
    'countryNameEn': countryNameEn,
    'countryNameAr': countryNameAr,
    'citys': cities?.map((x) => x.toJson()).toList(),
  };
}

class CityModel {
  final int cityId;
  final int countryId;
  final String cityNameEn;
  final String cityNameAr;

  CityModel({
    required this.cityId,
    required this.countryId,
    required this.cityNameEn,
    required this.cityNameAr,
  });

  factory CityModel.fromJson(Map<String, dynamic> json) => CityModel(
    cityId: json['cityId'],
    countryId: json['countryId'],
    cityNameEn: json['cityNameEn'],
    cityNameAr: json['cityNameAr'],
  );

  Map<String, dynamic> toJson() => {
    'cityId': cityId,
    'countryId': countryId,
    'cityNameEn': cityNameEn,
    'cityNameAr': cityNameAr,
  };
}


