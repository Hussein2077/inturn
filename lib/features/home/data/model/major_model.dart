import 'package:inturn/core/models/options_model.dart';
import 'package:inturn/core/models/vacancey_model.dart';

class MajorModel extends OptionsModel {
  int? id;
  String? name;
  String? slug;
  String? logo;
  dynamic category;
  int? categoryId;
  bool? disable;
  List<VacancyModel>? jobs;
  int? popular;

  MajorModel (
      {this.id,
      this.name,
      this.slug,
      this.logo,
      this.category,
      this.categoryId,
      this.disable,
      this.jobs,
      this.popular});

  MajorModel .fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    text = json['name'];
    slug = json['slug'];
    logo = json['logo'];
    category = json['category'];
    categoryId = json['categoryId'];
    disable = json['disable'];
    jobs = json['jobs'];
    popular = json['popular'];
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
