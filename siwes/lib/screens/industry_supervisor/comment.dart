import 'package:flutter/material.dart';
import 'package:siwes/models/week_dates_response.dart';
import 'package:siwes/screens/industry_supervisor/navbar.dart';
import 'package:siwes/services/remote_services.dart';
import 'package:siwes/utils/constants.dart';
import 'package:siwes/utils/defaultContainer.dart';
import 'package:siwes/utils/defaultText.dart';

class IndComment extends StatefulWidget {
  const IndComment({super.key});

  @override
  State<IndComment> createState() => _IndCommentState();
}

class _IndCommentState extends State<IndComment> {
  List<WeekDatesResponse> wkDates = [];

  Future<List<WeekDatesResponse>> _getWeekDates() async {
    List<WeekDatesResponse> wkd = await RemoteServices().getWeekDates();
    if (wkd != null) {
      setState(() {
        wkDates = [...wkDates, ...wkd];
        print(wkDates);
      });
    }
    return <WeekDatesResponse>[];
  }

  @override
  void initState() {
    _getWeekDates();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constants.backgroundColor,
      drawer: Navbar(),
      appBar: AppBar(
        title: const Text("Comment On Entries"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const DefaultText(size: 20.0, text: "Comment on Logbook"),
              const SizedBox(height: 20.0),
              Padding(
                  padding: const EdgeInsets.only(top: 10.0, bottom: 20.0),
                  child: Wrap(
                    spacing: 20.0,
                    runSpacing: 20.0,
                    children: List.generate(wkDates.length, (index) {
                      return Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(20.0)),
                          color: Colors.white,
                        ),
                        child: ListTile(
                          onTap: () {
                            Navigator.pushNamed(context, '/studentLog',
                                arguments: {
                                  'week_index': wkDates[index].id,
                                  'week_start': wkDates[index].startDate,
                                  'week_end': wkDates[index].endDate
                                });
                          },
                          title: DefaultText(
                            size: 18,
                            text: "Week $index",
                            color: Colors.green,
                            weight: FontWeight.w500,
                          ),
                          subtitle: DefaultText(
                            size: 15,
                            text:
                                "${wkDates[index].startDate.day}/${wkDates[index].startDate.month}/${wkDates[index].startDate.year} - ${wkDates[index].endDate.day}/${wkDates[index].endDate.month}/${wkDates[index].endDate.year}"
                                    .toString(),
                            color: Colors.green,
                            weight: FontWeight.w500,
                          ),
                          trailing: const Icon(Icons.arrow_forward_ios),
                        ),
                      );
                    }),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
