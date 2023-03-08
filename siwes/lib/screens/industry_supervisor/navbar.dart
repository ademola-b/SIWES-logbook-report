import 'package:flutter/material.dart';
import 'package:siwes/utils/constants.dart';

class Navbar extends StatelessWidget {
  Navbar({super.key});

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

  final List<String> _activities = [
    "Dashboard",
    "Students",
    "Comment on Logbook",
    "Placement Centre",
  ];

  final List<IconData> _activitiesIcons = [
    Icons.home,
    Icons.supervisor_account,
    Icons.comment,
    Icons.place_outlined,
  ];

  final List<String> _onTap = [
    '/industryDashboard',
    '/students',
    '/indComment',
    '/industryPlacementCentre',
  ];

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName: const Text("UserName"),
            accountEmail: const Text("Email Address"),
            currentAccountPicture: CircleAvatar(
              child: ClipOval(
                child: Image.asset(
                  'assets/images/avatar.jpg',
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
                    Navigator.pushReplacementNamed(context, _onTap[index]);
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
                        Navigator.popAndPushNamed(context, '/login');
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
