import 'package:flutter/material.dart';
import 'package:siwes/screens/school_supervisor/navbar.dart';
import 'package:siwes/utils/constants.dart';
import 'package:siwes/utils/defaultContainer.dart';
import 'package:siwes/utils/defaultText.dart';

class SuperStudentLog extends StatefulWidget {
  const SuperStudentLog({super.key});

  @override
  State<SuperStudentLog> createState() => _SuperStudentLogState();
}

class _SuperStudentLogState extends State<SuperStudentLog> {
  @override
  Widget build(BuildContext context) {
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
                      route: '/superStudentLogDays',
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
