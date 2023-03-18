import 'package:flutter/material.dart';
import 'package:siwes/utils/constants.dart';
import 'package:siwes/utils/defaultButton.dart';
import 'package:siwes/utils/defaultText.dart';
import 'package:siwes/utils/defaultTextFormField.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final _form = GlobalKey<FormState>();
  final _key = GlobalKey<FormFieldState>();
  dynamic value;
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
                        bool enable = _key.currentState!.widget.enabled;
                        if (!enable) {
                          setState(() {
                            enable = true;
                             _key.currentState!.widget.enabled;
                          });
                          print("Enable: $enable");
                          print(_key.currentState!.widget.enabled);
                        }
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
                        k: _key,
                        fontSize: 18.0,
                        label: 'Name',
                        enabled: false,
                        text: TextEditingController(
                            text: "First Name - Last Name"),
                        validator: Constants.validator,
                      ),
                      const SizedBox(height: 20.0),
                      DefaultTextFormField(
                        fontSize: 18.0,
                        label: 'Email Address',
                        enabled: false,
                        text: TextEditingController(text: "Email Address"),
                        validator: Constants.validator,
                      ),
                      const SizedBox(height: 20.0),
                      DefaultTextFormField(
                        label: "Phone Number",
                        fontSize: 15.0,
                        enabled: false,
                        text: TextEditingController(text: "Phone Number"),
                        validator: Constants.validator,
                      ),
                      const SizedBox(height: 20.0),
                      DefaultTextFormField(
                          label: "Department",
                          fontSize: 15.0,
                          enabled: false,
                          text: TextEditingController(text: "Department"),
                          validator: Constants.validator),
                      const SizedBox(height: 20.0),
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: DefaultButton(
                            onPressed: () {},
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
