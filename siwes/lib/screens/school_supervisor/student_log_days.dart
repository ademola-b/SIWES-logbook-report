import 'package:flutter/material.dart';
import 'package:siwes/screens/school_supervisor/navbar.dart';
import 'package:siwes/utils/constants.dart';
import 'package:siwes/utils/defaultButton.dart';
import 'package:siwes/utils/defaultContainer.dart';
import 'package:siwes/utils/defaultText.dart';
import 'package:siwes/utils/defaultTextFormField.dart';

class SuperStudentLogDays extends StatefulWidget {
  const SuperStudentLogDays({super.key});

  @override
  State<SuperStudentLogDays> createState() => _SuperStudentLogDaysState();
}

class _SuperStudentLogDaysState extends State<SuperStudentLogDays> {
  @override
  Widget build(BuildContext context) {
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
              const DefaultText(
                  size: 18.0, text: "Logbook Report for Student's Name"),
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
                  enabled: false,
                  maxLines: 5,
                  hintText: "Industry Based Supervisor Comment",
                  fontSize: 15.0),
              const SizedBox(height: 20.0),
              const DefaultTextFormField(
                  enabled: true,
                  maxLines: 5,
                  hintText: "School Based Supervisor Comment",
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
