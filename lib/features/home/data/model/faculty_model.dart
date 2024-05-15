import 'package:equatable/equatable.dart';

class FacultyModel extends Equatable {
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
    nameAr = json['facultyNameAr'];
    universityId = json['universityId'];
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['facultyId'] = id;
    map['facultyNameEn'] = name;
    map['facultyNameAr'] = nameAr;
    map['universityId'] = universityId;
    return map;
  }

  @override
  // TODO: implement props
  List<Object?> get props => [id, name, nameAr, universityId];
}
