import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_application/controller/addeditdelete_controller.dart';
import 'package:flutter_application/style/app_style.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

class AddTodoList extends StatefulWidget {
  int userId, listId;
  String appbar;
  String title, description, status;
  bool sbut;
  AddTodoList(
      {super.key,
      required this.userId,
      required this.listId,
      required this.appbar,
      required this.title,
      required this.description,
      required this.status,
      required this.sbut});

  @override
  State<AddTodoList> createState() => _AddTodoListState();
}

class _AddTodoListState extends State<AddTodoList> {
  final title = TextEditingController();
  final description = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  AddEditDeleteCon adlTodoList = AddEditDeleteCon();
  late int userId, listId;
  late String appbar;
  bool estatus = false;
  late String success;

  @override
  void initState() {
    super.initState();
    listId = widget.listId;
    userId = widget.userId;
    appbar = widget.appbar;
    title.text = widget.title;
    description.text = widget.description;
    success = widget.status;
    estatus = widget.sbut;
  }

  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
            backgroundColor: HexColor("#53CD9F"),
            title: Styletxt("$appbar", 20, FontWeight.w500)),
        body: SingleChildScrollView(
          child: appbar == 'Add your Todo'
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 21, 0, 21),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            TextBox2("Title", title, 'Enter your Title'),
                            SizedBox(
                              height: 10,
                            ),
                            FieldText("Descrtiption", description,
                                'Enter your Description'),
                            SizedBox(height: 10),
                            Container(
                                width: MediaQuery.of(context).size.width * 0.90,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(color: Colors.grey)),
                                child: SwitchListTile(
                                    value: estatus,
                                    onChanged: (value) {
                                      setState(() {
                                        estatus = value;
                                        if (estatus == true) {
                                          success = '1';
                                        } else {
                                          success = '0';
                                        }
                                      });
                                    },
                                    title: Text('Success'),
                                    activeColor: HexColor("#00503E"))),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.3,
                            ),
                            Container(
                                width: MediaQuery.of(context).size.width * 0.90,
                                height: 70,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    gradient: LinearGradient(colors: [
                                      HexColor("#53CD9F"),
                                      HexColor("#0D7A5C")
                                    ])),
                                child: Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.8,
                                  child: ElevatedButton(
                                    child: Text(
                                      'SAVE',
                                      style: GoogleFonts.outfit(
                                          textStyle: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.white)),
                                    ),
                                    onPressed: () async {
                                      if (_formKey.currentState!.validate()) {
                                        if (title.text.isNotEmpty &&
                                            description.text.isNotEmpty) {
                                          adlTodoList.addTodo(
                                              title,
                                              description,
                                              success,
                                              userId,
                                              context);
                                        } else {
                                          //log("dont sent");
                                          AddEditDeleteCon().showSnackBar2(
                                              "Pleas Enter Information",
                                              context);
                                        }
                                      }
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor:
                                          Color.fromARGB(0, 193, 21, 21),
                                      foregroundColor: Colors.black,
                                      elevation: 0,
                                    ),
                                  ),
                                ))
                          ],
                        ),
                      ),
                    ),
                  ],
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 21, 0, 21),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          TextBox2("Title", title, 'Enter your Title'),
                          SizedBox(
                            height: 10,
                          ),
                          FieldText("Description", description,
                              'Enter your Description'),
                          SizedBox(height: 10),
                          Container(
                              height: 59,
                              width: MediaQuery.of(context).size.width * 0.90,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(color: Colors.grey)),
                              child: SwitchListTile(
                                  value: estatus,
                                  onChanged: (value) {
                                    setState(() {
                                      estatus = value;
                                      if (estatus == true) {
                                        success = '1';
                                      } else {
                                        success = '0';
                                      }
                                    });
                                  },
                                  title: Text('Success'),
                                  activeColor: HexColor("#00503E"))),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.3,
                          ),
                          Container(
                              width: MediaQuery.of(context).size.width * 0.9,
                              height: 70,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  gradient: LinearGradient(colors: [
                                    HexColor("#53CD9F"),
                                    HexColor("#0D7A5C")
                                  ])),
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.8,
                                child: ElevatedButton(
                                  child: Text(
                                    'SAVE',
                                    style: GoogleFonts.outfit(
                                        textStyle: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.white)),
                                  ),
                                  onPressed: () async {
                                    setState(() {
                                      adlTodoList.editTodo(title, description,
                                          success, userId, listId, context);
                                    });
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        Color.fromARGB(0, 193, 21, 21),
                                    foregroundColor: Colors.black,
                                    elevation: 0,
                                  ),
                                ),
                              ))
                        ],
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
