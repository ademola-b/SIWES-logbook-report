import 'package:flutter/material.dart';
import 'package:siwes/screens/industry_supervisor/navbar.dart';
import 'package:siwes/utils/constants.dart';
import 'package:siwes/utils/defaultButton.dart';
import 'package:siwes/utils/defaultContainer.dart';
import 'package:siwes/utils/defaultText.dart';
import 'package:siwes/utils/defaultTextFormField.dart';

class StudentLogDays extends StatefulWidget {
  const StudentLogDays(Object? arguments, {super.key});

  @override
  State<StudentLogDays> createState() => _StudentLogDaysState();
}

class _StudentLogDaysState extends State<StudentLogDays> {
  @override
  Widget build(BuildContext context) {
    final routeData =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    print(routeData);
    return Scaffold(
      backgroundColor: Constants.backgroundColor,
      drawer: Navbar(),
      appBar: AppBar(
        title: const Text("Student Log Days"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              DefaultText(
                  size: 18.0,
                  text:
                      "Logbook Report for ${routeData['std_fname']} - ${routeData['std_lname']}"),
              const SizedBox(height: 20.0),
              Wrap(
                spacing: 20.0, // gap between adjacent chips
                runSpacing: 30.0, // gap between lines
                children: const <Widget>[
                  DefaultContainer(
                      title: "Day 1",
                      subtitle: "status",
                      route: 'route',
                      div_width: 2.4),
                  DefaultContainer(
                      title: "Day 1",
                      subtitle: "status",
                      route: 'route',
                      div_width: 2.4),
                ],
              ),
              const SizedBox(height: 20.0),
              const DefaultTextFormField(
                  maxLines: 5,
                  hintText: "Industry Based Supervisor Comment",
                  fontSize: 15.0),
              const SizedBox(height: 20.0),
              SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: DefaultButton(
                      onPressed: () {}, text: "SUBMIT", textSize: 20.0))
            ],
          ),
        ),
      ),
    );
  }
}
