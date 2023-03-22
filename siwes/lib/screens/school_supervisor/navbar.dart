import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:siwes/models/user_response.dart';
import 'package:siwes/services/remote_services.dart';
import 'package:siwes/utils/constants.dart';
import 'package:siwes/utils/defaultText.dart';
import 'package:siwes/utils/string_extension.dart';

class Navbar extends StatefulWidget {
  Navbar({super.key});

  @override
  State<Navbar> createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
  final List<String> _activities = [
    "Dashboard",
    "Students",
    "Comment on Logbook",
  ];

  final List<IconData> _activitiesIcons = [
    Icons.home,
    Icons.supervisor_account,
    Icons.comment,
  ];

  final List<String> _onTap = [
    '/schoolSupervisorDashboard',
    '/schStudentList',
    '/schComment',
  ];

  final List<String> _labels = [
    "Account Information",
    "Settings",
    "Exit",
  ];

  final List<IconData> _labelIcons = [
    Icons.person,
    Icons.settings,
    Icons.logout,
  ];

  List profileDetails = [];

  String? _username, _email, _pic;

  getProfile() async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    // pref.getString("supervisor_username");
    // pref.getString("supervisor_email");
    // pref.getString("supervisor_pic");
    setState(() {
      _username = pref.getString("supervisor_username");
      _email = pref.getString("supervisor_email");
      _pic = pref.getString("supervisor_pic");
    });
  }

  @override
  void initState() {
    super.initState();
    // getProfile();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName: Text("username"),
            accountEmail: Text("email address"),
            currentAccountPicture: CircleAvatar(
              child: ClipOval(
                child: Image.asset(
                  "assets/images/avatar.jpg",
                  width: 90,
                  height: 90,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          ListView.builder(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              itemCount: _activities.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Icon(
                    _activitiesIcons[index],
                    color: Constants.primaryColor,
                  ),
                  title: Text(_activities[index]),
                  onTap: () {
                    Navigator.popAndPushNamed(context, _onTap[index]);
                  },
                );
              }),
          const Divider(
            color: Colors.green,
            thickness: 1.5,
          ),
          ListView.builder(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              itemCount: _labels.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Icon(
                    _labelIcons[index],
                    color: Constants.primaryColor,
                  ),
                  title: Text(_labels[index]),
                  onTap: () {
                    switch (_labels[index]) {
                      case 'Exit':
                        Constants.clearDetails();
                        Navigator.pushNamedAndRemoveUntil(
                            context, '/login', ((route) => false));
                        break;
                      default:
                    }
                  },
                );
              }),
        ],
      ),
    );
  }
}
