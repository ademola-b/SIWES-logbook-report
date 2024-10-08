import 'package:flutter/material.dart';
import 'package:siwes/models/student_details.dart';
import 'package:siwes/screens/industry_supervisor/student_details.dart';
import 'package:siwes/screens/industry_supervisor/view_students.dart';
import 'package:siwes/services/remote_services.dart';
import 'package:siwes/utils/constants.dart';
import 'package:siwes/screens/students/navbar.dart';
import 'package:siwes/utils/defaultButton.dart';
import 'package:siwes/utils/defaultText.dart';
import 'package:siwes/utils/defaultTextFormField.dart';

class PlacementCentre extends StatefulWidget {
  const PlacementCentre({super.key});

  @override
  State<PlacementCentre> createState() => _PlacementCentreState();
}

class _PlacementCentreState extends State<PlacementCentre> {
  List locations = ['Location 1', 'Location 2'];
  var dropdownval;
  TextEditingController placement = TextEditingController();

  // Future<StudentDetailResponse?> getDetails

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Constants.backgroundColor,
      drawer: Navbar(),
      appBar: AppBar(
        title: const Text("Placement Centre"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 40.0, left: 20.0, right: 20.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              FutureBuilder(
                  future: RemoteServices.getStdDetails(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      print(snapshot.data![0].industryBasedSupervisor
                          .placementCenter.name);

                      placement.text = snapshot.data![0].industryBasedSupervisor
                          .placementCenter.name;
                      return DefaultTextFormField(
                        fontSize: 18.0,
                        readOnly: true,
                        text: placement,
                        label: "Placement Location",
                        fillColor: Colors.white,
                      );
                    }
                    return const DefaultText(
                        size: 20.0,
                        text: "You haven't selected your industry supervisor");
                  }),
              // DropdownButtonFormField(
              //     decoration: const InputDecoration(
              //       enabledBorder: OutlineInputBorder(
              //         borderRadius: BorderRadius.all(Radius.circular(30.0)),
              //         borderSide: BorderSide(
              //           color: Color.fromARGB(255, 76, 175, 80),
              //           width: 1.0,
              //         ),
              //       ),
              //       focusedBorder: OutlineInputBorder(
              //           borderRadius: BorderRadius.all(Radius.circular(30.0)),
              //           borderSide: BorderSide(
              //               color: Color.fromARGB(255, 76, 175, 80),
              //               width: 1.5)),
              //       filled: true,
              //       fillColor: Colors.white,
              //     ),
              //     hint: const DefaultText(size: 18, text: "Select Location"),
              //     value: dropdownval,
              //     items: locations
              //         .map((item) => DropdownMenuItem(
              //             value: item,
              //             child: DefaultText(
              //               text: item,
              //               size: 18,
              //             )))
              //         .toList(),
              //     onChanged: (value) {
              //       dropdownval = value;
              //     }),
              const SizedBox(
                height: 20.0,
              ),
              const DefaultText(
                size: 25,
                text: "The Map would be shown below",
                align: TextAlign.center,
              )
            ],
          ),
        ),
      ),
    );
  }
}
