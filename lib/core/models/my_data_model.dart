class MyDataModel {
  String? id;
  String? email;
  String? name;
  String? message;
  bool? isCompleted;

  bool? isAuthenticated;

  int? complition;

  static MyDataModel? _instance;

  void clearObject() {
    _instance = null;
  }

  MyDataModel({
    this.id,
    this.name,
    this.email,
    this.isCompleted,
    this.isAuthenticated,
    this.complition,
    this.message,
  });

  setNewMyData({
    String? id,
    String? email,
    String? name,
    String? message,
    bool? isCompleted,
    bool? isAuthenticated,
    int? complition,
  }) {
    this.id = id ?? this.id;
    this.name = name ?? this.name;
    this.email = email ?? this.email;
    this.isCompleted = isCompleted ?? this.isCompleted;
    this.isAuthenticated = isAuthenticated ?? this.isAuthenticated;
    this.complition = complition ?? this.complition;
    this.message = message ?? this.message;
  }

  factory MyDataModel.fromMap(Map<String, dynamic> map) {
    if (_instance == null) {
      //create  first time
      _instance = MyDataModel(
        id: map['userId'] ?? '0',
        email: map['email'] ?? '',
        isCompleted: map['isCompleted'] ?? false,
        isAuthenticated: map['isAuthenticated'] ?? false,
        complition: map['complition'] ?? 0,
        message: map['message'] ?? '',
        name: map['name'] ?? '',
      );
    } else {
      _instance?.setNewMyData(
        id: map['userId'] ?? '0',
        email: map['email'] ?? '',
        isCompleted: map['isCompleted'] ?? false,
        isAuthenticated: map['isAuthenticated'] ?? false,
        complition: map['complition'] ?? 0,
        message: map['message'] ?? '',
        name: map['name'] ?? '',
      );
    }

    return _instance!;
  }

  static MyDataModel getInstance() {
    return _instance ?? MyDataModel();
  }
}
