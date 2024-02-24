// To parse this JSON data, do
//
//     final users = welcomeFromJson(jsonString);


class Users {
  int? userId;
  String usrName;
  String password;

  Users({
     this.userId,
    required this.usrName,
    required this.password,
  });

  factory Users.fromJson(Map<String, dynamic> json) => Users(
    userId: json["userId"],
    usrName: json["usrName"],
    password: json["password"],
  );

  Map<String, dynamic> toMap() => {
    "userId": userId,
    "usrName": usrName,
    "password": password,
  };
}
