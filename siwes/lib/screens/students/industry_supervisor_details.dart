import 'package:flutter/material.dart';
import 'package:siwes/models/student_details.dart';
import 'package:siwes/services/remote_services.dart';
import 'package:siwes/utils/constants.dart';
import 'package:siwes/screens/students/navbar.dart';
import 'package:siwes/utils/defaultText.dart';
import 'package:siwes/utils/defaultTextFormField.dart';

class IndustrySupervisorDetails extends StatefulWidget {
  const IndustrySupervisorDetails({super.key});

  @override
  State<IndustrySupervisorDetails> createState() =>
      _IndustrySupervisorDetailsState();
}

class _IndustrySupervisorDetailsState extends State<IndustrySupervisorDetails> {
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
        title: const Text("Industry Supervisor Details"),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 40.0, left: 20.0, right: 20.0),
          child: SingleChildScrollView(
            child: FutureBuilder(
              future: RemoteServices().getStdDetails(),
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
                                  .industryBasedSupervisor
                                  .profileNoMemory,
                              width: 170,
                              height: 170,
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(height: 30.0),
                          DefaultTextFormField(
                            fontSize: 18.0,
                            label: 'Name',
                            enabled: false,
                            text: TextEditingController(
                                text:
                                    "${_stdD[index].industryBasedSupervisor.user.firstName}  ${_stdD[index].industryBasedSupervisor.user.lastName}"),
                            validator: Constants.validator,
                          ),
                          const SizedBox(height: 20.0),
                          DefaultTextFormField(
                            fontSize: 18.0,
                            label: 'Email Address',
                            enabled: false,
                            text: TextEditingController(
                              text: _stdD[index]
                                  .industryBasedSupervisor
                                  .user
                                  .email,
                            ),
                          ),
                          const SizedBox(height: 20.0),
                          DefaultTextFormField(
                            label: "Phone Number",
                            fontSize: 15.0,
                            enabled: false,
                            text: TextEditingController(
                              text:
                                  _stdD[index].industryBasedSupervisor.phoneNo,
                            ),
                          ),
                          const SizedBox(height: 20.0),
                          DefaultTextFormField(
                            label: "Placement Centre",
                            fontSize: 15.0,
                            enabled: false,
                            text: TextEditingController(
                                text: _stdD[index]
                                    .industryBasedSupervisor
                                    .placementCenter
                                    .name),
                          ),
                        ],
                      );
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
                      //             "${_stdD[index].industryBasedSupervisor.user.firstName}  ${_stdD[index].industryBasedSupervisor.user.lastName}",
                      //         color: Constants.primaryColor,
                      //         align: TextAlign.left,
                      //       ),
                      //       const SizedBox(height: 20.0),
                      //       DefaultText(
                      //           size: 20,
                      //           text: _stdD[index]
                      //               .industryBasedSupervisor
                      //               .user
                      //               .email,
                      //           color: Constants.primaryColor),
                      //       const SizedBox(height: 20.0),
                      //       DefaultText(
                      //           size: 20,
                      //           text: _stdD[index]
                      //               .industryBasedSupervisor
                      //               .phoneNo,
                      //           color: Constants.primaryColor),
                      //       const SizedBox(height: 20.0),
                      //       DefaultText(
                      //           size: 20,
                      //           text: _stdD[index]
                      //               .industryBasedSupervisor
                      //               .placementCenter
                      //               .name,
                      //           color: Constants.primaryColor),
                      //     ],
                      //   ),
                      // ),
                    }),
                  );
                } else {}

                return const CircularProgressIndicator();
              },
            ),
          ),
        ),
      ),
    );
  }
}
