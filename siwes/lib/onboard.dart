// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:siwes/models/user_response.dart';
import 'package:siwes/services/remote_services.dart';
import 'package:siwes/utils/constants.dart';

class OnBoard extends StatefulWidget {
  const OnBoard({super.key});

  @override
  State<OnBoard> createState() => _OnBoardState();
}

class _OnBoardState extends State<OnBoard> {
  UserResponse? user;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getUser();
    checkLogin();
  }

  Future<UserResponse?> _getUser() async {
    user = await RemoteServices.getUser(context);
    if (user != null) {
      return user;
    }
    return null;
  }

  void checkLogin() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? val = pref.getString('token');

    if (val != null) {
      await _getUser();
      user!.userType == 'student'
          ? Navigator.pushNamedAndRemoveUntil(
              context, '/studentDashboard', (route) => false)
          : user!.userType == 'industry_based_supervisor'
              ? Navigator.pushNamedAndRemoveUntil(
                  context, '/industryDashboard', (route) => false)
              : Navigator.pushNamedAndRemoveUntil(
                  context, '/schoolSupervisorDashboard', (route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/images/notepad.png",
                  width: 180,
                  height: 180,
                ),
                const SizedBox(height: 30),
                SizedBox(
                  width: MediaQuery.of(context).size.width / 1.5,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      padding: MaterialStateProperty.all(
                        const EdgeInsets.symmetric(
                            vertical: 15.0, horizontal: 15.0),
                      ),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0))),
                      backgroundColor:
                          MaterialStateProperty.all(Constants.primaryColor),
                    ),
                    onPressed: () {
                      Navigator.popAndPushNamed(context, '/login');
                    },
                    child: const Text(
                      'GET STARTED',
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Poppins',
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
