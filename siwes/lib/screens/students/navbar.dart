import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
    // "Log Entry",
    // "View Enteries",
    "Supervisor",
    "Placement Centre",
    "Reports"
  ];

  final List<IconData> _activitiesIcons = [
    Icons.home,
    // Icons.note_add_outlined,
    // Icons.note_outlined,
    Icons.supervisor_account,
    Icons.place_outlined,
    Icons.report,
  ];

  final List<String> _onTap = [
    '/studentDashboard',
    // '/logEntry',
    // '/logEntry',
    '/supervisor',
    '/placementCentre',
    '/reports',
  ];

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName: Text("UserName"),
            accountEmail: Text("Email Address"),
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
                  onTap: () async {
                    switch (_labels[index]) {
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
