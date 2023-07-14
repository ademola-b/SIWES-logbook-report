// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:easy_geofencing/easy_geofencing.dart';
import 'package:easy_geofencing/enums/geofence_status.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:siwes/models/logbook_entry_response.dart';
import 'package:siwes/models/student_details.dart';
import 'package:siwes/services/remote_services.dart';
import 'package:siwes/utils/constants.dart';
import 'package:siwes/screens/students/navbar.dart';
import 'package:siwes/utils/defaultButton.dart';
import 'package:siwes/utils/defaultText.dart';
import 'package:siwes/utils/defaultTextFormField.dart';
import 'package:path/path.dart' as Path;

class LogEntry extends StatefulWidget {
  final arguments;

  const LogEntry(Object? this.arguments, {super.key});

  @override
  State<LogEntry> createState() => _LogEntryState();
}

class _LogEntryState extends State<LogEntry> {
  File? _image;

  TextEditingController? titleController = TextEditingController();
  TextEditingController? descController = TextEditingController();

  String? _latitude, _longitude, _radius;
  Stream<GeofenceStatus>? geofenceBroadcastStatusStream;
  StreamSubscription<GeofenceStatus>? geofenceStatusStream;

  String geofenceStatus = '';

  //get the image
  Future getImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);

      //don't do anything if image is null
      if (image == null) return;

      // final imgTemp = File(image.path);

      final imgPerm = await saveImagePermanently(image.path);
      setState(() {
        _image = imgPerm;
      });
      print("imagePath - $_image");
    } catch (e) {
      showDialog(
          barrierDismissible: false,
          context: context,
          builder: (context) => AlertDialog(
                title: const Text("Select Image"),
                content: const DefaultText(
                    size: 15, text: "An error occurred while selecting image"),
                actions: [
                  TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const DefaultText(size: 10, text: "okay"))
                ],
              ));
    }
  }

  Future<File> saveImagePermanently(String imagePath) async {
    final directory = await getApplicationDocumentsDirectory();
    final name = Path.basename(imagePath);
    final image = File('${directory.path}/$name');

    return File(imagePath).copy(image.path);
  }

  Future<StudentDetailResponse?> _getStdDetails() async {
    List<StudentDetailResponse>? std = await RemoteServices.getStdDetails();
    if (std.isNotEmpty) {
      setState(() {
        _latitude = std[0].industryBasedSupervisor.placementCenter.latitude;
        _longitude = std[0].industryBasedSupervisor.placementCenter.longitude;
        _radius = std[0].industryBasedSupervisor.placementCenter.radius;
      });
    }
    return null;
  }

  startStreaming() async {
    // await stopStreaming();

    EasyGeofencing.startGeofenceService(
        pointedLatitude: _latitude,
        pointedLongitude: _longitude,
        radiusMeter: _radius,
        eventPeriodInSeconds: 5);
    // await geofenceStatusStream?.cancel();

    geofenceStatusStream ??=
        EasyGeofencing.getGeofenceStream()?.listen((GeofenceStatus status) {
      print(status.toString());
      // print("Status - ${status.runtimeType}");
      setState(() {
        geofenceStatus = status.toString();
      });
    });
  }

  stopStreaming() async {
    if (geofenceStatusStream == null) return;
    geofenceStatusStream!.cancel();
    EasyGeofencing.stopGeofenceService();
    // geofenceStatusStream = null;
    print('Streaming stopped');
    print(geofenceStatusStream.toString());
  }

  getLocation() async {
    await _getStdDetails();
    startStreaming();
    // stopStreaming();
  }

  @override
  void _submit(int week, String entry_date, String title, String description,
      File? diagram) async {
    if (widget.arguments['comment_filled']) {
      await stopStreaming();
      await Constants.dialogBox(
          context,
          "You can't submit logbook because both supervisors have commented",
          Colors.amber,
          Icons.dangerous_rounded);
    } else {
      // await getLocation();
      if (geofenceStatus == 'GeofenceStatus.exit') {
        await stopStreaming();
        await Constants.dialogBox(context, "You are not in the designated area",
            Colors.red[900], Icons.location_off_outlined);
        Navigator.pop(context);
      } else if (geofenceStatus == 'GeofenceStatus.enter') {
        LogbookEntry? _logEntry = await RemoteServices.PostLogEntry(
            context, week.toString(), entry_date, title, description, diagram);
        await stopStreaming();
        await Constants.dialogBox(context, "Entry Saved",
            Constants.primaryColor, Icons.check_circle_outline);
        Navigator.pop(context);
      }
    }
  }

  @override
  void initState() {
    getLocation();
    // print("widget data: ${widget.arguments}");
    titleController!.text = widget.arguments['title'];
    descController!.text = widget.arguments['desc'];
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose

    super.dispose();
    stopStreaming();
    print("disposed");
  }

  @override
  Widget build(BuildContext context) {
    final routeData =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    // print(routeData);

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
                    DefaultText(
                      size: 25.0,
                      text: "Week ${routeData['week_index'] + 1}".toString(),
                      color: Constants.primaryColor,
                      weight: FontWeight.bold,
                    ),
                    const SizedBox(height: 20.0),
                    DefaultText(
                      size: 25.0,
                      text: "Date: ${routeData['date']}",
                      weight: FontWeight.bold,
                      color: Constants.primaryColor,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Form(
                  child: Column(
                children: [
                  DefaultTextFormField(
                    text: titleController,
                    label: 'Title',
                    hintText: 'Title',
                    fontSize: 15.0,
                    fillColor: Colors.white,
                    readOnly: false,
                    validator: Constants.validator,
                  ),
                  const SizedBox(height: 20),
                  DefaultTextFormField(
                    text: descController,
                    label: "Description",
                    hintText: "Description",
                    maxLines: 10,
                    fontSize: 15.0,
                    fillColor: Colors.white,
                    readOnly: false,
                    validator: Constants.validator,
                  ),
                  const SizedBox(height: 20),
                  DefaultText(
                    size: 20,
                    text: "Diagram",
                    align: TextAlign.left,
                    color: Constants.primaryColor,
                  ),
                  Row(
                    children: [
                      Expanded(
                          child: (widget.arguments['diagram'] != null)
                              ? Image.memory(
                                  base64Decode(widget.arguments['diagram']),
                                  width: 200,
                                  height: 200,
                                  fit: BoxFit.contain,
                                )
                              : (_image != null)
                                  ? Image.file(
                                      _image!,
                                      width: 200,
                                      height: 200,
                                      fit: BoxFit.contain,
                                    )
                                  : DefaultText(
                                      size: 20.0,
                                      text: 'No Diagram',
                                      color: Constants.primaryColor,
                                    )),
                      const SizedBox(width: 20.0),
                      !widget.arguments['comment_filled']
                          ? DefaultButton(
                              onPressed: () {
                                showModalBottomSheet(
                                    context: context,
                                    builder: (builder) {
                                      return SizedBox(
                                        height: 200,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(top: 20.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              GestureDetector(
                                                onTap: () {
                                                  getImage(ImageSource.camera);
                                                  Navigator.pop(context);
                                                },
                                                child: Column(
                                                  children: [
                                                    const Icon(Icons.camera,
                                                        size: 70.0),
                                                    DefaultText(
                                                        size: 25.0,
                                                        text: "Camera",
                                                        color: Constants
                                                            .primaryColor)
                                                  ],
                                                ),
                                              ),
                                              const SizedBox(width: 30.0),
                                              GestureDetector(
                                                onTap: () {
                                                  getImage(ImageSource.gallery);
                                                  Navigator.pop(context);
                                                },
                                                child: Column(
                                                  children: [
                                                    const Icon(
                                                        Icons.image_outlined,
                                                        size: 70.0),
                                                    DefaultText(
                                                        size: 25.0,
                                                        text: "Gallery",
                                                        color: Constants
                                                            .primaryColor)
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    });
                              },
                              text: "Upload Image",
                              textSize: 15.0)
                          : Container(),
                    ],
                  ),
                  const SizedBox(height: 20.0),
                  SizedBox(
                      width: size.width,
                      child: DefaultButton(
                        onPressed: () {
                          _submit(
                              widget.arguments['wkIndex'],
                              widget.arguments['date'],
                              titleController!.text,
                              descController!.text,
                              _image);
                        },
                        text: 'SUBMIT',
                        textSize: 20.0,
                      )),
                ],
              )),
            ],
          ),
        ),
      ),
    );
  }
}

class SelectImageBtn extends StatelessWidget {
  final String text;
  final IconData icon;
  final Function onPressed;

  const SelectImageBtn({
    Key? key,
    required this.text,
    required this.icon,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: () {
          onPressed();
        },
        child: Row(
          children: [
            Icon(icon),
            const SizedBox(width: 20.0),
            DefaultText(
              size: 15.0,
              text: text,
            ),
          ],
        ));
  }
}
