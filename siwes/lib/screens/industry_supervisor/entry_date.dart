import 'dart:io';

import 'package:flutter/material.dart';
import 'package:siwes/models/entry_date_response.dart';
import 'package:siwes/services/remote_services.dart';
import 'package:siwes/utils/constants.dart';
import 'package:siwes/screens/students/navbar.dart';
import 'package:siwes/utils/defaultButton.dart';
import 'package:siwes/utils/defaultContainer.dart';
import 'package:siwes/utils/defaultText.dart';
import 'package:siwes/utils/defaultTextFormField.dart';

class EntryDate extends StatefulWidget {
  const EntryDate(Object? arguments, {super.key});

  @override
  State<EntryDate> createState() => _EntryDateState();
}

class _EntryDateState extends State<EntryDate> {
  File? _image;
  List<EntryDateResponse>? entry_Date = [];
  List<EntryDateResponse>? entD = [];
  TextEditingController titleController = TextEditingController();
  TextEditingController descController = TextEditingController();

  late String date;

  // Future<List<EntryDateResponse>?> _getEntryDate(String date) async {
  //   entry_Date = await RemoteServices().getEntryDate(date, context);
  //   if (entry_Date != null) {
  //     entD = entry_Date;
  //     titleController.text = entD![0].title;
  //     descController.text = entD![0].description;
  //     print(entD);
  //     // setState(() {
  //     // });
  //   }

  //   return null;
  // }

  @override
  void initState() {
    // print();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final routeData =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    // _getEntryDate(routeData['date']);
    print("route: $routeData");

    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Constants.backgroundColor,
      drawer: Navbar(),
      appBar: AppBar(
        title: const Text("Log Entry"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.only(
            top: 20.0, left: 20.0, right: 20.0, bottom: 20.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.all(20.0),
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(30.0))),
                child: Column(
                  children: [
                    Column(
                      children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child: DefaultText(
                            size: 20.0,
                            text: "${routeData['fname']} ${routeData['lname']}",
                            color: Constants.primaryColor,
                          ),
                        ),
                        Align(
                          alignment: Alignment.topLeft,
                          child: DefaultText(
                            size: 15.0,
                            text: "${routeData['username']}",
                            color: Constants.primaryColor,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20.0),
                    Align(
                      alignment: Alignment.topRight,
                      child: DefaultText(
                        size: 15.0,
                        text: "Date: ${routeData['date'].toString()}",
                        color: Constants.primaryColor,
                        italic: FontStyle.italic,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              FutureBuilder(
                future: RemoteServices().getEntryDate(
                    routeData['student_id'], routeData['date'], context),
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
                          text: "No entry for this date from the student",
                          color: Constants.primaryColor,
                        ),
                      ),
                    );
                  } else if (snapshot.hasData) {
                    var data = snapshot.data;

                    titleController.text = data![0].title;
                    descController.text = data[0].description;
                    return Column(
                      children: [
                        DefaultTextFormField(
                          label: "Title",
                          hintText: 'Title',
                          text: titleController,
                          fontSize: 20.0,
                          enabled: false,
                          fillColor: Colors.white,
                          readOnly: false,
                        ),
                        const SizedBox(height: 20),
                        DefaultTextFormField(
                          label: "Description",
                          text: descController,
                          hintText: "Description",
                          maxLines: 10,
                          fontSize: 20.0,
                          enabled: false,
                          fillColor: Colors.white,
                          readOnly: false,
                        ),
                        const SizedBox(height: 20.0),
                        const DefaultText(size: 15, text: "Diagram"),
                        Row(
                          children: [
                            Expanded(
                              child: (data[0].diagram != null)
                                  ? Image.memory(
                                      data[0].diagram!,
                                      width: 200,
                                      height: 200,
                                      fit: BoxFit.contain,
                                    )
                                  : const DefaultText(
                                      size: 20.0, text: "No Diagram"),
                            ),
                            const SizedBox(width: 20.0),
                          ],
                        ),
                      ],
                    );
                  }
                  return const CircularProgressIndicator();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
