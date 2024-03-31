import 'package:inturn/core/models/options_model.dart';
import 'package:inturn/core/models/vacancey_model.dart';

class CitiesModel extends OptionsModel {
  int? id;
  String? name;
  String? nameAr;
  String? slug;
  dynamic category;
  int? categoryId;
  bool? disable;
  List<VacancyModel>? jobs;
  int? popular;

  CitiesModel(
      {this.id,
      this.name,
      this.nameAr,
      this.slug,
      this.category,
      this.categoryId,
      this.disable,
      this.jobs,
      this.popular});

  CitiesModel.fromJson(
    Map<String, dynamic> json,
  ) {
    id = json['id'];
    text = json['name'];
    name = json['name'];
    nameAr = json['nameAr'];
    slug = json['slug'];
    category = json['category'];
    categoryId = json['categoryId'];
    disable = json['disable'];
    jobs = json['jobs'];
    popular = json['popular'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['nameAr'] = this.nameAr;
    data['slug'] = this.slug;
    data['category'] = this.category;
    data['categoryId'] = this.categoryId;
    data['disable'] = this.disable;
    data['jobs'] = this.jobs;
    data['popular'] = this.popular;
    return data;
  }
}
