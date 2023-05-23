import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:siwes/models/user_response.dart';
import 'package:siwes/screens/school_supervisor/navbar.dart';
import 'package:siwes/utils/string_extension.dart';
import 'package:siwes/services/remote_services.dart';
import 'package:siwes/utils/constants.dart';
import 'package:siwes/utils/defaultText.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  String _username = 'Loading...';
  DateTime dt = DateTime.now();

  Future<UserResponse?> _getUser() async {
    UserResponse? user = await RemoteServices.getUser(context);
    if (user != null) {
      setState(() {
        _username = user.username;
      });
    }
    return null;
  }

  @override
  void initState() {
    _getUser();
    super.initState();
  }

  String? _user, _email, _pic;
  getProfile() async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    // pref.getString("supervisor_username");
    // pref.getString("supervisor_email");
    // pref.getString("supervisor_pic");
    setState(() {
      _user = pref.getString("supervisor_username");
      _email = pref.getString("supervisor_email");
      _pic = pref.getString("supervisor_pic");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Navbar(),
      backgroundColor: Constants.backgroundColor,
      appBar: AppBar(
        title: const DefaultText(size: 18.0, text: "Dashboard"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 40.0, left: 20.0, right: 20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(20.0),
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(30.0))),
                child: Row(
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    DefaultText(
                      size: 20.0,
                      text: "Hello, \n ${_username.titleCase()}",
                      color: Constants.primaryColor,
                      align: TextAlign.center,
                    ),
                    const Spacer(),
                    DefaultText(
                      align: TextAlign.center,
                      size: 20.0,
                      text: "Today's Date \n ${dt.day}/${dt.month}/${dt.year}",
                      color: Constants.primaryColor,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 50.0),
              DefaultText(
                size: 25.0,
                text: 'Latest Entries',
                color: Constants.primaryColor,
                weight: FontWeight.w500,
              ),
              const Divider(
                thickness: 1.5,
                color: Colors.green,
              ),
              
            ],
          ),
        ),
      ),
    );
  }
}
