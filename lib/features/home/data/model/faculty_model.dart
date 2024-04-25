import 'package:inturn/core/models/options_model.dart';
import 'package:inturn/core/models/vacancey_model.dart';

class FacultyModel extends OptionsModel {
  int? id;
  int? universityId;
  String? name;
  String? nameAr;


  FacultyModel (
      {  this.id,
      this.name,
      this.nameAr,
     });

  FacultyModel .fromJson(Map<String, dynamic> json,) {

    id = json['facultyId'];
    name = json['facultyNameEn'];
    text = json['name'];
    nameAr = json['facultyNameAr'];
    universityId = json['universityId'];
  }
//
// Map<String, dynamic> toJson() {
//   final Map<String, dynamic> data = new Map<String, dynamic>();
//   data['id'] = this.id;
//   data['name'] = this.name;
//   data['slug'] = this.slug;
//   data['logo'] = this.logo;
//   data['category'] = this.category;
//   data['categoryId'] = this.categoryId;
//   data['disable'] = this.disable;
//   data['jobs'] = this.jobs;
//   data['popular'] = this.popular;
//   return data;
// }
}
