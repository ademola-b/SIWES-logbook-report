import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:siwes/models/entry_date_response.dart';
import 'package:siwes/models/logbook_entry_response.dart';
import 'package:siwes/models/week_comment_response.dart';

import 'package:siwes/screens/students/navbar.dart';
import 'package:siwes/services/remote_services.dart';
import 'package:siwes/utils/constants.dart';
import 'package:siwes/utils/defaultButton.dart';
import 'package:siwes/utils/defaultText.dart';
import 'package:siwes/utils/defaultTextFormField.dart';

class WeekPage extends StatefulWidget {
  final arguments;

  const WeekPage(
    Object? this.arguments, {
    super.key,
  });

  @override
  State<WeekPage> createState() => _WeekPageState();
}

class _WeekPageState extends State<WeekPage> {
  DateTime dt = DateTime.now();

  int? wkComId;
  String? indNComment, schNComment, _title, _description;
  Uint8List? _diagram;

  TextEditingController indComment = TextEditingController();
  TextEditingController schComment = TextEditingController();

  Future<EntryDateResponse?>? checkLogEntryDate(int sid, String date) async {
    List<EntryDateResponse?>? logEntryResponse =
        await RemoteServices().getEntryDate(sid, date, context);
    if (logEntryResponse != null && logEntryResponse.isNotEmpty) {
      setState(() {
        _title = logEntryResponse[0]!.title;
        _description = logEntryResponse[0]!.description;
        _diagram = logEntryResponse[0]!.diagram;

        // print();
      });
    }
    return null;
  }

  Future<WeekCommentResponse?>? checkWkComment(int sid, int wkId) async {
    WeekCommentResponse? wkResponse = await RemoteServices.getWeekComment(
        context: context, studentId: sid, weekId: wkId);

    if (wkResponse != null) {
      setState(() {
        wkComId = wkResponse.id!;
        indNComment = wkResponse.industryComment ?? '';
        schNComment = wkResponse.schoolComment ?? '';
      });

      print("indNComment- $indNComment");
      print("schNComment- $schNComment");
      indComment.text = indNComment!;
      schComment.text = schNComment!;
    }
  }

  @override
  void initState() {
    print("Widget data: ${widget.arguments}");
    super.initState();
    checkWkComment(widget.arguments['student_id'], widget.arguments['wkIndex']);
  }

  @override
  Widget build(BuildContext context) {
    final routeData =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    // print(routeData);

    // checkWkComment(widget.arguments['student_id'], widget.arguments['wkIndex']);
    // indComment.text = indNComment!;
    // schComment.text = schNComment!;
    // print(wkComment);

    List<dynamic> days =
        Constants.getDaysInWeek(routeData['week_start'], routeData['week_end']);

    return Scaffold(
      drawer: Navbar(),
      appBar: AppBar(
        title: const Text("WEEK"),
        centerTitle: true,
      ),
      backgroundColor: Constants.backgroundColor,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SingleChildScrollView(
                child: Container(
                  padding: const EdgeInsets.all(20.0),
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(30.0))),
                  child: Row(
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      DefaultText(
                        align: TextAlign.center,
                        size: 20.0,
                        text: "Week \n ${routeData['week_index']}",
                        color: Constants.primaryColor,
                      ),
                      const Spacer(),
                      DefaultText(
                        align: TextAlign.center,
                        size: 20.0,
                        text:
                            "Today's Date \n ${dt.day}/${dt.month}/${dt.year}",
                        color: Constants.primaryColor,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 30.0),
              DefaultText(
                size: 25.0,
                text: 'Days in Week ${routeData['week_index']}',
                color: Constants.primaryColor,
                weight: FontWeight.w500,
              ),
              const Divider(
                thickness: 1.5,
                color: Colors.green,
              ),
              Padding(
                  padding: const EdgeInsets.only(top: 10.0, bottom: 20.0),
                  child: Wrap(
                    spacing: 20.0,
                    runSpacing: 20.0,
                    children: List.generate(days.length, (index) {
                      return Container(
                        width: MediaQuery.of(context).size.width / 2.4,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(20.0)),
                          color: Colors.white,
                        ),
                        child: ListTile(
                          onTap: () async {
                            await checkLogEntryDate(
                                widget.arguments['student_id'], days[index]);

                            Navigator.pushNamed(
                              context,
                              '/logEntry',
                              arguments: {
                                'week_index': routeData['week_index'],
                                'date': days[index],
                                'title': _title ?? '',
                                'desc': _description ?? '',
                                'diagram': _diagram ?? []
                              },
                            );
                          },
                          title: DefaultText(
                            size: 18,
                            text: "Day ${index + 1}",
                            color: Colors.green,
                            weight: FontWeight.w500,
                          ),
                          subtitle: DefaultText(
                            size: 15,
                            text: days[index],
                            // "${days[index].day}/${days[index].month}/${days[index].year}"
                            //     .toString(),
                            color: Colors.green,
                            weight: FontWeight.w500,
                          ),
                          trailing: const Icon(Icons.arrow_forward_ios),
                        ),
                      );
                    }),
                  )),
              DefaultTextFormField(
                text: indComment,
                label: "Industry Based Supervisor Comment",
                hintText: "Industry Based Supervisor Comment",
                fontSize: 20.0,
                maxLines: 5,
                enabled: false,
                fillColor: Colors.white,
                readOnly: false,
              ),
              const SizedBox(height: 20.0),
              DefaultTextFormField(
                text: schComment,
                label: "School Based Supervisor Comment",
                hintText: "School Based Supervisor Comment",
                fontSize: 20.0,
                maxLines: 5,
                enabled: false,
                readOnly: false,
                fillColor: Colors.white,
              )
            ],
          ),
        ),
      ),
    );
  }
}
