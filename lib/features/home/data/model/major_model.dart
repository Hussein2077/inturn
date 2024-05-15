import 'package:equatable/equatable.dart';

class MajorModel extends Equatable {
  final String field;
  final List<Position> positions;

  MajorModel({required this.field, required this.positions});

  factory MajorModel.fromJson(Map<String, dynamic> json) {
    return MajorModel(
      field: json['Field'],
      positions: List<Position>.from(
        json['Position'].map((position) => Position.fromJson(position)),
      ),
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => [field, positions];
}


class Position extends Equatable {
  final int majorId;
  final String majorNameEn;
  final String majorNameAr;
  final String majorRank;
  final int majorCategoryId;



  Position({
    required this.majorId,
    required this.majorNameEn,
    required this.majorNameAr,
    required this.majorRank,
    required this.majorCategoryId,

  });

  factory Position.fromJson(Map<String, dynamic> json) {
    return Position(
      majorId: json['majorId']??0,
      majorNameEn: json['majorNameEn']??"",
      majorNameAr: json['majorNameAr']??"",
      majorRank: json['majorRank']??"",
      majorCategoryId: json['majorCategoryId']??0,

    );
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['majorId'] = majorId;
    map['majorNameEn'] = majorNameEn;
    map['majorNameAr'] = majorNameAr;
    map['majorRank'] = majorRank;
    return map;
  }

  @override
  // TODO: implement props
  List<Object?> get props => [
    majorId,
    majorNameEn,
    majorNameAr,
    majorRank

  ];

}
