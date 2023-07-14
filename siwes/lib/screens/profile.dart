import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:siwes/models/user_response.dart';
import 'package:siwes/services/remote_services.dart';
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
  String? userType;
  late String _email, _name, _phone, _dept;

  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController phoneController;
  late TextEditingController deptController;

  var dropdownval;
  bool enable = false;
  Color? fill;

  Future<UserResponse?> _getUserType() async {
    UserResponse? user = await RemoteServices.getUser(context);
    if (user != null) {
      setState(() {
        userType = user.userType;
      });
      // return user;
      // print("user Type: $userType");
    }
    return null;
  }

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
    _getUserType();
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
                userType == 'student'
                    ? FutureBuilder(
                        future: RemoteServices.getStdDetails(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            var data = snapshot.data![0];
                            return Column(
                              children: [
                                Column(
                                  children: [
                                    data.profilePicMem.isEmpty
                                        ? ClipOval(
                                            child: Image.asset(
                                                "assets/images/avatar.jpg",
                                                width: 170,
                                                height: 170,
                                                fit: BoxFit.cover))
                                        : ClipOval(
                                            child: Image.memory(
                                                data.profilePicMem,
                                                width: 170,
                                                height: 170,
                                                fit: BoxFit.cover)),
                                    DefaultText(
                                      size: 25.0,
                                      text: data.user.username,
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
                                        text: TextEditingController(
                                            text:
                                                "${data.user.firstName}  ${data.user.lastName}"),
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
                                        text: TextEditingController(
                                            text: data.user.email),
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
                                        text: TextEditingController(
                                            text: data.phoneNo),
                                        validator: Constants.validator,
                                        onSaved: (value) {
                                          _phone = value!;
                                        },
                                      ),
                                      const SizedBox(height: 20.0),
                                      DefaultTextFormField(
                                        label: "Department",
                                        fontSize: 15.0,
                                        text: TextEditingController(
                                            text: data.departmentId),
                                        enabled: enable,
                                        readOnly: false,
                                        fillColor: fill,
                                        validator: Constants.validator,
                                        onSaved: (value) {
                                          _dept = value!;
                                        },
                                      ),
                                      const SizedBox(height: 20.0),
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        child: DefaultButton(
                                            onPressed: () {
                                              Constants.dialogBox(
                                                  context,
                                                  "Profile updating is not available at the moment",
                                                  Constants.primaryColor,
                                                  Icons.info_outline);
                                              Navigator.pop(context);
                                              // _updateInfo();
                                            },
                                            text: "UPDATE PROFILE",
                                            textSize: 20.0),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            );
                          }
                          return const CircularProgressIndicator();
                        })
                    : userType == 'industry_based_supervisor'
                        ? FutureBuilder(
                            future: RemoteServices.getIndProfile(),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                var data = snapshot.data![0];
                                return Column(
                                  children: [
                                    Column(
                                      children: [
                                        data.profileNoMemory.isEmpty
                                            ? ClipOval(
                                                child: Image.asset(
                                                    "assets/images/avatar.jpg",
                                                    width: 170,
                                                    height: 170,
                                                    fit: BoxFit.cover))
                                            : ClipOval(
                                                child: Image.memory(
                                                    data.profileNoMemory,
                                                    width: 170,
                                                    height: 170,
                                                    fit: BoxFit.cover)),
                                        DefaultText(
                                          size: 25.0,
                                          text: data.user.username,
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
                                            text: TextEditingController(
                                                text:
                                                    "${data.user.firstName} ${data.user.lastName}"),
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
                                            text: TextEditingController(
                                                text: data.user.email),
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
                                            text: TextEditingController(
                                                text: data.phoneNo),
                                            validator: Constants.validator,
                                            onSaved: (value) {
                                              _phone = value!;
                                            },
                                          ),
                                          const SizedBox(height: 20.0),
                                          SizedBox(
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
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
                                );
                              }
                              return const CircularProgressIndicator();
                            },
                          )
                        : FutureBuilder(
                            future: RemoteServices.getSchProfile(context),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                var data = snapshot.data![0];
                                return Column(
                                  children: [
                                    Column(
                                      children: [
                                        data.profilePicMemory.isEmpty
                                            ? ClipOval(
                                                child: Image.asset(
                                                    "assets/images/avatar.jpg",
                                                    width: 170,
                                                    height: 170,
                                                    fit: BoxFit.cover))
                                            : ClipOval(
                                                child: Image.memory(
                                                    data.profilePicMemory,
                                                    width: 170,
                                                    height: 170,
                                                    fit: BoxFit.cover)),
                                        DefaultText(
                                          size: 25.0,
                                          text: data.user.username,
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
                                            text: TextEditingController(
                                                text:
                                                    "${data.user.firstName} ${data.user.lastName}"),
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
                                            text: TextEditingController(
                                                text: data.user.email),
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
                                            text: TextEditingController(
                                                text: data.phoneNo),
                                            validator: Constants.validator,
                                            onSaved: (value) {
                                              _phone = value!;
                                            },
                                          ),
                                          const SizedBox(height: 20.0),
                                          DefaultTextFormField(
                                            label: "Department",
                                            fontSize: 15.0,
                                            text: TextEditingController(
                                                text: data.departmentId),
                                            enabled: enable,
                                            readOnly: false,
                                            fillColor: fill,
                                            validator: Constants.validator,
                                            onSaved: (value) {
                                              _dept = value!;
                                            },
                                          ),
                                          const SizedBox(height: 20.0),
                                          SizedBox(
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
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
                                );
                              }
                              return const CircularProgressIndicator();
                            },
                          ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
