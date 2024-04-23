import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:medhealth/main_page.dart';
import 'package:medhealth/pages/home_page.dart';
import 'package:medhealth/pages/register_page.dart';
import 'package:medhealth/theme.dart';
import 'package:medhealth/widget/button_primary.dart';
import 'package:medhealth/widget/general_logo_space.dart';

class LoginPages extends StatefulWidget {
  const LoginPages({Key? key}) : super(key: key);

  @override
  State<LoginPages> createState() => _LoginPagesState();
}

class _LoginPagesState extends State<LoginPages> {
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();

  final _formkey = GlobalKey<FormState>();

  userLogin() async {
    if (_formkey.currentState!.validate()) {
      String email = emailcontroller.text;
      String password = passwordcontroller.text;

      try {
        await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: email, password: password);
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => MainPages()));
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: greenColor,
            content: Text(
              "No User Found for that Email",
              style: TextStyle(fontSize: 18.0),
            ),
          ));
        } else if (e.code == 'wrong-password') {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: greenColor,
            content: Text(
              "Wrong Password Provided by User",
              style: TextStyle(fontSize: 18.0),
            ),
          ));
        }
      }
    }
  }

  bool _secureText = true;
  void showHide() {
    setState(() {
      _secureText = !_secureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Container(
            child: GeneralLogoSpace(
              child: Column(
                children: [Text("")],
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(24),
            child: Form(
              key: _formkey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 100,
                  ),
                  Text(
                    "LOGIN",
                    style: regularTextStyle.copyWith(fontSize: 25),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    "Log into your account",
                    style: regularTextStyle.copyWith(
                        fontSize: 15, color: greyLightColor),
                  ),
                  SizedBox(
                    height: 15,
                  ),

                  // NOTE :: TEXTFIELD
                  Container(
                    padding: EdgeInsets.only(left: 16),
                    height: 50,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                              color: Color(0x40000000),
                              offset: Offset(0, 1),
                              blurRadius: 4,
                              spreadRadius: 0)
                        ],
                        color: whiteColor),
                    width: MediaQuery.of(context).size.width,
                    child: TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please Enter Email Address';
                        }
                        return null;
                      },
                      controller: emailcontroller,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Email Address',
                          hintStyle: lightTextStyle.copyWith(
                              fontSize: 15, color: greyLightColor)),
                    ),
                  ),
                  SizedBox(
                    height: 24,
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 16),
                    height: 50,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                              color: Color(0x40000000),
                              offset: Offset(0, 1),
                              blurRadius: 4,
                              spreadRadius: 0)
                        ],
                        color: whiteColor),
                    width: MediaQuery.of(context).size.width,
                    child: TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please Enter Password';
                        }
                        return null;
                      },
                      controller: passwordcontroller,
                      obscureText: _secureText,
                      decoration: InputDecoration(
                          suffixIcon: IconButton(
                            onPressed: showHide,
                            icon: _secureText
                                ? Icon(
                                    Icons.visibility_off,
                                    size: 20,
                                  )
                                : Icon(
                                    Icons.visibility,
                                    size: 20,
                                  ),
                          ),
                          border: InputBorder.none,
                          hintText: 'Password',
                          hintStyle: lightTextStyle.copyWith(
                              fontSize: 15, color: greyLightColor)),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: ButtonPrimary(
                      text: "LOGIN",
                      onTap: userLogin,
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't have an account?",
                        style: lightTextStyle.copyWith(
                            color: greyLightColor, fontSize: 15),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => RegisterPages()),
                              (route) => false);
                        },
                        child: Text(
                          " Create account",
                          style: boldTextStyle.copyWith(
                              color: greenColor, fontSize: 15),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
