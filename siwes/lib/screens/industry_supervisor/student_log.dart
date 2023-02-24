import 'package:flutter/material.dart';
import 'package:siwes/screens/industry_supervisor/navbar.dart';
import 'package:siwes/utils/constants.dart';
import 'package:siwes/utils/defaultContainer.dart';
import 'package:siwes/utils/defaultText.dart';

class StudentLog extends StatefulWidget {
  const StudentLog(Object? arguments, {super.key});

  @override
  State<StudentLog> createState() => _StudentLogState();
}

class _StudentLogState extends State<StudentLog> {
  

  @override
  Widget build(BuildContext context) {
    final routeData =
      ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

      
    return Scaffold(
      backgroundColor: Constants.backgroundColor,
      drawer: Navbar(),
      appBar: AppBar(
        title: const Text("Students Log"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const DefaultText(size: 20.0, text: "Students"),
              const SizedBox(
                height: 20.0,
              ),
              Center(
                child: Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: DefaultContainer(
                      leading: ClipOval(
                          child: Image.asset(
                        'assets/images/avatar.jpg',
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                      )),
                      title: 'Student Name',
                      subtitle: 'reg. no',
                      route: '/studentLogDays',
                      div_width: 1,
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
