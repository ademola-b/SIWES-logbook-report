import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:siwes/screens/industry_supervisor/navbar.dart';
import 'package:siwes/utils/constants.dart';
import 'package:siwes/utils/defaultButton.dart';
import 'package:siwes/utils/defaultText.dart';
import 'package:siwes/utils/defaultTextFormField.dart';

class IndPlacementCentre extends StatefulWidget {
  const IndPlacementCentre({super.key});

  @override
  State<IndPlacementCentre> createState() => _IndPlacementCentreState();
}

class _IndPlacementCentreState extends State<IndPlacementCentre> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constants.backgroundColor,
      drawer: Navbar(),
      appBar: AppBar(
        title: const Text("Placement Centre"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              DefaultText(
                size: 18.0,
                text:
                    "Kindly, fill this form to register your placement centre",
                color: Constants.primaryColor,
              ),
              const SizedBox(
                height: 20.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  DefaultButton(
                      onPressed: () {},
                      text: "Get Coordinates",
                      textSize: 15.0),
                ],
              ),
              const SizedBox(
                height: 20.0,
              ),
              Form(
                child: Column(
                  children: [
                    const DefaultTextFormField(
                      fontSize: 15.0,
                      hintText: 'Name',
                    ),
                    const SizedBox(height: 20.0),
                    const DefaultTextFormField(
                      fontSize: 15.0,
                      hintText: 'Longitude',
                    ),
                    const SizedBox(height: 20.0),
                    const DefaultTextFormField(
                      hintText: "Latitude",
                      fontSize: 15.0,
                    ),
                    const SizedBox(height: 20.0),
                    const DefaultTextFormField(
                      hintText: "Radius",
                      fontSize: 15.0,
                    ),
                    const SizedBox(height: 20.0),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: DefaultButton(
                          onPressed: () {}, text: "SUBMIT", textSize: 18.0),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20.0),
              const DefaultText(
                  size: 15.0, text: "Show map if placement is set Or edit")
            ],
          ),
        ),
      ),
    );
  }
}
