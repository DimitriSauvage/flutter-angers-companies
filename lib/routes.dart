import 'package:flutter/cupertino.dart';
import 'package:hello_world/screens/edit_company.dart';
import 'package:hello_world/screens/search_address.dart';

class Routes {
  static String editCompany = "/editCompany";
  static String searchAdress = "/searchAdress";

  static Map<String, WidgetBuilder> getRoutes = {
    Routes.editCompany: (context) => EditCompany(),
    Routes.searchAdress: (context) => SearchAddress()
  };
}
