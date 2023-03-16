// To parse this JSON data, do
//
//     final placementCentreResponse = placementCentreResponseFromJson(jsonString);

import 'dart:convert';

List<PlacementCentreResponse> placementCentreResponseFromJson(String str) => List<PlacementCentreResponse>.from(json.decode(str).map((x) => PlacementCentreResponse.fromJson(x)));

String placementCentreResponseToJson(List<PlacementCentreResponse> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PlacementCentreResponse {
    PlacementCentreResponse({
        this.id,
        required this.name,
        required this.longitude,
        required this.latitude,
        required this.radius,
    });

    int? id;
    String name;
    String longitude;
    String latitude;
    String radius;

    factory PlacementCentreResponse.fromJson(Map<String, dynamic> json) => PlacementCentreResponse(
        id: json["id"],
        name: json["name"],
        longitude: json["longitude"],
        latitude: json["latitude"],
        radius: json["radius"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "longitude": longitude,
        "latitude": latitude,
        "radius": radius,
    };
}
