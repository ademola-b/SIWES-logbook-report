import 'package:flutter/material.dart';
import 'package:siwes/models/ind_std_list.dart';
import 'package:siwes/models/user_response.dart';
import 'package:siwes/screens/industry_supervisor/navbar.dart';
import 'package:siwes/screens/students/dashboard.dart';
import 'package:siwes/services/remote_services.dart';
import 'package:siwes/utils/constants.dart';
import 'package:siwes/utils/defaultText.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  String _username = "Loading...";
  List<IndStdList>? indStd = [];

  Future<UserResponse?> _getUser() async {
    UserResponse? user = await RemoteServices.getUser();
    if (user != null) {
      setState(() {
        _username = user.username;
      });
    }
    return null;
  }

  Future<List<IndStdList>?> _getIndStdList() async {
    List<IndStdList>? stdL = await RemoteServices.getIndStdList();
    if (stdL != null) {
      setState(() {
        indStd = [...indStd!, ...stdL];
        // print(IndStd);
      });
    }
  }

  DateTime dt = DateTime.now();

  @override
  void initState() {
    _getIndStdList();
    _getUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constants.backgroundColor,
      drawer: Navbar(),
      appBar: AppBar(
        title: const Text("Dashboard"),
        centerTitle: true,
        backgroundColor: Constants.primaryColor,
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
                      text: "Hello, \n $_username",
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
              Wrap(
                spacing: 20.0,
                runSpacing: 20.0,
                children: List.generate(indStd!.length, (index) {
                  return indStd == null
                      ? const DefaultText(
                          size: 15,
                          text: "No student is under your supervision")
                      : Container(
                          width: MediaQuery.of(context).size.width / 2.4,
                          decoration: const BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20.0)),
                            color: Colors.white,
                          ),
                          child: ListTile(
                            onTap: () {
                              Navigator.pushNamed(context, '/studentLog',
                                  arguments: {
                                    'username': indStd![index].user.username
                                  });
                            },
                            title: DefaultText(
                              size: 15,
                              text:
                                  "${indStd![index].user.firstName} ${indStd![index].user.lastName}",
                              color: Colors.green,
                              weight: FontWeight.w500,
                            ),
                            subtitle: DefaultText(
                              size: 13,
                              text: indStd![index].user.username,
                              color: Colors.green,
                              weight: FontWeight.w500,
                            ),
                          ),
                        );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
