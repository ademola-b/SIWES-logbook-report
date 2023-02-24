import 'package:flutter/material.dart';
import 'package:siwes/models/student_details.dart';
import 'package:siwes/services/remote_services.dart';
import 'package:siwes/utils/constants.dart';
import 'package:siwes/screens/students/navbar.dart';
import 'package:siwes/utils/defaultButton.dart';
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

  Future<List<StudentDetailResponse>> _getStdDetail() async {
    stdDetail = await RemoteServices().getStdDetails();
    if (stdDetail != null) {
      setState(() {
        print(stdDetail);
      });
    }
    return [];
  }

  @override
  void initState() {
    super.initState();
    // _getStdDetail();
    // futureStd = _getStdDetail();
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
                            _stdD![index].schoolBasedSupervisor.profilePicMemory,
                            width: 200,
                            height: 200,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(height: 30.0),
                        Container(
                          padding: const EdgeInsets.all(20.0),
                          width: MediaQuery.of(context).size.width,
                          decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30.0))),
                          child: Column(
                            children: [
                              DefaultText(
                                size: 20,
                                text:
                                    "${_stdD[index].schoolBasedSupervisor.user.firstName}  ${_stdD[index].schoolBasedSupervisor.user.lastName}",
                                color: Constants.primaryColor,
                                align: TextAlign.left,
                              ),
                              const SizedBox(height: 20.0),
                              DefaultText(
                                  size: 20,
                                  text: _stdD[index]
                                      .schoolBasedSupervisor
                                      .user
                                      .email,
                                  color: Constants.primaryColor),
                              const SizedBox(height: 20.0),
                              DefaultText(
                                  size: 20,
                                  text: _stdD[index]
                                      .schoolBasedSupervisor
                                      .phoneNo,
                                  color: Constants.primaryColor),
                            ],
                          ),
                        ),
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
