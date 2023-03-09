import 'package:flutter/material.dart';
import 'package:siwes/models/entry_date_response.dart';
import 'package:siwes/screens/industry_supervisor/navbar.dart';
import 'package:siwes/services/remote_services.dart';
import 'package:siwes/utils/constants.dart';
import 'package:siwes/utils/defaultButton.dart';
import 'package:siwes/utils/defaultContainer.dart';
import 'package:siwes/utils/defaultText.dart';
import 'package:siwes/utils/defaultTextFormField.dart';

class StudentLogDays extends StatefulWidget {
  const StudentLogDays(Object? arguments, {super.key});

  @override
  State<StudentLogDays> createState() => _StudentLogDaysState();
}

class _StudentLogDaysState extends State<StudentLogDays> {
  List<EntryDateResponse>? entryD, entD = [];
  late String _date;
  
  // Future<List<EntryDateResponse>?> _getEntryDate(String date) async {
  //   entryD = await RemoteServices().getEntryDate(date, context);
  //   if (entryD != null) {
  //     setState(() {
  //       entD = [...entD!, ...entryD!];
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    final routeData =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    List<dynamic> days = Constants()
        .getDaysInWeek(routeData['week_start'], routeData['week_end']);

    print(routeData);
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
                  size: 18.0,
                  text:
                      "Logbook Report for ${routeData['std_fname']} ${routeData['std_lname']}"),
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
                          'fname': routeData['std_fname'],
                          'lname': routeData['std_lname'],
                          'username': routeData['std_username'],
                          'date': days[index]
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
              const DefaultTextFormField(
                  maxLines: 5,
                  hintText: "Industry Based Supervisor Comment",
                  fontSize: 15.0),
              const SizedBox(height: 20.0),
              SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: DefaultButton(
                      onPressed: () {}, text: "SUBMIT", textSize: 20.0))
            ],
          ),
        ),
      ),
    );
  }
}
