import 'package:inturn/core/models/options_model.dart';

class FacultyModel extends OptionsModel {
  int? id;
  int? universityId;
  String? name;
  String? nameAr;

  FacultyModel({
    this.id,
    this.name,
    this.nameAr,
  });

  FacultyModel.fromJson(
    Map<String, dynamic> json,
  ) {
    id = json['facultyId'];
    name = json['facultyNameEn'];
    text = json['name'];
    nameAr = json['facultyNameAr'];
    universityId = json['universityId'];
  }
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['facultyId'] = id;
    map['facultyNameEn'] = name;
    map['name'] = text;
    map['facultyNameAr'] = nameAr;
    map['universityId'] = universityId;
    return map;
  }
}
