// To parse this JSON data, do
//
//     final signinModel = signinModelFromJson(jsonString);

import 'dart:convert';

SigninModel signinModelFromJson(String str) =>
    SigninModel.fromJson(json.decode(str));

String signinModelToJson(SigninModel data) => json.encode(data.toJson());

class SigninModel {
  int userId;
  String userEmail;
  String userPassword;
  String userFname;
  String userLname;

  SigninModel({
    required this.userId,
    required this.userEmail,
    required this.userPassword,
    required this.userFname,
    required this.userLname,
  });

  factory SigninModel.fromJson(Map<String, dynamic> json) => SigninModel(
        userId: json["user_id"],
        userEmail: json["user_email"],
        userPassword: json["user_password"],
        userFname: json["user_fname"],
        userLname: json["user_lname"],
      );

  Map<String, dynamic> toJson() => {
        "user_id": userId,
        "user_email": userEmail,
        "user_password": userPassword,
        "user_fname": userFname,
        "user_lname": userLname,
      };
}
