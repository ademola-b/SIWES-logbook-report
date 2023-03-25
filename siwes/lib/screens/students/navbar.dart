import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:siwes/utils/constants.dart';
import 'package:siwes/utils/defaultText.dart';
import 'package:siwes/utils/string_extension.dart';

class Navbar extends StatefulWidget {
  Navbar({super.key});

  @override
  State<Navbar> createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
  Future<List<String>?>? _getProfile;

  final List<String> _labels = [
    "Profile",
    "Settings",
    "Exit",
  ];

  final List<IconData> _labelIcons = [
    Icons.person,
    Icons.settings,
    Icons.logout,
  ];

  final List<String> _activities = [
    "Dashboard",
    "Supervisor",
    "Placement Centre",
    "Reports"
  ];

  final List<IconData> _activitiesIcons = [
    Icons.dashboard,
    Icons.supervisor_account,
    Icons.place_outlined,
    Icons.report,
  ];

  final List<String> _onTap = [
    '/studentDashboard',
    '/supervisor',
    '/placementCentre',
    '/reports',
  ];

  @override
  void initState() {
    super.initState();
    _getProfile = SharedPreferences.getInstance().then((pref) {
      return pref.getStringList("profile");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          FutureBuilder(
            future: _getProfile,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return UserAccountsDrawerHeader(
                  accountName: DefaultText(
                    size: 15.0,
                    text: snapshot.data![0].titleCase(),
                  ),
                  accountEmail: DefaultText(
                    size: 15.0,
                    text: snapshot.data![1],
                  ),
                  currentAccountPicture: CircleAvatar(
                    child: ClipOval(
                      child: Image.memory(
                        base64Decode(snapshot.data![2]),
                        width: 90,
                        height: 90,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                );
              }
              return UserAccountsDrawerHeader(
                accountName: const DefaultText(
                  size: 15.0,
                  text: "Username",
                ),
                accountEmail: const DefaultText(
                  size: 15.0,
                  text: "Email Address",
                ),
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
              );
            },
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
                  title: DefaultText(size: 17.0, text: _activities[index]),
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
                  title: DefaultText(size: 17.0, text: _labels[index]),
                  onTap: () async {
                    switch (_labels[index]) {
                      case 'Profile':
                        Navigator.pop(context);
                        Navigator.pushNamed(context, '/profile');
                        break;
                      case 'Exit':
                        SharedPreferences pref =
                            await SharedPreferences.getInstance();
                        await pref.clear();
                        // ignore: use_build_context_synchronously
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
