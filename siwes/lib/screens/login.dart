// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:siwes/models/entry_date_response.dart';
import 'package:siwes/models/industry_supervisor_details.dart';
import 'package:siwes/models/login_response.dart';
import 'package:siwes/models/school_supervisor_profile.dart';
import 'package:siwes/models/student_details.dart';
import 'package:siwes/models/user_response.dart';
import 'package:siwes/services/remote_services.dart';
import 'package:siwes/utils/constants.dart';
import 'package:siwes/utils/defaultButton.dart';
import 'package:siwes/utils/defaultText.dart';

import '../utils/defaultTextFormField.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _form = GlobalKey<FormState>();

  late String _username;
  late String _password;
  bool _obscureText = false;

  @override
  void initState() {
    super.initState();
  }

  _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  getProfiles() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    List<SchoolSupervisorProfile>? schProfile =
        await RemoteServices.getSchProfile(context);

    List<StudentDetailResponse> stdProfile =
        await RemoteServices.getStdDetails();

    List<IndustrySupervisorDetails>? indProfile =
        await RemoteServices.getIndProfile();

    if (schProfile != null && schProfile.isNotEmpty) {
      var picEncode = base64Encode(schProfile[0].profilePicMemory);
      await pref.setStringList('profile',
          [schProfile[0].user.username, schProfile[0].user.email, picEncode]);
    } else if (stdProfile.isNotEmpty) {
      var picEncode = base64Encode(stdProfile[0].profilePicMem);
      await pref.setStringList('profile',
          [stdProfile[0].user.username, stdProfile[0].user.email, picEncode]);
    } else if (indProfile != null && indProfile.isNotEmpty) {
      var picEncode = base64Encode(indProfile[0].profileNoMemory);
      await pref.setStringList('profile',
          [indProfile[0].user.username, indProfile[0].user.email, picEncode]);
    }
    // else {
    //   Constants.dialogBox(
    //       context, "Profile not found", Colors.white, Icons.warning_rounded);
    // }
  }

  void _login() async {
    var isValid = _form.currentState!.validate(); //validation
    if (!isValid) return;
    _form.currentState!.save();

    LoginResponse? loginResponse =
        await RemoteServices().login(_username, _password);

    if (loginResponse != null) {
      //check if response returns key
      if (loginResponse.key != null) {
        print(loginResponse.key);
        SharedPreferences pref = await SharedPreferences.getInstance();
        await pref.setString("token", loginResponse.key.toString());
        await pref.setString("username", _username);

        // Navigator.popAndPushNamed(context, '/studentDashboard');

        UserResponse? user = await RemoteServices.getUser(context);

        //navigator to page according to user type
        if (user != null) {
          if (user.userType == 'student') {
            getProfiles();
            Navigator.popAndPushNamed(context, '/studentDashboard');
          } else if (user.userType == 'industry_based_supervisor') {
            getProfiles();
            Navigator.popAndPushNamed(context, '/industryDashboard');
          } else if (user.userType == 'school_based_supervisor') {
            //get profile
            getProfiles();
            Navigator.popAndPushNamed(context, '/schoolSupervisorDashboard');
          } else if (user.userType == 'admin') {
            showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    content: const DefaultText(
                      size: 15,
                      text: "Admin Page loading",
                    ),
                    actions: [
                      TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const DefaultText(size: 13, text: 'Ok'))
                    ],
                  );
                });
          }
        } else {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: DefaultText(size: 15.0, text: "User not found")));
        }
      }

      //check if response returns any error
      if (loginResponse.nonFieldErrors != null) {
        for (var element in loginResponse.nonFieldErrors!) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: DefaultText(size: 15, text: element.toString())));
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        color: Constants.backgroundColor,
        child: Center(
            child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Form(
              key: _form,
              child: Column(
                children: [
                  TextFormField(
                    style: const TextStyle(fontSize: 22.0),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Username is required";
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _username = value!;
                    },
                    decoration: InputDecoration(
                      border: const UnderlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          borderSide: BorderSide(color: Colors.white)),
                      enabledBorder: const UnderlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          borderSide: BorderSide(color: Colors.white)),
                      focusedBorder: const UnderlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          borderSide: BorderSide(color: Colors.white)),
                      fillColor: Colors.white,
                      filled: true,
                      prefixIcon: const Icon(Icons.person),
                      prefixIconColor: Constants.primaryColor,
                      hintText: "Username/",
                    ),
                  ),
                  const SizedBox(height: 25.0),
                  TextFormField(
                    obscureText: !_obscureText,
                    decoration: InputDecoration(
                      border: const UnderlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          borderSide: BorderSide(color: Colors.white)),
                      enabledBorder: const UnderlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          borderSide: BorderSide(color: Colors.white)),
                      focusedBorder: const UnderlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          borderSide: BorderSide(color: Colors.white)),
                      fillColor: Colors.white,
                      filled: true,
                      prefixIcon: const Icon(Icons.lock),
                      prefixIconColor: Constants.primaryColor,
                      suffixIcon: GestureDetector(
                          onTap: () {
                            _toggle();
                          },
                          child: Icon(_obscureText
                              ? Icons.visibility
                              : Icons.visibility_off)),
                      hintText: "Password",
                    ),
                    style: const TextStyle(
                      fontSize: 22.0,
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Password is required";
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _password = value!;
                    },
                  ),
                  const SizedBox(height: 15.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () {},
                        child: const DefaultText(
                          text: 'Forgot Password?',
                          size: 15,
                          color: Colors.black,
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    width: size.width,
                    child: DefaultButton(
                      onPressed: _login,
                      text: 'LOGIN',
                      textSize: 20.0,
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Column(
                      // mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const DefaultText(
                            text: "Trouble Logging in? ", size: 15.0),
                        InkWell(
                          onTap: () {},
                          child: const DefaultText(
                            text: 'Contact the School Management',
                            size: 15.0,
                            color: Colors.amber,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        )),
      ),
    );
  }
}
