// To parse this JSON data, do
//
//     final addTodoModel = addTodoModelFromJson(jsonString);

import 'dart:convert';

AddTodoModel addTodoModelFromJson(String str) =>
    AddTodoModel.fromJson(json.decode(str));

String addTodoModelToJson(AddTodoModel data) => json.encode(data.toJson());

class AddTodoModel {
  int userTodoTypeId;
  String userTodoListTitle;
  String userTodoListDesc;
  String userTodoListCompleted;
  int userId;

  AddTodoModel({
    required this.userTodoTypeId,
    required this.userTodoListTitle,
    required this.userTodoListDesc,
    required this.userTodoListCompleted,
    required this.userId,
  });

  factory AddTodoModel.fromJson(Map<String, dynamic> json) => AddTodoModel(
        userTodoTypeId: json["user_todo_type_id"],
        userTodoListTitle: json["user_todo_list_title"],
        userTodoListDesc: json["user_todo_list_desc"],
        userTodoListCompleted: json["user_todo_list_completed"],
        userId: json["user_id"],
      );

  Map<String, dynamic> toJson() => {
        "user_todo_type_id": userTodoTypeId,
        "user_todo_list_title": userTodoListTitle,
        "user_todo_list_desc": userTodoListDesc,
        "user_todo_list_completed": userTodoListCompleted,
        "user_id": userId,
      };
}
