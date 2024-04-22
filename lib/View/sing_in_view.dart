import 'package:flutter/material.dart';
import 'package:flutter_application/View/sign_up_view.dart';
import 'package:flutter_application/controller/signin_controller.dart';
import 'package:flutter_application/style/app_style.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';

class Sign_in extends StatefulWidget {
  const Sign_in({Key? key}) : super(key: key);

  @override
  State<Sign_in> createState() => _Sign_inState();
}

class _Sign_inState extends State<Sign_in> {
  final emailController = TextEditingController();
  final passController = TextEditingController();

  SigninController singin_con = SigninController();

  Widget build(BuildContext context) {
    return Form(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage("asset/images/signup.png"))),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 59, 0, 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [Styletxt("SIGN IN", 20, FontWeight.w500)],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Styletxt(
                            "Please enter the information", 16, FontWeight.w400)
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Styletxt("below access.", 16, FontWeight.w400)
                      ],
                    ),
                    SizedBox(
                      height: 35,
                    ),
                    Container(
                        height: 98,
                        width: 98,
                        child: Image(image: Svg("asset/images/log.svg"))),
                    SizedBox(
                      height: 34,
                    ),
                  ],
                ),
                Column(
                  children: [
                    TextBox1(
                        "Email", false, emailController, 'Enter Your Email'),
                    SizedBox(
                      height: 19,
                    ),
                    TextBox1("Password", true, passController,
                        'Enter Your Password'),
                    SizedBox(
                      height: 19,
                    ),
                    Container(
                        padding: EdgeInsets.fromLTRB(10, 10, 30, 40),
                        alignment: Alignment.centerRight,
                        child: Material(
                          type: MaterialType.transparency,
                          child: InkWell(
                            child: Styletxt(
                                'Forget Password?', 15, FontWeight.w500),
                            onTap: () {},
                          ),
                        )),
                  ],
                ),
                Column(
                  children: [
                    ButtonApp(() {
                      // if (_formKey.currentState!.validate()) {
                      //   _formKey.currentState!.save();
                      //   // Do something with the validated input
                      // }
                      EasyLoading.show(status: 'loading...');
                      singin_con.signinUser(
                          emailController, passController, context);
                      EasyLoading.dismiss();
                    }, "SIGN IN", 20, FontWeight.w400),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 50),
                      child: ButtonApp(() {
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (context) => Sign_up()));
                      }, "SIGN UP", 20, FontWeight.w400),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
