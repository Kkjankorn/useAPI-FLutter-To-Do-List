import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_application/View/sing_in_view.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../model/signin_model.dart';

class SignupController {
  final client = http.Client();
  final baseUrl = "http://192.168.26.33:6004/api";
  final token = "950b88051dc87fe3fcb0b4df25eee676";
  late SigninModel user; //class model ของ sign in

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

  void signupUser(
      TextEditingController fname,
      TextEditingController lname,
      TextEditingController email,
      TextEditingController pass,
      var context) async {
    String first_name = fname.text;
    String last_name = lname.text;
    String mail = email.text;
    String passw = pass.text;

    final json = {
      "user_fname": fname.text,
      "user_lname": lname.text,
      "user_email": email.text,
      "user_password": pass.text,
    };
    //log(json.toString());

    final url = Uri.parse('http://192.168.26.33:6004/api/create_user');

    final res =
        await client.post(url, body: jsonEncode(json), headers: getHeaders());
    //log(res.body);
    //var data = jsonDecode(res.body); //แปลงข้อมูล json
    //print(data);

    log(res.statusCode.toString());

    //user = Signup.fromJson(data);
    if (res.statusCode == 200) {
      showSnackBar('SIGN UP SUCCESS!!', context);
      SharedPreferences pref = await SharedPreferences.getInstance();
      pref.setString('fname', first_name);
      pref.setString('lname', last_name);
      pref.setString('email', mail);
      pref.setString('pass', passw);

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => Sign_in(
                //userdt: user,
                )),
      );
    } else if (res.statusCode == 400) {
      showSnackBar2('Duplicate or Incorect information.', context);
    } else {
      showSnackBar2('Database Error!', context);
    }
  }

  void clearLogin(TextEditingController email, TextEditingController pass) {
    email.clear();
    pass.clear();
  }
}
