import 'package:flutter/material.dart';
import 'package:siwes/models/student_details.dart';
import 'package:siwes/models/user_response.dart';
import 'package:siwes/models/week_dates_response.dart';
import 'package:siwes/services/remote_services.dart';
import 'package:siwes/utils/constants.dart';
import 'package:siwes/utils/defaultContainer.dart';
import 'package:siwes/utils/defaultText.dart';
import 'package:siwes/screens/students/navbar.dart';
import 'package:siwes/utils/string_extension.dart';

class StudentDashboard extends StatefulWidget {
  const StudentDashboard({super.key});

  @override
  State<StudentDashboard> createState() => _StudentDashboardState();
}

class _StudentDashboardState extends State<StudentDashboard> {
  late Future<List<WeekDatesResponse>> futureWeekDate;
  String _username = 'Loading...';
  int? _studentId;

  Future<StudentDetailResponse?> _getStdDetails() async {
    List<StudentDetailResponse>? std = await RemoteServices.getStdDetails();
    if (std.isNotEmpty) {
      setState(() {
        _username = std[0].user.username;
        _studentId = std[0].id;
        print("id: $_studentId");
      });
    }
    return null;
  }

  @override
  void initState() {
    futureWeekDate = RemoteServices.getWeekDates();
    _getStdDetails();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constants.backgroundColor,
      drawer: Navbar(),
      appBar: AppBar(
        title: const Text('DASHBOARD'),
        centerTitle: true,
        backgroundColor: Constants.primaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(20.0),
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(30.0))),
                child: Row(
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    DefaultText(
                      size: 20.0,
                      text: "Hello, \n ${_username.titleCase()}",
                      color: Constants.primaryColor,
                    ),
                    const Spacer(),
                    DefaultText(
                      size: 20.0,
                      text: "Week \n Number",
                      color: Constants.primaryColor,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 50.0),
              DefaultText(
                size: 25.0,
                text: 'Logbook Entries',
                color: Constants.primaryColor,
                weight: FontWeight.w500,
              ),
              const Divider(
                thickness: 1.5,
                color: Colors.green,
              ),
              const SizedBox(height: 20.0),
              Center(
                child: FutureBuilder<List<WeekDatesResponse>>(
                    future: futureWeekDate,
                    builder: (context, snapshot) {
                      var dates = snapshot.data;
                      if (snapshot.hasData) {
                        return SingleChildScrollView(
                          child: Column(
                            children: [
                              ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                scrollDirection: Axis.vertical,
                                shrinkWrap: true,
                                itemCount: dates == null ? 0 : dates.length,
                                itemBuilder: (context, index) {
                                  // print("Student Id: $_studentId");
                                  return DefaultContainer(
                                    title: "Week ${index + 1}",
                                    subtitle:
                                        "Week Date ${dates![index].startDate.day}/${dates[index].startDate.month}/${dates[index].startDate.year} - ${dates[index].endDate.day}/${dates[index].endDate.month}/${dates[index].endDate.year}",
                                    route: "/week",
                                    weekIndex: index,
                                    weekStart: dates[index].startDate,
                                    weekEnd: dates[index].endDate,
                                    studentId: _studentId,
                                    wkIndex: dates[index].id,
                                    div_width: 1,
                                  );
                                },
                              ),
                            ],
                          ),
                        );
                      } else if (snapshot.hasError) {
                        return Text("${snapshot.error}");
                      }

                      return const CircularProgressIndicator();
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
