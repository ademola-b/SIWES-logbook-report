import 'package:flutter/material.dart';
import 'package:siwes/models/ind_std_list.dart';
import 'package:siwes/models/week_comment_response.dart';
import 'package:siwes/screens/industry_supervisor/navbar.dart';
import 'package:siwes/services/remote_services.dart';
import 'package:siwes/utils/constants.dart';
import 'package:siwes/utils/defaultContainer.dart';
import 'package:siwes/utils/defaultText.dart';

class StudentLog extends StatefulWidget {
  const StudentLog(Object? arguments, {super.key});

  @override
  State<StudentLog> createState() => _StudentLogState();
}

class _StudentLogState extends State<StudentLog> {
  List<IndStdList>? indStd = [];
  int? wkComId;
  String? indNComment;

  Future<List<IndStdList>?> _getIndStdList() async {
    List<IndStdList>? stdL = await RemoteServices.getIndStdList();

    if (stdL != null) {
      setState(() {
        indStd = [...indStd!, ...stdL];
        for (var element in indStd!) {}
      });
    }
    return null;
  }

  Future<WeekCommentResponse?>? checkWkComment(int sid, int wkId) async {
    WeekCommentResponse? wkResponse = await RemoteServices
        .getWeekComment(context: context, studentId: sid, weekId: wkId);

    if (wkResponse != null) {
      setState(() {
        wkComId = wkResponse.id!;
        // print("Wkcom after set: $wkComId");
        indNComment = wkResponse.industryComment ?? '';
        // print("IndNComment after set: $indNComment");
      });

      // print("Week id: $wkId");
    }
  }

  @override
  void initState() {
    _getIndStdList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final routeData =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    // print(routeData);

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
              Center(
                child: Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: indStd!.isEmpty
                        ? const CircularProgressIndicator()
                        : ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            itemCount: indStd!.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () async {
                                  await checkWkComment(indStd![index].id,
                                      routeData['week_index']);
                                  
                                  Map<String, dynamic> data = {
                                    'week_comment_id': wkComId,
                                    'indNComment': indNComment,
                                    'week_index': routeData['week_index'],
                                    'week_start': routeData['week_start'],
                                    'week_end': routeData['week_end'],
                                    'student_id': indStd![index].id,
                                    'std_fname': indStd![index].user.firstName,
                                    'std_lname': indStd![index].user.lastName,
                                    'std_username':
                                        indStd![index].user.username,
                                  };
                                  Navigator.pushNamed(
                                      context, '/studentLogDays',
                                      arguments: data);
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
                                      indStd![index].picMem,
                                      width: 50,
                                      height: 50,
                                      fit: BoxFit.cover,
                                    )),
                                    title: Text(
                                        "${indStd![index].user.firstName} ${indStd![index].user.lastName}"),
                                    subtitle:
                                        Text(indStd![index].user.username),
                                    trailing:
                                        const Icon(Icons.arrow_forward_ios),
                                    // route: '/studentLogDays',
                                  ),
                                ),
                              );
                            },
                          )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
