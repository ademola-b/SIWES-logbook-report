import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:siwes/models/placement_centre_response.dart';
import 'package:siwes/screens/industry_supervisor/navbar.dart';
import 'package:siwes/services/remote_services.dart';
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
  RemoteServices _remote = RemoteServices();
  Position? _position;
  TextEditingController nameController = TextEditingController();
  TextEditingController longController = TextEditingController();
  TextEditingController latController = TextEditingController();
  TextEditingController radiusController = TextEditingController();

  Future _getCurrentLocation() async {
    Position position = await _determinePosition();
    setState(() {
      _position = position;
    });
  }

  Future<Position> _determinePosition() async {
    LocationPermission permission;
    //turn on user's location
    //check permission
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location Permissions are denied');
      }
    }

    return Geolocator.getCurrentPosition();
  }

  Future<List<PlacementCentreResponse>?>? _getPlacementCentre() async {
    List<PlacementCentreResponse>? _placement =
        await _remote.getPlacementCentre(context);
    if (_placement != null) {
      setState(() {
         
        nameController.text = _placement[0].name;
        longController.text = _placement[0].longitude;
        latController.text = _placement[0].latitude;
        radiusController.text = _placement[0].radius;
        // print(_placement.);
      });
      return _placement;
    }
  }

  void submitPlacementDetails(
      String name, String longitude, String latitude, String radius) async {
    PlacementCentreResponse? placement = await _remote.addPlacementCentre(
        context, name, longitude, latitude, radius);
    if (placement != null) {
      await showDialog(
          context: context,
          builder: (context) => AlertDialog(
                content: SizedBox(
                  height: 120.0,
                  child: Column(
                    children: [
                      Icon(
                        Icons.check_circle_outline,
                        size: 70.0,
                        color: Constants.backgroundColor,
                      ),
                      const SizedBox(height: 20.0),
                      const DefaultText(
                        size: 20.0,
                        text: "Placement Saved",
                        color: Colors.green,
                      ),
                    ],
                  ),
                ),
              ));
    }
  }

  @override
  void initState() {
    _getPlacementCentre();
    super.initState();
  }

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
        padding: const EdgeInsets.all(20.0),
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
                      onPressed: () async {
                        await _getCurrentLocation();
                        longController.text = _position!.longitude.toString();
                        latController.text = _position!.latitude.toString();
                        radiusController.text = "100";
                      },
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
                    DefaultTextFormField(
                      fontSize: 15.0,
                      label: 'Name',
                      text: nameController,
                       readOnly: false,
                      // hintText: 'Name',
                    ),
                    const SizedBox(height: 20.0),
                    DefaultTextFormField(
                      fontSize: 15.0,
                      label: 'Longitude',
                      text: longController,
                      enabled: false,  readOnly: false,
                    ),
                    const SizedBox(height: 20.0),
                    DefaultTextFormField(
                      label: "Latitude",
                      fontSize: 15.0,
                      text: latController,
                      enabled: false,  readOnly: false,
                    ),
                    const SizedBox(height: 20.0),
                    DefaultTextFormField(
                      label: "Radius",
                      fontSize: 15.0,
                      text: radiusController,
                      enabled: false,  readOnly: false,
                    ),
                    const SizedBox(height: 20.0),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: DefaultButton(
                          onPressed: () {
                            submitPlacementDetails(
                                nameController.text,
                                longController.text,
                                latController.text,
                                radiusController.text);
                          },
                          text: "SUBMIT",
                          textSize: 18.0),
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
