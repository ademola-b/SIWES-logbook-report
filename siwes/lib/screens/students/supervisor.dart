import 'package:flutter/material.dart';
import 'package:siwes/models/student_details.dart';
import 'package:siwes/services/remote_services.dart';
import 'package:siwes/utils/constants.dart';
import 'package:siwes/screens/students/navbar.dart';
import 'package:siwes/utils/defContainer.dart';
import 'package:siwes/utils/defaultButton.dart';
import 'package:siwes/utils/defaultContainer.dart';
import 'package:siwes/utils/defaultText.dart';
import 'package:siwes/utils/defaultTextFormField.dart';

class SupervisorDetails extends StatefulWidget {
  const SupervisorDetails({super.key});

  @override
  State<SupervisorDetails> createState() => _SupervisorDetailsState();
}

class _SupervisorDetailsState extends State<SupervisorDetails> {
  List<StudentDetailResponse> stdDetail = [];
  Future<List<StudentDetailResponse>?>? futureStd;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Constants.backgroundColor,
      drawer: Navbar(),
      appBar: AppBar(
        title: const Text("Supervisor Details"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 40.0, left: 20.0, right: 20.0),
        child: SingleChildScrollView(
          child: Column(
            children: const [
              DefContainer(
                title: 'School Based Supervisor',
                route: '/schoolSupervisorDetails',
              ),
              SizedBox(height: 10.0),
              DefContainer(
                title: 'Industry Based Supervisor',
                route: '/industrySupervisorDetails',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
