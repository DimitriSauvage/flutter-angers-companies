import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:uuid/uuid.dart';

import 'address.dart';

class Company {
  ///Name
  String name;

  ///Id
  String id;

  ///Adress
  Address address;

  //Constructor
  Company({this.id, @required this.name, @required this.address}) {
    if (this.id == null) this.id = Uuid().v4();
  }

  factory Company.fromJson(String jsonString) {
    Map<String, dynamic> json = jsonDecode(jsonString);
    return Company(
        name: json["name"],
        id: json["id"],
        address: Address.fromJson(json["address"]));
  }

  //Tranform object to json
  String toJson() => jsonEncode(
      {"name": this.name, "id": this.id, "address": this.address.toJson()});
}
