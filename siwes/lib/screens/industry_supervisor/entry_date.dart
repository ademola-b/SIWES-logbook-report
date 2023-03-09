import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:siwes/models/entry_date_response.dart';
import 'package:siwes/services/remote_services.dart';
import 'package:siwes/utils/constants.dart';
import 'package:siwes/screens/students/navbar.dart';
import 'package:siwes/utils/defaultButton.dart';
import 'package:siwes/utils/defaultText.dart';
import 'package:siwes/utils/defaultTextFormField.dart';
import 'package:path/path.dart' as Path;

class EntryDate extends StatefulWidget {
  const EntryDate(Object? arguments, {super.key});

  @override
  State<EntryDate> createState() => _EntryDateState();
}

class _EntryDateState extends State<EntryDate> {
  File? _image;
  List<EntryDateResponse>? entry_Date = [];

  late String date;

  Future<List<EntryDateResponse>?> _getEntryDate(String date) async {
    entry_Date = await RemoteServices().getEntryDate(date, context);
    if (entry_Date != null) {
      print(entry_Date);
    }

    return null;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final routeData =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    _getEntryDate(routeData['date']);
    print(routeData);

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
              Form(
                  child: Column(
                children: [
                  const DefaultTextFormField(
                    hintText: 'Title',
                    fontSize: 15.0,
                    enabled: false,
                  ),
                  const SizedBox(height: 20),
                  const DefaultTextFormField(
                    hintText: "Description",
                    maxLines: 10,
                    fontSize: 15.0,
                    enabled: false,
                  ),
                  const SizedBox(height: 20.0),
                  const DefaultText(size: 15, text: "Diagram"),
                  Row(
                    children: [
                      Expanded(
                        child: _image != null
                            ? Image.file(
                                _image!,
                                width: 200,
                                height: 200,
                                fit: BoxFit.contain,
                              )
                            : const DefaultText(size: 20.0, text: "No Diagram"),
                      ),
                      const SizedBox(width: 20.0),
                    ],
                  ),
                ],
              )),
            ],
          ),
        ),
      ),
    );
  }
}
