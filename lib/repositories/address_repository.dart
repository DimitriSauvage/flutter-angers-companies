import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:geojson/geojson.dart';
import 'package:hello_world/models/address.dart';

class AddressRepository {
  // Api base adress
  static String apiBaseAdress = "https://api-adresse.data.gouv.fr/search";

  Future<List<Address>> search(String search) async {
    //Request the API
    Response response =
        await Dio().get("$apiBaseAdress/?q=$search&autocomplete=1");

    GeoJsonFeatureCollection featureCollection = GeoJsonFeatureCollection();
    try {
      featureCollection = await featuresFromGeoJson(jsonEncode(response.data));
    } catch (e) {
      print("Error while searching addresses");
      rethrow;
    }

    //Transform
    List<Address> addresses = List<Address>();
    featureCollection.collection.forEach((feature) {
      addresses.add(Address.fromGeoJsonFeature(feature));
    });
    return addresses;
  }
}
