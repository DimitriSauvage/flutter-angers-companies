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

    ;

    addToAddress(this.number);
    addToAddress(this.street);
    addToAddress(this.zipCode);
    addToAddress(this.city);
    return result;
  }

  Address({this.number, this.city, this.coordinate, this.street, this.zipCode});
}
