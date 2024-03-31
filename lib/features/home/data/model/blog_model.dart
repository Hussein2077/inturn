class BlogModel {
  final int? blogId;
  final String? blogName;
  final String? blogNameAr;

  BlogModel({
    required this.blogId,
    required this.blogName,
    required this.blogNameAr,
  });

  factory BlogModel.fromJson(Map<String, dynamic> json) {
    return BlogModel(
      blogId: json['blogId'],
      blogName: json['blogName'],
      blogNameAr: json['blogNameAr'],
    );
  }
}
