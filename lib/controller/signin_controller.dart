import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_application/View/information_list_view.dart';
import 'package:flutter_application/model/data_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../model/signin_model.dart';

class SigninController {
  final client = http.Client();
  final baseUrl = "http://192.168.26.33:6004/api";
  final token = "950b88051dc87fe3fcb0b4df25eee676";
  late SigninModel user; //class model ของ sign in
  late DataModel data; //class model ของ sign in

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

  void signinUser(TextEditingController email, TextEditingController pass,
      var context) async {
    String mail = email.text;
    String passw = pass.text;
    final json = {
      "user_email": email.text,
      "user_password": pass.text,
    };
    //log(json.toString());
    //log('signin');
    try {
      final url = Uri.parse('http://192.168.26.33:6004/api/login');

      final res =
          await client.post(url, body: jsonEncode(json), headers: getHeaders());
      //log(res.body);
      var data = jsonDecode(res.body); //แปลงข้อมูล json

      //log(res.statusCode.toString());

      if (res.statusCode == 200) {
        showSnackBar('SIGN IN SUCCESS!!', context);
        SharedPreferences pref = await SharedPreferences.getInstance();
        pref.setString('email', mail);
        pref.setString('pass', passw);
        user = SigninModel.fromJson(data);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => Information(
                    firstname: '${user.userFname}',
                    lastname: '${user.userLname}',
                    userId: user.userId,
                    //userdt: user,
                  )),
        );
      } else if (res.statusCode == 400) {
        showSnackBar2('Email or password is incorrect.', context);
      } else {
        showSnackBar('Database Error!', context);
      }
    } catch (e) {
      //log(e.toString());
    }
  }

  late List<DataModel> toDolist = [];

  Future<List<DataModel>> getData(int userId) async {
    print('message');
    toDolist.clear();
    final url = Uri.parse('http://192.168.26.33:6004/api/todo_list/$userId');
    final res = await http.get(url, headers: {
      'Authorization': 'Bearer 950b88051dc87fe3fcb0b4df25eee676',
      'Content-Type': 'application/json',
    });

    var data = json.decode(res.body);
    //log('data${data}');
    toDolist = [];
    for (var e in data) {
      toDolist.add(DataModel.fromJson(e));
      //log('data${toDolist}');
    }
    // if (toDolist.isEmpty) {

    // }

    toDolist.sort(
        (a, b) => b.userTodoListLastUpdate.compareTo(a.userTodoListLastUpdate));
    return toDolist;
  }

  void clearLogin(TextEditingController email, TextEditingController pass) {
    email.clear();
    pass.clear();
  }
}
