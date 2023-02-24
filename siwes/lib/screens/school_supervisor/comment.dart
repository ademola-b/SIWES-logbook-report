import 'package:flutter/material.dart';
import 'package:siwes/screens/school_supervisor/navbar.dart';
import 'package:siwes/utils/constants.dart';
import 'package:siwes/utils/defaultContainer.dart';
import 'package:siwes/utils/defaultText.dart';

class SchComment extends StatefulWidget {
  const SchComment({super.key});

  @override
  State<SchComment> createState() => _SchCommentState();
}

class _SchCommentState extends State<SchComment> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constants.backgroundColor,
      drawer: Navbar(),
      appBar: AppBar(
        title: const Text("Comment On Entries"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const DefaultText(size: 20.0, text: "Comment on Logbook"),
              const SizedBox(height: 20.0),
              Wrap(
                spacing: 20.0, // gap between adjacent chips
                runSpacing: 30.0, // gap between lines
                children: const <Widget>[
                  DefaultContainer(
                    title: 'Week Number',
                    subtitle: 'status',
                    route: '/superStudentLog',
                    div_width: 2.4,
                  ),
                  DefaultContainer(
                    title: 'Week Number',
                    subtitle: 'status',
                    route: '/superStudentLog',
                    div_width: 2.4,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
