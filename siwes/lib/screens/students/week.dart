import 'package:flutter/material.dart';

import 'package:siwes/screens/students/navbar.dart';
import 'package:siwes/utils/constants.dart';
import 'package:siwes/utils/defaultText.dart';
import 'package:siwes/utils/defaultTextFormField.dart';

class WeekPage extends StatefulWidget {
  const WeekPage(
    Object? arguments, {
    super.key,
  });

  @override
  State<WeekPage> createState() => _WeekPageState();
}

class _WeekPageState extends State<WeekPage> {

    

  DateTime dt = DateTime.now();

  @override
  Widget build(BuildContext context) {
    final routeData =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    // print(routeData);

    List<DateTime> days =
        Constants().getDaysInWeek(routeData['week_start'], routeData['week_end']);

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
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              '/logEntry',
                              arguments: {
                                'week_index': routeData['week_index'],
                                'date': days[index]
                              },
                            );
                          },
                          title: DefaultText(
                            size: 18,
                            text: "Day $index",
                            color: Colors.green,
                            weight: FontWeight.w500,
                          ),
                          subtitle: DefaultText(
                            size: 15,
                            text:
                                "${days[index].day}/${days[index].month}/${days[index].year}"
                                    .toString(),
                            color: Colors.green,
                            weight: FontWeight.w500,
                          ),
                          trailing: const Icon(Icons.arrow_forward_ios),
                        ),
                      );
                    }),
                  )),
              const DefaultTextFormField(
                hintText: "Industry Based Supervisor Comment",
                fontSize: 15.0,
                maxLines: 5,
                enabled: false,
              ),
              const SizedBox(height: 20.0),
              const DefaultTextFormField(
                hintText: "School Based Supervisor Comment",
                fontSize: 15.0,
                maxLines: 5,
                enabled: false,
              )
            ],
          ),
        ),
      ),
    );
  }
}
