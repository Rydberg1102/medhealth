import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:medhealth/pages/home_page.dart';
import 'package:medhealth/pages/login_page.dart';
import 'package:medhealth/theme.dart';
import 'package:medhealth/widget/button_primary.dart';
import 'package:medhealth/widget/general_logo_space.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RegisterPages extends StatefulWidget {
  const RegisterPages({Key? key}) : super(key: key);

  @override
  State<RegisterPages> createState() => _RegisterPagesState();
}

class _RegisterPagesState extends State<RegisterPages> {
  String fullname = "", email = "", phone = "", address = "", password = "";
  TextEditingController fullnamecontroller = TextEditingController();
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController phonecontroller = TextEditingController();
  TextEditingController addresscontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();

  final _formkey = GlobalKey<FormState>();

  registration() async {
    // Create User
    if (_formkey.currentState!.validate()) {
      email = emailcontroller.text;
      password = passwordcontroller.text;

      try {
        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
            "Registered Successfully",
            style: TextStyle(fontSize: 20.0),
          ),
        ));
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => LoginPages()));
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: greenColor,
            content: Text(
              "Password Provided is too weak",
              style: TextStyle(fontSize: 18.0),
            ),
          ));
        } else if (e.code == "email-already-in-use") {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: greenColor,
            content: Text(
              "Account Already Exists",
              style: TextStyle(fontSize: 18.0),
            ),
          ));
        }
      }
      // add user detail
      addUserDetail(
        fullnamecontroller.text.trim(),
        emailcontroller.text.trim(),
        int.parse(phonecontroller.text.trim()),
        addresscontroller.text.trim(),
        passwordcontroller.text.trim(),
      );
    }
  }

  Future addUserDetail(String fullname, String email, int phone, String address,
      String password) async {
    await FirebaseFirestore.instance.collection('user').add({
      'fullname': fullname,
      'email address': email,
      'phone': phone,
      'home address': address,
      'password': password
    });
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
                  Text(
                    "REGISTER",
                    style: regularTextStyle.copyWith(fontSize: 25),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    "Register your new account",
                    style: regularTextStyle.copyWith(
                        fontSize: 15, color: greyLightColor),
                  ),
                  SizedBox(
                    height: 10,
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
                          return 'Please Enter Fullname';
                        }
                        return null;
                      },
                      controller: fullnamecontroller,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Fullname',
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
                          return 'Please Enter Phone';
                        }
                        return null;
                      },
                      controller: phonecontroller,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Phone',
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
                          return 'Please Enter Home Address';
                        }
                        return null;
                      },
                      controller: addresscontroller,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Home Address',
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
                      text: "REGISTER",
                      onTap: registration, // Call the registration method here
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Already have an account?",
                        style: lightTextStyle.copyWith(
                            color: greyLightColor, fontSize: 15),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginPages()),
                              (route) => false);
                        },
                        child: Text(
                          " Login now",
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
