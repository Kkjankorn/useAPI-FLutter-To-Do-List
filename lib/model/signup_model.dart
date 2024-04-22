// To parse this JSON data, do
//
//     final signupModel = signupModelFromJson(jsonString);

import 'dart:convert';

SignupModel signupModelFromJson(String str) =>
    SignupModel.fromJson(json.decode(str));

String signupModelToJson(SignupModel data) => json.encode(data.toJson());

class SignupModel {
  String userEmail;
  String userPassword;
  String userFname;
  String userLname;

  SignupModel({
    required this.userEmail,
    required this.userPassword,
    required this.userFname,
    required this.userLname,
  });

  factory SignupModel.fromJson(Map<String, dynamic> json) => SignupModel(
        userEmail: json["user_email"],
        userPassword: json["user_password"],
        userFname: json["user_fname"],
        userLname: json["user_lname"],
      );

  Map<String, dynamic> toJson() => {
        "user_email": userEmail,
        "user_password": userPassword,
        "user_fname": userFname,
        "user_lname": userLname,
      };
}
