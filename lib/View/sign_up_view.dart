import 'package:flutter/material.dart';
import 'package:flutter_application/View/sing_in_view.dart';
import 'package:flutter_application/controller/signup_coltroller.dart';
import 'package:flutter_application/style/app_style.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:hexcolor/hexcolor.dart';

class Sign_up extends StatefulWidget {
  const Sign_up({Key? key}) : super(key: key);

  @override
  State<Sign_up> createState() => _Sign_upState();
}

class _Sign_upState extends State<Sign_up> {
  final first_name = TextEditingController();
  final last_name = TextEditingController();
  final email = TextEditingController();
  final pass = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  SignupController signup_con = SignupController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage("asset/images/signup.png"))),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(20, 60, 0, 0),
                    child: Row(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            FloatingActionButton.small(
                              backgroundColor: HexColor("#53CD9F"),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Sign_in()));
                              },
                              child: Icon(
                                Icons.arrow_back,
                                color: HexColor("#00503E"),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          width: 70,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Styletxt("SIGN UP", 20, FontWeight.w500),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Styletxt("Please enter the information", 16, FontWeight.w400),
                  Styletxt("below access.", 16, FontWeight.w400),
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                      height: 98,
                      width: 98,
                      child: Image(image: Svg("asset/images/signup.svg"))),
                  SizedBox(
                    height: 30,
                  ),
                  TextBox1(
                      "First name", false, first_name, 'Enter Your First name'),
                  TextBox1(
                      "Last name", false, last_name, 'Enter Your Last name'),
                  TextBox1("Email", false, email, 'Enter Your Email'),
                  TextBox1("Password", true, pass, 'Enter Your Password'),
                  SizedBox(height: 30),
                  ButtonApp(() {
                    if (_formKey.currentState!.validate()) {
                      signup_con.signupUser(
                          first_name, last_name, email, pass, context);
                    }
                  }, "SIGN UP", 20, FontWeight.w400)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
