import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:siwes/models/ind_std_list.dart';
import 'package:siwes/screens/industry_supervisor/navbar.dart';
import 'package:siwes/services/remote_services.dart';
import 'package:siwes/utils/constants.dart';
import 'package:siwes/utils/defaultButton.dart';
import 'package:siwes/utils/defaultText.dart';

class IndStudent extends StatefulWidget {
  const IndStudent({super.key});

  @override
  State<IndStudent> createState() => _IndStudentState();
}

class _IndStudentState extends State<IndStudent> {
  List<IndStdList>? indStd = [];

  Future<List<IndStdList>?> _getIndStdList() async {
    List<IndStdList>? stdL = await RemoteServices().getIndStdList();
    if (stdL != null) {
      setState(() {
        indStd = [...indStd!, ...stdL];
      });
    }
    return null;
  }

  @override
  void initState() {
    _getIndStdList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constants.backgroundColor,
      drawer: Navbar(),
      appBar: AppBar(
        title: const Text("Students"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 40.0, left: 20.0, right: 20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const DefaultText(size: 20.0, text: "List of Students"),
              const SizedBox(
                height: 20.0,
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: indStd!.isNotEmpty
                      ? Column(
                          children: [
                            ListView.builder(
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              itemCount: indStd!.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Container(
                                  margin: const EdgeInsets.only(bottom: 10.0),
                                  width: MediaQuery.of(context).size.width,
                                  decoration: const BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20.0)),
                                    color: Colors.white,
                                  ),
                                  child: ListTile(
                                    onTap: () {
                                      Navigator.pushNamed(
                                          context, '/studentDetails');
                                    },
                                    leading: ClipOval(
                                        child: Image.memory(
                                      indStd![index].picMem,
                                      width: 50,
                                      height: 50,
                                      fit: BoxFit.cover,
                                    )),
                                    title: DefaultText(
                                      size: 18,
                                      text:
                                          "${indStd![index].user.firstName} ${indStd![index].user.lastName}",
                                      color: Colors.green,
                                      weight: FontWeight.w500,
                                    ),
                                    subtitle: DefaultText(
                                      size: 15,
                                      text: indStd![index].user.username,
                                      color: Colors.green,
                                      weight: FontWeight.w500,
                                    ),
                                    trailing:
                                        const Icon(Icons.arrow_forward_ios),
                                  ),
                                );
                              },
                            ),
                            const SizedBox(height: 20.0),
                            SizedBox(
                                width: MediaQuery.of(context).size.width,
                                child: DefaultButton(
                                    onPressed: () {},
                                    text: "Export",
                                    textSize: 20.0)),
                          ],
                        )
                      : Container(
                          padding: const EdgeInsets.all(20.0),
                          decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30.0))),
                          child: DefaultText(
                            text: "No student on your supervision",
                            size: 18.0,
                            color: Constants.primaryColor,
                          ),
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
