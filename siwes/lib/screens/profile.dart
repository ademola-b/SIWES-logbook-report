import 'package:flutter/material.dart';
import 'package:siwes/utils/constants.dart';
import 'package:siwes/utils/defaultButton.dart';
import 'package:siwes/utils/defaultText.dart';
import 'package:siwes/utils/defaultTextFormField.dart';
import 'package:siwes/utils/dropdown.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final _form = GlobalKey<FormState>();
  final _key = GlobalKey<FormFieldState>();
  late String _email, _name, _phone, _dept;

  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController phoneController;
  late TextEditingController deptController;

  var dropdownval;
  bool enable = false;
  Color? fill;

  void _updateInfo() {
    bool isValid = _form.currentState!.validate();
    if (!isValid) return;
    _form.currentState!.save();
  }

  @override
  void initState() {
    nameController = TextEditingController(text: "Name");
    emailController = TextEditingController(text: "Email Address");
    phoneController = TextEditingController(text: "Phone Number");
    deptController = TextEditingController(text: "Department");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Constants.backgroundColor,
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  children: [
                    GestureDetector(
                      onTap: (() => Navigator.pop(context)),
                      child: Icon(
                        Icons.arrow_back_ios_new,
                        color: Constants.primaryColor,
                        size: 30.0,
                      ),
                    ),
                    const Spacer(),
                    InkWell(
                      onTap: () {
                        // _key.currentState!.;
                        setState(() {
                          enable = !enable;
                          if (enable) {
                            fill = Colors.white;
                          } else {
                            fill = const Color.fromRGBO(255, 255, 255, 0.1);
                          }
                        });
                      },
                      child: Icon(
                        Icons.edit,
                        color: Constants.primaryColor,
                        size: 30.0,
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 20.0),
                Column(
                  children: [
                    ClipOval(
                        child: Image.asset("assets/images/avatar.jpg",
                            width: 170, height: 170, fit: BoxFit.cover)),
                    DefaultText(
                      size: 25.0,
                      text: "Username",
                      color: Constants.primaryColor,
                    )
                  ],
                ),
                const SizedBox(height: 20.0),
                Form(
                  key: _form,
                  child: Column(
                    children: [
                      DefaultTextFormField(
                        text: nameController,
                        fontSize: 18.0,
                        label: 'Name',
                        enabled: enable,
                        readOnly: false,
                        fillColor: fill,
                        validator: Constants.validator,
                        onSaved: (value) {
                          _name = value!;
                        },
                      ),
                      const SizedBox(height: 20.0),
                      DefaultTextFormField(
                        fontSize: 18.0,
                        label: 'Email Address',
                        enabled: enable,
                        readOnly: false,
                        fillColor: fill,
                        text: emailController,
                        validator: Constants.validator,
                        onSaved: (value) {
                          _email = value!;
                        },
                      ),
                      const SizedBox(height: 20.0),
                      DefaultTextFormField(
                        label: "Phone Number",
                        fontSize: 15.0,
                        enabled: enable,
                        readOnly: false,
                        fillColor: fill,
                        text: phoneController,
                        validator: Constants.validator,
                        onSaved: (value) {
                          _phone = value!;
                        },
                      ),
                      const SizedBox(height: 20.0),
                      DefaultTextFormField(
                        label: "Department",
                        fontSize: 15.0,
                        text: deptController,
                        enabled: enable,
                        readOnly: false,
                        fillColor: fill,
                        validator: Constants.validator,
                        onSaved: (value) {
                          _dept = value!;
                        },
                      ),

                      // DefaultDropDown(
                      //     value: dropdownval,
                      //     onChanged: (value) {
                      //       dropdownval = value;
                      //     },
                      //     dropdownMenuItemList: ['computer science', 'sss']
                      //         .map((item) => DropdownMenuItem(
                      //             value: item,
                      //             child: DefaultText(
                      //               text: item,
                      //               size: 18,
                      //             )))
                      //         .toList(),
                      //     text: 'Department'),

                      const SizedBox(height: 20.0),
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: DefaultButton(
                            onPressed: () {
                              _updateInfo();
                            },
                            text: "UPDATE PROFILE",
                            textSize: 20.0),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
