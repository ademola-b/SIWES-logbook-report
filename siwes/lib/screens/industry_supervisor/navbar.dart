import 'package:flutter/material.dart';
import 'package:siwes/models/user_response.dart';
import 'package:siwes/services/remote_services.dart';
import 'package:siwes/utils/constants.dart';
import 'package:siwes/utils/defaultText.dart';

class Navbar extends StatefulWidget {
  Navbar({super.key});

  @override
  State<Navbar> createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
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

  RemoteServices _remote = RemoteServices();

  String? _username, _email;

  Future<UserResponse?> _getUser() async {
    UserResponse? user = await _remote.getUser();
    if (user != null) {
      setState(() {
        _username = user.username;
        _email = user.email;
      });
    }
    return null;
  }

  @override
  void initState() {
    _getUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName: DefaultText(size: 15.0, text: _username ?? 'username'),
            accountEmail:
                DefaultText(size: 15.0, text: _email ?? 'emailAddress'),
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
