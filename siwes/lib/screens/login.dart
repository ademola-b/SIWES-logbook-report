// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:siwes/models/login_response.dart';
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

        UserResponse? user = await RemoteServices().getUser();

        //navigator to page according to user type
        if (user != null) {
          if (user.userType == 'student') {
            Navigator.popAndPushNamed(context, '/studentDashboard');
          } else if (user.userType == 'industry_based_supervisor') {
            Navigator.popAndPushNamed(context, '/industryDashboard');
          } else if (user.userType == 'school_based_supervisor') {
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
          print("Null returned");
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
                      hintText: "Username/Email",
                    ),
                  ),
                  const SizedBox(height: 25.0),
                  TextFormField(
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
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Trouble Logging in ?"),
                        InkWell(
                          onTap: () {},
                          child: const Text(
                            'Contact the School Management',
                            style: TextStyle(
                              color: Colors.amber,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.bold,
                            ),
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
