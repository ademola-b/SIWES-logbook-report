import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:siwes/screens/industry_supervisor/navbar.dart';
import 'package:siwes/utils/constants.dart';
import 'package:siwes/utils/defaultText.dart';

class IndStudent extends StatefulWidget {
  const IndStudent({super.key});

  @override
  State<IndStudent> createState() => _IndStudentState();
}

class _IndStudentState extends State<IndStudent> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constants.backgroundColor,
      drawer: Navbar(),
      appBar: AppBar(
        title: const Text("Students"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 40.0, left: 20.0, right: 20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const DefaultText(size: 20.0, text: "List of Students"),
              const SizedBox(
                height: 20.0,
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(20.0)),
                      color: Colors.white,
                    ),
                    child: ListTile(
                      onTap: () {
                        Navigator.pushNamed(context, '/studentDetails');
                      },
                      leading: ClipOval(
                          child: Image.asset(
                        "assets/images/avatar.jpg",
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                      )),
                      title: const DefaultText(
                        size: 18,
                        text: "Student's Name",
                        color: Colors.green,
                        weight: FontWeight.w500,
                      ),
                      subtitle: const DefaultText(
                        size: 15,
                        text: "reg. no",
                        color: Colors.green,
                        weight: FontWeight.w500,
                      ),
                      trailing: const Icon(Icons.arrow_forward_ios),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
