import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
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

  void _submit() {}

  @override
  void initState() {
    print("widget data: ${widget.arguments}");
    titleController!.text = widget.arguments['title'];
    descController!.text = widget.arguments['desc'];
    super.initState();
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
                      text: "Week ${routeData['week_index']}".toString(),
                      color: Constants.primaryColor,
                    ),
                    const SizedBox(height: 20.0),
                    DefaultText(
                      size: 25.0,
                      text: "Date - ${routeData['date']}",
                      // "Date - ${routeData['date'].day}/${routeData['date'].month}/${routeData['date'].year}",
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
                  ),
                  const SizedBox(height: 20),
                  DefaultTextFormField(
                    text: descController,
                    label: "Description",
                    hintText: "Description",
                    maxLines: 10,
                    fontSize: 15.0,
                    fillColor: Colors.white,
                  ),
                  const SizedBox(height: 20),
                  const DefaultText(size: 15, text: "Diagram"),
                  Row(
                    children: [
                      Expanded(
                        child: _image != null
                            // widget.arguments['diagram'] != null

                            ? Image.file(
                                _image!,
                                width: 200,
                                height: 200,
                                fit: BoxFit.contain,
                              )
                            : Image.asset(
                                "assets/images/avatar.jpg",
                                width: 200,
                                height: 200,
                                fit: BoxFit.contain,
                              ),
                      ),
                      const SizedBox(width: 20.0),
                      Column(
                        children: [
                          SelectImageBtn(
                            icon: Icons.camera,
                            text: 'Select from Camera',
                            onPressed: () {
                              getImage(ImageSource.camera);
                            },
                          ),
                          SelectImageBtn(
                            text: "Select from Gallery",
                            icon: Icons.image_outlined,
                            onPressed: () {
                              getImage(ImageSource.gallery);
                            },
                          )
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 20.0),
                  SizedBox(
                      width: size.width,
                      child: DefaultButton(
                        onPressed: _submit,
                        text: 'SUBMIT',
                        textSize: 20.0,
                      ))
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
