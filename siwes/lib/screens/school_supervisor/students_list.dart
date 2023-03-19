import 'package:flutter/material.dart';

import 'package:siwes/models/ind_std_list.dart';
import 'package:siwes/screens/school_supervisor/navbar.dart';
import 'package:siwes/services/remote_services.dart';
import 'package:siwes/utils/constants.dart';
import 'package:siwes/utils/defContainer.dart';
import 'package:siwes/utils/defaultButton.dart';
import 'package:siwes/utils/defaultText.dart';

class StudentsList extends StatefulWidget {
  const StudentsList({super.key});

  @override
  State<StudentsList> createState() => _StudentsListState();
}

class _StudentsListState extends State<StudentsList> {
  @override
  void initState() {
    super.initState();
  }

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
                  padding: const EdgeInsets.all(8.0),
                  child: FutureBuilder(
                      future: RemoteServices.getSchStdList(context),
                      builder: (context, snapshot) {
                        if (snapshot.hasData && snapshot.data!.isEmpty) {
                          return Container(
                            width: MediaQuery.of(context).size.width,
                            decoration: const BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20.0)),
                              color: Colors.white,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: DefaultText(
                                align: TextAlign.center,
                                size: 20.0,
                                text: "No student on your supervision",
                                color: Constants.primaryColor,
                              ),
                            ),
                          );
                        } else if (snapshot.hasData) {
                          var data = snapshot.data;
                          return Column(
                            children: [
                              ListView.builder(
                                shrinkWrap: true,
                                scrollDirection: Axis.vertical,
                                itemCount: data!.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return Container(
                                    margin: const EdgeInsets.only(bottom: 10.0),
                                    width: MediaQuery.of(context).size.width,
                                    decoration: const BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(20.0)),
                                      color: Colors.white,
                                    ),
                                    child: ListTile(
                                      onTap: () {
                                        Navigator.pushNamed(
                                            context, '/studentDetails');
                                      },
                                      leading: ClipOval(
                                          child: Image.memory(
                                        data[index]!.picMem,
                                        width: 50,
                                        height: 50,
                                        fit: BoxFit.cover,
                                      )),
                                      title: DefaultText(
                                        size: 18,
                                        text:
                                            "${data[index]!.user.firstName} ${data[index]!.user.lastName}",
                                        color: Colors.green,
                                        weight: FontWeight.w500,
                                      ),
                                      subtitle: DefaultText(
                                        size: 15,
                                        text: data[index]!.user.username,
                                        color: Colors.green,
                                        weight: FontWeight.w500,
                                      ),
                                      trailing:
                                          const Icon(Icons.arrow_forward_ios),
                                    ),
                                  );
                                },
                              ),
                              const SizedBox(height: 20.0),
                              SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  child: DefaultButton(
                                      onPressed: () {},
                                      text: "Export",
                                      textSize: 20.0)),
                            ],
                          );
                        }

                        return const CircularProgressIndicator();
                      }),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
