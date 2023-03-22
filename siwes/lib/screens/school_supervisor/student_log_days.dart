import 'package:flutter/material.dart';
import 'package:siwes/models/week_comment_response.dart';
import 'package:siwes/screens/school_supervisor/comment.dart';
import 'package:siwes/screens/school_supervisor/navbar.dart';
import 'package:siwes/services/remote_services.dart';
import 'package:siwes/utils/constants.dart';
import 'package:siwes/utils/defaultButton.dart';
import 'package:siwes/utils/defaultContainer.dart';
import 'package:siwes/utils/defaultText.dart';
import 'package:siwes/utils/defaultTextFormField.dart';

class SuperStudentLogDays extends StatefulWidget {
  final nxtdata;
  const SuperStudentLogDays({super.key, this.nxtdata});

  @override
  State<SuperStudentLogDays> createState() => _SuperStudentLogDaysState();
}

class _SuperStudentLogDaysState extends State<SuperStudentLogDays> {
  TextEditingController? indComment = TextEditingController();
  TextEditingController? schComment = TextEditingController();

  void _updateComment(int id, studentId, weekId, indComment, schComment) async {
    WeekCommentResponse? cmResponse = await RemoteServices.updateComment(
        context: context,
        id: id,
        studentId: studentId,
        weekId: weekId,
        indComment: indComment,
        schComment: schComment);
    if (cmResponse != null) {
      await showDialog(
          context: context,
          builder: (context) => AlertDialog(
                content: SizedBox(
                  height: 120.0,
                  child: Column(
                    children: [
                      Icon(
                        Icons.check_circle_outline,
                        size: 70.0,
                        color: Constants.backgroundColor,
                      ),
                      const SizedBox(height: 20.0),
                      const DefaultText(
                        size: 20.0,
                        text: "Comment Saved",
                        color: Colors.green,
                      ),
                    ],
                  ),
                ),
              ));
      Navigator.pop(context);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("Widget data: ${widget.nxtdata}");
    indComment!.text = widget.nxtdata['indNComment'];
    schComment!.text = widget.nxtdata['schNComment'];
  }

  @override
  Widget build(BuildContext context) {
    List<dynamic> days = Constants.getDaysInWeek(
        widget.nxtdata['week_start'], widget.nxtdata['week_end']);
    return Scaffold(
      backgroundColor: Constants.backgroundColor,
      drawer: Navbar(),
      appBar: AppBar(
        title: const Text("Student Log Days"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              DefaultText(
                size: 20.0,
                text:
                    "Logbook Report for ${widget.nxtdata['std_fname']} ${widget.nxtdata['std_lname']}",
                color: Constants.primaryColor,
              ),
              const SizedBox(height: 20.0),
              Wrap(
                spacing: 20.0, // gap between adjacent chips
                runSpacing: 30.0, // gap between lines
                children: List.generate(
                  days.length,
                  (index) => Container(
                    width: MediaQuery.of(context).size.width / 2.4,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(20.0)),
                      color: Colors.white,
                    ),
                    child: ListTile(
                      onTap: () {
                        Navigator.pushNamed(context, '/entryDate', arguments: {
                          'fname': widget.nxtdata['std_fname'],
                          'lname': widget.nxtdata['std_lname'],
                          'username': widget.nxtdata['std_username'],
                          'date': days[index],
                          'student_id': widget.nxtdata['student_id']
                          // "${days[index].day}/${days[index].month}/${days[index].year}"
                        });
                      },
                      title: DefaultText(
                        size: 15,
                        text: "Day ${index + 1}",
                        color: Colors.green,
                        weight: FontWeight.w500,
                      ),
                      subtitle: DefaultText(
                        size: 15,
                        text: days[index],
                        // "${days[index].day}/${days[index].month}/${days[index].year}"
                        // .toString(),
                        color: Colors.green,
                        weight: FontWeight.w500,
                      ),
                      // trailing: const Icon(Icons.arrow_forward_ios),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20.0),
              DefaultTextFormField(
                text: indComment,
                enabled: false,
                maxLines: 5,
                label: "Industry Based Supervisor Comment",
                hintText: "Industry Based Supervisor Comment",
                fontSize: 20.0,
                fillColor: Colors.white,
              ),
              const SizedBox(height: 20.0),
              DefaultTextFormField(
                text: schComment,
                enabled: true,
                maxLines: 5,
                label: "School Based Supervisor Comment",
                hintText: "School Based Supervisor Comment",
                fontSize: 20.0,
                fillColor: Colors.white,
              ),
              const SizedBox(height: 20.0),
              SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: DefaultButton(
                      onPressed: () {
                        _updateComment(
                            widget.nxtdata['week_comment_id'],
                            widget.nxtdata['student_id'],
                            widget.nxtdata['week_index'],
                            indComment!.text,
                            schComment!.text);
                      },
                      text: "SUBMIT",
                      textSize: 20.0))
            ],
          ),
        ),
      ),
    );
  }
}
