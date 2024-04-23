import 'dart:developer';
import 'package:flutter_application/View/sing_in_view.dart';
import 'package:flutter_application/controller/addeditdelete_controller.dart';
import 'package:flutter_application/controller/signin_controller.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:hexcolor/hexcolor.dart';
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
  SigninController getTodo = SigninController();
  TextEditingController search = TextEditingController();
  DateFormat dateFormat = DateFormat('HH:mm a  dd/MM/yyyy');
  bool status = false;

  @override
  void initState() {
    super.initState();
    //log('$userid');
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: WillPopScope(
        onWillPop: () async {
          final shouldPop = await showDialog<bool>(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text('Do you want to go out?'),
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
          appBar: appBarWidget(
            fname: widget.firstname,
            lname: widget.lastname,
            appBar: AppBar(),
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
                    future: getTodo.getData(widget.userId),
                    builder: (context, snapshot) {
                      if (snapshot.data == null) {
                        return Center(
                            // child: Text(
                            //   "ไม่พบข้อมูล",
                            //   style: TextStyle(
                            //       color: Colors.red,
                            //       fontWeight: FontWeight.bold,
                            //       fontStyle: FontStyle.italic),
                            // ),
                            );
                      } else if (snapshot.data!.length == 0) {
                        return Center();
                      } else {
                        return Padding(
                          padding: const EdgeInsets.fromLTRB(10, 5, 17, 5),
                          child: ListView.builder(
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index) {
                              DataModel getdata = snapshot.data![index];
                              DateTime dataDate =
                                  getdata.userTodoListLastUpdate;
                              String formattedDate =
                                  dateFormat.format(dataDate);
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
                                padding: EdgeInsets.symmetric(
                                    horizontal: 5, vertical: 10),
                                height: 145,
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
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.70,
                                                child: Text(
                                                    '${getdata.userTodoListTitle}',
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    maxLines: 1,
                                                    style: TextStyle(
                                                        fontSize: 20,
                                                        color: HexColor(
                                                            "#53CD9F"))))
                                          ],
                                        ),
                                        InkWell(
                                          child:
                                              Icon(Icons.more_horiz_outlined),
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
                                                                    vertical:
                                                                        16),
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
                                                              bottom:
                                                                  BorderSide(
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
                                                                          builder: (context) => AddTodoList(
                                                                                appbar: "Edit Your Todo",
                                                                                dataModel: getdata,
                                                                                userId: getdata.userId,
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
                                                                  setState(
                                                                      () {});
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
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.8,
                                          child: Wrap(
                                            children: [
                                              Styletxt('${formattedDate}', 12,
                                                  FontWeight.w200),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.8,
                                          height: 70,
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
                            appbar: "Add your Todo",
                            dataModel: null,
                            userId: widget.userId,
                          ))).then((value) => setState(() {}));
            },
            shape: CircleBorder(),
            child: Image(image: Svg("asset/images/iconbuttonadd.svg")),
          ),
        ),
      ),
    );
  }
}

class appBarWidget extends StatelessWidget implements PreferredSizeWidget {
  const appBarWidget({
    super.key,
    required this.fname,
    required this.lname,
    required this.appBar,
  });

  final String fname;
  final String lname;
  final AppBar appBar;

  @override
  Widget build(BuildContext context) {
    return AppBar(
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
                          Styletxt(
                              "Do you want to log out?", 16, FontWeight.w400),
                          SizedBox(
                            height: 50,
                          ),
                          Container(
                            height: 50,
                            width: 345,
                            decoration: BoxDecoration(
                                border: Border(
                              bottom: BorderSide(
                                color: const Color.fromARGB(255, 217, 215, 215),
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
                                onTap: () => {
                                      Navigator.pushAndRemoveUntil(context,
                                          MaterialPageRoute(builder: (context) {
                                        return Sign_in();
                                      }), (route) => false)
                                    }),
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
                style: TextStyle(
                    fontSize: 12,
                    color: Colors.white,
                    fontWeight: FontWeight.w500),
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
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => new Size.fromHeight(appBar.preferredSize.height);
}
