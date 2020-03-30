import 'dart:convert';
import 'dart:core';
import 'package:geojson/geojson.dart';
import 'package:latlong/latlong.dart';

class Address {
  /// GPS Coordinate
  LatLng coordinate;

  /// House number
  String number;

  /// Street
  String street;

  /// Zip code
  String zipCode;

  /// City
  String city;

  //#endregion
  //Get an address from a geoJsonFeature
  factory Address.fromGeoJsonFeature(GeoJsonFeature feature) {
    Map<String, dynamic> props = feature.properties;
    return Address(
        city: props["city"],
        number: props["housenumber"],
        street: props["street"],
        zipCode: props["postcode"],
        coordinate: LatLng(feature.geometry.geoPoint.latitude,
            feature.geometry.geoPoint.longitude));
  }

  //Get an address from a json
  factory Address.fromJson(String jsonString) {
    Map<String, dynamic> json = jsonDecode(jsonString);
    return Address(
        number: json["number"],
        street: json["street"],
        zipCode: json["zipCode"],
        city: json["city"],
        coordinate: LatLng(json["latitude"] as double, json["longitude"] as double));
  }

  //Tranform object to json
  String toJson() => jsonEncode({
        "number": this.number,
        "street": this.street,
        "zipCode": this.zipCode,
        "city": this.city,
        "latitude": this.coordinate?.latitude,
        "longitude": this.coordinate?.longitude
      });
  //#region Methods

  /// Get the full address
  String get fullAddress {
    String result = "";
    void addToAddress(String valueToAdd) {
      if (valueToAdd != null) {
        if (result != "") result += " ";
        result += valueToAdd;
      }
    }

    addToAddress(this.number);
    addToAddress(this.street);
    addToAddress(this.zipCode);
    addToAddress(this.city);
    return result;
  }

  Address({this.number, this.city, this.coordinate, this.street, this.zipCode});
}
