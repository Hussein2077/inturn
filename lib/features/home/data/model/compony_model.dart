import 'package:flutter/material.dart';

class CompanyModel {
  final String name;
  final String image;
  final String description;
  final String experience;
  final int minSalary;
  final int maxSalary;
  final String createDate;
  final String provinceName;
  final int provinceId;
  final String avatarUrl;
  final String websiteURL;
  final String major;
  final String titleEN;
  final String titleAr;
  final String companyName;
  final String type;

  CompanyModel({
    required this.name,
    required this.image,
    required this.description,
    required this.experience,
    required this.minSalary,
    required this.maxSalary,
    required this.createDate,
    required this.provinceName,
    required this.provinceId,
    required this.avatarUrl,
    required this.websiteURL,
    required this.major,
    required this.titleEN,
    required this.titleAr,
    required this.companyName,
    required this.type,
  });

  factory CompanyModel.fromJson(Map<String, dynamic> json) {
    return CompanyModel(
      name: json['name'] ?? "",
      image: json['avatarUrl'] ?? "",
      type: json['type'] ?? "Full Time",
      description: json['description'] ?? "",
      experience: json['experience'] ?? "",
      minSalary: json['minSalary'] ?? 1000,
      maxSalary: json['maxSalary'] ?? 5000,
      createDate: json['createDate'] ?? "",
      provinceName: json['provinceName'] ?? "",
      provinceId: json['provinceId'] ?? 0,
      avatarUrl: json['avatarUrl'] ?? "",
      websiteURL: json['websiteURL'] ?? "",
      major: json['major'] ?? "",
      titleEN: json['titleEN'] ?? "",
      titleAr: json['titleAr'] ?? "",
      companyName: json['companyName'] ?? "",
    );
  }
}
