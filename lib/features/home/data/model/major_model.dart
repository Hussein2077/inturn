class MajorModel {
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
}


class Position {
  final int majorId;
  final String majorNameEn;
  final String majorNameAr;
  final String majorRank;
  final int majorCategoryId;
  final String creationDate;
  final String lastModificationTime;
  final String creatorUserId;
  final int lastModificationUserId;
  final int deleteStatusId;

  Position({
    required this.majorId,
    required this.majorNameEn,
    required this.majorNameAr,
    required this.majorRank,
    required this.majorCategoryId,
    required this.creationDate,
    required this.lastModificationTime,
    required this.creatorUserId,
    required this.lastModificationUserId,
    required this.deleteStatusId,
  });

  factory Position.fromJson(Map<String, dynamic> json) {
    return Position(
      majorId: json['majorId'],
      majorNameEn: json['majorNameEn'],
      majorNameAr: json['majorNameAr'],
      majorRank: json['majorRank'],
      majorCategoryId: json['majorCategoryId'],
      creationDate: json['creationDate'],
      lastModificationTime: json['lastModificationTime'],
      creatorUserId: json['creatorUserId'],
      lastModificationUserId: json['lastModificationUserId'],
      deleteStatusId: json['deleteStatusId'],
    );
  }
}