import 'package:flutter/material.dart';
import 'package:siwes/onboard.dart';
import 'package:siwes/screens/industry_supervisor/comment.dart';
import 'package:siwes/screens/industry_supervisor/dashboard.dart';
import 'package:siwes/screens/industry_supervisor/entry_date.dart';
import 'package:siwes/screens/industry_supervisor/placement_centre.dart';
import 'package:siwes/screens/industry_supervisor/student_log.dart';
import 'package:siwes/screens/industry_supervisor/student_log_days.dart';
import 'package:siwes/screens/industry_supervisor/view_students.dart';
import 'package:siwes/screens/login.dart';
import 'package:siwes/screens/school_supervisor/comment.dart';
import 'package:siwes/screens/school_supervisor/dashboard.dart'
    as schoolSupervisorDashboard;
import 'package:siwes/screens/school_supervisor/student_log.dart';
import 'package:siwes/screens/school_supervisor/student_log_days.dart';
import 'package:siwes/screens/students/dashboard.dart';
import 'package:siwes/screens/industry_supervisor/student_details.dart';
import 'package:siwes/screens/students/logEntry.dart';
import 'package:siwes/screens/students/placement_centre.dart';
import 'package:siwes/screens/students/reports.dart';
import 'package:siwes/screens/students/supervisor.dart';
import 'package:siwes/screens/students/week.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(primarySwatch: Colors.green),
    initialRoute: '/',
    onGenerateRoute: _getRoutes,
    routes: {
      '/': (context) => const OnBoard(),
      '/login': (context) => const Login(),
      '/studentDashboard': (context) => const StudentDashboard(),
      // '/logEntry': (context) => const LogEntry(),
      // '/week': (context) => const WeekPage(),
      '/supervisor': (context) => const SupervisorDetails(),
      '/placementCentre': (context) => const PlacementCentre(),
      '/reports': (context) => const Reports(),
      '/industryDashboard': (context) => const Dashboard(),
      '/students': (context) => const IndStudent(),
      '/indComment': (context) => const IndComment(),
      '/industryPlacementCentre': (context) => const IndPlacementCentre(),
      '/studentDetails': (context) => const StudentDetails(),
      // '/studentLog': (context) => const StudentLog(),
      // '/studentLogDays': (context) => const StudentLogDays(),
      '/schoolSupervisorDashboard': (context) =>
          const schoolSupervisorDashboard.Dashboard(),
      '/schComment': (context) => const SchComment(),
      '/superStudentLog': (context) => const SuperStudentLog(),
      '/superStudentLogDays': (context) => const SuperStudentLogDays(),
      // '/entryDate':(context) => EntryDate(arguments)
    },
  ));
}

Route<dynamic> _getRoutes(RouteSettings settings) {
  final args = settings.arguments;
  switch (settings.name) {
    case "/week":
      return _buildRoute(settings, WeekPage(settings.arguments));

    case "/logEntry":
      return _buildRoute(settings, LogEntry(settings.arguments));

    case "/studentLog":
      return _buildRoute(settings, StudentLog(settings.arguments));

    case "/studentLogDays":
      return _buildRoute(settings, StudentLogDays(data: args));

    case "/entryDate":
      return _buildRoute(settings, EntryDate(settings.arguments));

    default:
      return _buildRoute(settings, OnBoard());
  }
}

MaterialPageRoute _buildRoute(RouteSettings settings, Widget builder) {
  return MaterialPageRoute(settings: settings, builder: ((context) => builder));
}
