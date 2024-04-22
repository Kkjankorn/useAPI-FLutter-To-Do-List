import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_application/model/addTodo_Model.dart';
import 'package:http/http.dart' as http;

class AddEditDeleteCon {
  final client = http.Client();
  final baseUrl = "http://192.168.26.33:6004/api";
  final token = "950b88051dc87fe3fcb0b4df25eee676";
  late AddTodoModel user; //class model ของ sign in

  //set headers
  dynamic getHeaders() {
    final header = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    };

    return header;
  }

  void showSnackBar(String text, var context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
          duration: Duration(seconds: 1),
          backgroundColor: Color.fromRGBO(13, 122, 92, 1),
          content: Text(text, style: TextStyle(color: Colors.white))),
    );
  }

  void showSnackBar2(String text, var context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
          duration: Duration(seconds: 1),
          backgroundColor: Color.fromRGBO(150, 31, 31, 1),
          content: Text(text, style: TextStyle(color: Colors.white))),
    );
  }

  void addTodo(TextEditingController todoTitle, TextEditingController todoDesc,
      String todoStatus, int userId, context) async {
    final json = {
      "user_todo_list_title": todoTitle.text,
      "user_todo_list_desc": todoDesc.text,
      "user_todo_list_completed": todoStatus,
      "user_id": userId,
    };
    final url = Uri.parse('http://192.168.26.33:6004/api/create_todo');

    final res =
        await client.post(url, body: jsonEncode(json), headers: getHeaders());

    if (res.statusCode == 200 &&
        todoTitle.text.isNotEmpty &&
        todoDesc.text.isNotEmpty) {
      showSnackBar('Add Todo Complete', context);
      Navigator.pop(context);
    } else if (res.statusCode == 400 && todoTitle.text.isEmpty ||
        todoDesc.text.isEmpty) {
      showSnackBar2('Add Todo Fail!!', context);
    } else {
      showSnackBar2('Add Todo Fail!!', context);
    }
  }

  void editTodo(TextEditingController todoTitle, TextEditingController todoDesc,
      String todoStatus, int userId, int listId, context) async {
    final json = {
      "user_todo_list_id": listId,
      "user_todo_list_title": todoTitle.text,
      "user_todo_list_desc": todoDesc.text,
      "user_todo_list_completed": todoStatus,
      "user_id": userId,
      "user_todo_type_id": 1
    };
    final url = Uri.parse('http://192.168.26.33:6004/api/update_todo/');

    final res =
        await client.post(url, body: jsonEncode(json), headers: getHeaders());
    if (res.statusCode == 200) {
      showSnackBar('Edite Todo Complete', context);
      Navigator.pop(context);
    } else if (res.statusCode == 400) {
      showSnackBar2('Edite Todo Fail!!', context);
    } else {
      showSnackBar2('Database Error!', context);
    }
  }

  void deleteTodo(int todoId, context) async {
    final json = {
      "user_todo_list_id": todoId,
    };
    final url =
        Uri.parse('http://192.168.26.33:6004/api/delete_todo/${todoId}');

    final res =
        await client.delete(url, body: jsonEncode(json), headers: getHeaders());

    if (res.statusCode == 200) {
      showSnackBar('DELETE SUCCESS!!', context);
      Navigator.pop(context);
    } else if (res.statusCode == 400) {
      showSnackBar2('incorrect.', context);
    } else {
      showSnackBar2('Delete Todo Fail!!', context);
    }
  }
}
