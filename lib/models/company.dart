import 'package:flutter/widgets.dart';
import 'package:uuid/uuid.dart';

import 'adress.dart';

class Company {
  ///Name
  String name;

  ///Id
  Uuid id = Uuid();

  ///Adress
  Adress adress;

  //Constructor
  Company({this.id, @required this.name, this.adress});
}
