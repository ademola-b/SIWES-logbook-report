import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:siwes/models/entry_report_response.dart';
import 'package:siwes/services/remote_services.dart';
import 'package:siwes/utils/constants.dart';
import 'package:siwes/screens/students/navbar.dart';
import 'package:siwes/utils/defaultButton.dart';
import 'package:siwes/utils/defaultText.dart';
import 'package:siwes/utils/defaultTextFormField.dart';

class Reports extends StatefulWidget {
  const Reports({super.key});

  @override
  State<Reports> createState() => _ReportsState();
}

class _ReportsState extends State<Reports> {
  final _form = GlobalKey<FormState>();
  final TextEditingController _fromDate = TextEditingController();
  final TextEditingController _toDate = TextEditingController();
  DateTime pickedDate = DateTime.now();
  List<EntryReportResponse>? entryRepo;

  pickDate() async {
    var picked = await showDatePicker(
        context: context,
        initialDate: pickedDate,
        firstDate: DateTime(2000),
        lastDate: DateTime(2030));

    if (picked != null && picked != pickedDate) {
      setState(() {
        pickedDate = picked;
      });
    }
  }

  pickFromDate() async {
    await pickDate();
    var outputDate = DateFormat('yyyy-MM-dd').format(pickedDate);
    _fromDate.text = outputDate;
  }

  pickToDate() async {
    await pickDate();
    var outputDate = DateFormat('yyyy-MM-dd').format(pickedDate);
    _toDate.text = outputDate;
  }

  void _submit() async {
    var isValid = _form.currentState!.validate();
    if (!isValid) return;
    _form.currentState!.save();

    List<EntryReportResponse>? entryReport =
        await RemoteServices.entryReport(context, _fromDate.text, _toDate.text);

    if (entryReport != null && entryReport.isNotEmpty) {
      setState(() {
        entryRepo = [];
        entryRepo = [...entryRepo!, ...entryReport];
      });
      showModalBottomSheet(
          context: context,
          builder: (builder) {
            return SizedBox(
              height: 500,
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.check_circle_outline_rounded,
                      size: 150.0,
                      color: Constants.primaryColor,
                    ),
                    const SizedBox(height: 10.0),
                    const DefaultText(
                        size: 20.0, text: "Successfully Generated"),
                    const SizedBox(height: 30.0),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: DefaultButton(
                          onPressed: () async {
                            Constants.generateEntryCSV(
                                entryRepo,
                                "entry_report_${_fromDate.text}_${_toDate.text}",
                                context);
                            Navigator.pop(context);
                            await Constants.dialogBox(
                                context,
                                "Report Exported",
                                Constants.primaryColor,
                                Icons.info_outline_rounded);
                            Navigator.pop(context);
                          },
                          text: "Export",
                          textSize: 20.0),
                    ),
                  ],
                ),
              ),
            );
          });
    } else if (entryReport != null && entryReport.isEmpty) {
      Constants.dialogBox(context, "No Record for the selected dates",
          Constants.primaryColor, Icons.info_outline_rounded);
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Constants.backgroundColor,
      drawer: Navbar(),
      appBar: AppBar(
        title: const DefaultText(
            text: "Generate Report", size: 18.0, weight: FontWeight.bold),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 40.0),
        child: Column(
          children: [
            Expanded(
              flex: 2,
              child: Form(
                  key: _form,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        DefaultTextFormField(
                          text: _fromDate,
                          fillColor: Colors.white,
                          onTap: () {
                            pickFromDate();
                          },
                          keyboardInputType: TextInputType.none,
                          onSaved: (newVal) {},
                          validator: (String? value) {
                            if (value!.isEmpty) {
                              return "This field is required";
                            }
                            return null;
                          },
                          label: 'from date',
                          fontSize: 15.0,
                          readOnly: false,
                        ),
                        const SizedBox(height: 20.0),
                        DefaultTextFormField(
                          text: _toDate,
                          onTap: () {
                            pickToDate();
                          },
                          keyboardInputType: TextInputType.none,
                          fillColor: Colors.white,
                          onSaved: (newVal) {},
                          validator: (String? value) {
                            if (value!.isEmpty) {
                              return "This field is required";
                            }
                            return null;
                          },
                          label: 'to date',
                          fontSize: 15.0,
                          readOnly: false,
                        ),
                      ],
                    ),
                  )),
            ),
            const Spacer(),
            SizedBox(
                width: MediaQuery.of(context).size.width,
                child: DefaultButton(
                    onPressed: () {
                      _submit();
                    },
                    text: 'Generate',
                    textSize: 20))
          ],
        ),
      ),
    );
  }
}
