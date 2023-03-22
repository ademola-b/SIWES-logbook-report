import 'package:flutter/material.dart';
import 'package:siwes/models/student_details.dart';
import 'package:siwes/services/remote_services.dart';
import 'package:siwes/utils/constants.dart';
import 'package:siwes/screens/students/navbar.dart';
import 'package:siwes/utils/defaultText.dart';
import 'package:siwes/utils/defaultTextFormField.dart';

class SchoolSupervisorDetails extends StatefulWidget {
  const SchoolSupervisorDetails({super.key});

  @override
  State<SchoolSupervisorDetails> createState() =>
      _SchoolSupervisorDetailsState();
}

class _SchoolSupervisorDetailsState extends State<SchoolSupervisorDetails> {
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
        title: const Text("School Supervisor Details"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 40.0, left: 20.0, right: 20.0),
        child: SingleChildScrollView(
          child: FutureBuilder(
            future: RemoteServices.getStdDetails(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                var _stdD = snapshot.data;

                return ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: _stdD == null ? 0 : _stdD.length,
                  itemBuilder: ((context, index) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        ClipOval(
                          child: Image.memory(
                            _stdD![index]
                                .schoolBasedSupervisor
                                .profilePicMemory,
                            width: 170,
                            height: 170,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(height: 30.0),
                        Column(
                          children: [
                            DefaultTextFormField(
                              fontSize: 18.0,
                              label: 'Name',
                              enabled: false,  readOnly: false,
                              text: TextEditingController(
                                  text:
                                      "${_stdD[index].schoolBasedSupervisor.user.firstName}  ${_stdD[index].schoolBasedSupervisor.user.lastName}"),
                              validator: Constants.validator,
                            ),
                            const SizedBox(height: 20.0),
                            DefaultTextFormField(
                              fontSize: 18.0,
                              label: 'Email Address',
                              enabled: false,  readOnly: false,
                              text: TextEditingController(
                                text: _stdD[index]
                                    .schoolBasedSupervisor
                                    .user
                                    .email,
                              ),
                            ),
                            const SizedBox(height: 20.0),
                            DefaultTextFormField(
                              label: "Phone Number",
                              fontSize: 15.0,
                              enabled: false,  readOnly: false,
                              text: TextEditingController(
                                text:
                                    _stdD[index].schoolBasedSupervisor.phoneNo,
                              ),
                            ),
                            const SizedBox(height: 20.0),
                            DefaultTextFormField(
                              label: "Department",
                              fontSize: 15.0,
                              enabled: false,  readOnly: false,
                              text: TextEditingController(
                                  text: _stdD[index]
                                      .schoolBasedSupervisor
                                      .departmentId),
                            ),
                          ],
                        ),
                        // Container(
                        //   padding: const EdgeInsets.all(20.0),
                        //   width: MediaQuery.of(context).size.width,
                        //   decoration: const BoxDecoration(
                        //       color: Colors.white,
                        //       borderRadius:
                        //           BorderRadius.all(Radius.circular(30.0))),
                        //   child: Column(
                        //     children: [
                        //       DefaultText(
                        //         size: 20,
                        //         text:
                        //             "${_stdD[index].schoolBasedSupervisor.user.firstName}  ${_stdD[index].schoolBasedSupervisor.user.lastName}",
                        //         color: Constants.primaryColor,
                        //         align: TextAlign.left,
                        //       ),
                        //       const SizedBox(height: 20.0),
                        //       DefaultText(
                        //           size: 20,
                        //           text: _stdD[index]
                        //               .schoolBasedSupervisor
                        //               .user
                        //               .email,
                        //           color: Constants.primaryColor),
                        //       const SizedBox(height: 20.0),
                        //       DefaultText(
                        //           size: 20,
                        //           text: _stdD[index]
                        //               .schoolBasedSupervisor
                        //               .phoneNo,
                        //           color: Constants.primaryColor),
                        //     ],
                        //   ),
                        // ),
                      ],
                    );
                  }),
                );
              } else {}

              return const CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }
}
