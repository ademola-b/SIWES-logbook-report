import 'package:flutter/material.dart';
import 'package:siwes/models/week_comment_response.dart';
import 'package:siwes/screens/school_supervisor/navbar.dart';
import 'package:siwes/services/remote_services.dart';
import 'package:siwes/utils/constants.dart';
import 'package:siwes/utils/defaultContainer.dart';
import 'package:siwes/utils/defaultText.dart';

class SuperStudentLog extends StatefulWidget {
  final data;
  const SuperStudentLog({super.key, this.data});

  @override
  State<SuperStudentLog> createState() => _SuperStudentLogState();
}

class _SuperStudentLogState extends State<SuperStudentLog> {
  int? wkComId;
  String? indNComment;
  String? schNComment;

  Future<WeekCommentResponse?>? checkWkComment(int sid, int wkId) async {
    WeekCommentResponse? wkResponse = await RemoteServices.getWeekComment(
        context: context, studentId: sid, weekId: wkId);

    if (wkResponse != null) {
      setState(() {
        wkComId = wkResponse.id!;
        indNComment = wkResponse.industryComment ?? '';
        schNComment = wkResponse.schoolComment ?? '';
        // print("IndNComment after set: $indNComment");
      });

      // print("Week id: $wkId");
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("Widget data: ${widget.data}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constants.backgroundColor,
      drawer: Navbar(),
      appBar: AppBar(
        title: const Text("Students Log"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const DefaultText(size: 20.0, text: "Students"),
              const SizedBox(
                height: 20.0,
              ),
              FutureBuilder(
                  future: RemoteServices.getSchStdList(context),
                  builder: (context, snapshot) {
                    if (snapshot.hasData && snapshot.data!.isEmpty) {
                      return Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(20.0)),
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
                      return ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        itemCount: data!.length,
                        itemBuilder: (context, index) {
                          // print(widget.arguments['week_index']);
                          return GestureDetector(
                            onTap: () async {
                              await checkWkComment(
                                  data[index].id, widget.data['week_index']);

                              Map<String, dynamic> nxtdata = {
                                'week_comment_id': wkComId,
                                'indNComment': indNComment,
                                'schNComment': schNComment,
                                'week_index': widget.data['week_index'],
                                'week_start': widget.data['week_start'],
                                'week_end': widget.data['week_end'],
                                'student_id': data[index].id,
                                'std_fname': data[index].user.firstName,
                                'std_lname': data[index].user.lastName,
                                'std_username': data[index].user.username,
                              };
                              Navigator.pushNamed(
                                  context, '/superStudentLogDays',
                                  arguments: nxtdata);
                            },
                            child: Container(
                              margin: const EdgeInsets.only(bottom: 15.0),
                              width: MediaQuery.of(context).size.width,
                              decoration: const BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20.0)),
                                color: Colors.white,
                              ),
                              child: ListTile(
                                leading: ClipOval(
                                    child: Image.memory(
                                  data[index].picMem,
                                  width: 50,
                                  height: 50,
                                  fit: BoxFit.cover,
                                )),
                                title: DefaultText(
                                    size: 15.0,
                                    text:
                                        "${data[index].user.firstName} ${data[index].user.lastName}"),
                                subtitle: DefaultText(
                                    size: 15.0,
                                    text: data[index].user.username),
                                trailing: const Icon(Icons.arrow_forward_ios),
                                // route: '/studentLogDays',
                              ),
                            ),
                          );
                        },
                      );
                    }
                    return const CircularProgressIndicator();
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
