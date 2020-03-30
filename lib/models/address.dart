import 'dart:core';
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

  //#region Methods
  
  /// Get the full address  
  String get fullAddress{
    String result = "";
    void addToAddress (String valueToAdd) {
      if (valueToAdd != null) {
        if (result != "") result += " ";
        result += valueToAdd;
      }
    };

    addToAddress(this.number);
    addToAddress(this.street);
    addToAddress(this.zipCode);
    addToAddress(this.city);
    return result;
  }

  Address({this.number, this.city, this.coordinate, this.street, this.zipCode});
}
