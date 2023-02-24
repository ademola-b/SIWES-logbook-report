import 'package:flutter/material.dart';
import 'package:siwes/screens/industry_supervisor/navbar.dart';
import 'package:siwes/utils/constants.dart';

class StudentDetails extends StatefulWidget {
  const StudentDetails({super.key});

  @override
  State<StudentDetails> createState() => _StudentDetailsState();
}

class _StudentDetailsState extends State<StudentDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constants.backgroundColor,
      drawer: Navbar(),
      appBar: AppBar(
        title: const Text("Student Details"),
        centerTitle: true,
      ),
    );
  }
}
