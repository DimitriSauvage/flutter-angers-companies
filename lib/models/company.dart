import 'package:flutter/widgets.dart';
import 'package:uuid/uuid.dart';

import 'address.dart';

class Company {
  ///Name
  String name;

  ///Id
  Uuid id;

  ///Adress
  Address address;

  //Constructor
  Company({this.id, @required this.name, @required this.address}) {
    this.id = Uuid();
  }
}
