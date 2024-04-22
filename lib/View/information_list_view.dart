import 'dart:developer';

import 'package:flutter_application/View/sing_in_view.dart';
import 'package:flutter_application/controller/addeditdelete_controller.dart';
import 'package:flutter_application/controller/signin_controller.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:intl/intl.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application/View/add_edit_todo_list_view.dart';
import 'package:flutter_application/model/data_model.dart';
import 'package:flutter_application/style/app_style.dart';

class Information extends StatefulWidget {
  final String firstname;
  final String lastname;
  final int userId;
  Information(
      {Key? key,
      required this.firstname,
      required this.lastname,
      required this.userId})
      : super(key: key);

  @override
  State<Information> createState() => _InformationState();
}

class _InformationState extends State<Information> {
  late String fname;
  late String lname;
  //late DataModel user;
  SigninController getTodo = SigninController();
  TextEditingController search = TextEditingController();
  //List<DataModel> toDolist = [];
  late int userid;
  DateFormat dateFormat = DateFormat('HH:mm a  dd/MM/yyyy');
  bool status = false;

  @override
  void initState() {
    super.initState();
    fname = widget.firstname;
    lname = widget.lastname;
    userid = widget.userId;
    log('$userid');
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final shouldPop = await showDialog<bool>(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('Do you want to go back?'),
              actionsAlignment: MainAxisAlignment.spaceBetween,
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context, true);
                  },
                  child: const Text('Yes'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context, false);
                  },
                  child: const Text('No'),
                ),
              ],
            );
          },
        );
        return shouldPop!;
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 57, 174, 134),
          leading: InkWell(
              onTap: () {
                showModalBottomSheet<void>(
                    context: context,
                    builder: (BuildContext context) {
                      return SizedBox(
                        height: 251,
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                height: 3,
                                width: 52,
                                color: Colors.grey,
                              ),
                              SizedBox(
                                height: 23,
                              ),
                              Styletxt("SIGN OUT", 20, FontWeight.w500),
                              SizedBox(
                                height: 19,
                              ),
                              Styletxt("Do you want to log out?", 16,
                                  FontWeight.w400),
                              SizedBox(
                                height: 50,
                              ),
                              Container(
                                height: 50,
                                width: 345,
                                decoration: BoxDecoration(
                                    border: Border(
                                  bottom: BorderSide(
                                    color: const Color.fromARGB(
                                        255, 217, 215, 215),
                                    width: 1.0,
                                  ),
                                )),
                                child: InkWell(
                                    child: EditDelete(
                                        //
                                        "Sign out",
                                        "asset/images/logout.svg",
                                        210,
                                        "asset/images/arrowright.svg"),
                                    onTap: () => Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => Sign_in()),
                                        )),
                              ),
                            ],
                          ),
                        ),
                      );
                    });
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: CircleAvatar(
                  child: Text(fname[0].toUpperCase()),
                ),
              )),
          title: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Hello!",
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.70,
                    child: Text(
                      "${fname} " + "${lname}",
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(20, 21, 18, 0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    TextField(
                      controller: search,
                      onChanged: (value) => setState(() {}),
                      decoration: InputDecoration(
                          hintText: "Search.....",
                          prefixIcon: Icon(Icons.search),
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15)))),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: FutureBuilder<List<DataModel>>(
                  future: getTodo.getData(userid),
                  builder: (context, snapshot) {
                    //log('in controll ${getTodo.toDolist.length}');
                    if (snapshot.data == null) {
                      return Center();
                    } else if (snapshot.data!.length == 0) {
                      return Center();
                    } else {
                      //log('Data from future${snapshot.data!.length}');

                      return Padding(
                        padding: const EdgeInsets.fromLTRB(10, 5, 17, 5),
                        child: ListView.builder(
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            //log('${snapshot.data!.length}');
                            DataModel getdata = snapshot.data![index];
                            DateTime dataDate = getdata.userTodoListLastUpdate;
                            String formattedDate = dateFormat.format(dataDate);
                            //int checkin = snapshot.data!.length;
                            //log(' data from list $checkin');
                            if (!getdata.userTodoListTitle
                                    .toLowerCase()
                                    .contains(search.text.toLowerCase()) ||
                                !getdata.userTodoListTitle
                                    .toUpperCase()
                                    .contains(search.text.toUpperCase())) {
                              return Container(
                                height: 0,
                              );
                            }
                            return Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    blurRadius: 7,
                                    // offset: Offset(1, 1),
                                  ),
                                ],
                              ),
                              margin: EdgeInsets.symmetric(vertical: 5),
                              padding: EdgeInsets.symmetric(horizontal: 3),
                              height: 130,
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          getdata.userTodoListCompleted == '1'
                                              ? Image(
                                                  width: 32,
                                                  height: 32,
                                                  image: Svg(
                                                      'asset/images/true.svg'),
                                                )
                                              : Image(
                                                  width: 32,
                                                  height: 32,
                                                  image: Svg(
                                                      'asset/images/false.svg'),
                                                ),
                                          Container(
                                            width: 290,
                                            child: Wrap(
                                              children: [
                                                Styletxt(
                                                    '${getdata.userTodoListTitle}',
                                                    20,
                                                    FontWeight.w500)
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                      InkWell(
                                        child: Icon(Icons.more_horiz_outlined),
                                        onTap: () {
                                          showModalBottomSheet(
                                              context: context,
                                              builder: (context) {
                                                return SizedBox(
                                                  height: 251,
                                                  child: Center(
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: <Widget>[
                                                        Container(
                                                          margin: EdgeInsets
                                                              .symmetric(
                                                                  vertical: 16),
                                                          height: 3,
                                                          width: 52,
                                                          color: Colors.grey,
                                                        ),
                                                        SizedBox(
                                                          height: 56,
                                                        ),
                                                        Container(
                                                          height: 60,
                                                          width: 345,
                                                          decoration:
                                                              BoxDecoration(
                                                                  border:
                                                                      Border(
                                                            bottom: BorderSide(
                                                              color: Color
                                                                  .fromARGB(
                                                                      255,
                                                                      217,
                                                                      215,
                                                                      215),
                                                              width: 1.0,
                                                            ),
                                                          )),
                                                          child: InkWell(
                                                              child: EditDelete(
                                                                  "Edit",
                                                                  "asset/images/edit.svg",
                                                                  239,
                                                                  "asset/images/arrowright.svg"),
                                                              onTap: () {
                                                                Navigator.push(
                                                                    context,
                                                                    MaterialPageRoute(
                                                                        builder: (context) =>
                                                                            AddTodoList(
                                                                              userId: userid,
                                                                              title: getdata.userTodoListTitle,
                                                                              description: getdata.userTodoListDesc,
                                                                              status: getdata.userTodoListCompleted,
                                                                              appbar: "Your Todo",
                                                                              listId: getdata.userTodoListId,
                                                                              sbut: getdata.userTodoListCompleted == '1' ? true : false,
                                                                            ))).then(
                                                                  (value) =>
                                                                      setState(
                                                                          () {
                                                                    Navigator.of(
                                                                            context)
                                                                        .pop();
                                                                  }),
                                                                );
                                                              }),
                                                        ),
                                                        Container(
                                                          height: 50,
                                                          width: 345,
                                                          decoration:
                                                              BoxDecoration(
                                                                  border:
                                                                      Border(
                                                            top: BorderSide(
                                                              color: Color
                                                                  .fromARGB(
                                                                      255,
                                                                      217,
                                                                      215,
                                                                      215),
                                                              width: 1.0,
                                                            ),
                                                          )),
                                                          child: InkWell(
                                                              child: EditDelete(
                                                                  "Delete",
                                                                  "asset/images/trash.svg",
                                                                  220,
                                                                  "asset/images/arrowright.svg"),
                                                              onTap: () {
                                                                AddEditDeleteCon()
                                                                    .deleteTodo(
                                                                        getdata
                                                                            .userTodoListId,
                                                                        context);
                                                                setState(() {});
                                                              }),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                );
                                              });
                                        },
                                      )
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Container(
                                        width: 290,
                                        child: Wrap(
                                          children: [
                                            Styletxt('${formattedDate}', 12,
                                                FontWeight.w200),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        width: 290,
                                        height: 75,
                                        child: Wrap(
                                          children: [
                                            Styletxt(
                                                '${getdata.userTodoListDesc}',
                                                12,
                                                FontWeight.w300),
                                          ],
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            );
                            // Container();
                          },
                        ),
                      );
                    }
                  }),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: const Color.fromRGBO(82, 170, 94, 1.0),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => AddTodoList(
                          userId: userid,
                          appbar: "Add your Todo",
                          title: '',
                          description: '',
                          status: '',
                          listId: 1,
                          sbut: status,
                        ))).then((value) => setState(() {}));
          },
          shape: CircleBorder(),
          child: Image(image: Svg("asset/images/iconbuttonadd.svg")),
        ),
        //viewpopscope
      ),
    );
  }
}
