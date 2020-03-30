import 'package:flutter/widgets.dart';
import 'package:hello_world/screens/edit_company.dart';
import 'package:hello_world/screens/search_adress.dart';

class Routes {
  static const String addCompany = "/addCompany";
  static const String searchAdress = "/searchAdress";

  /// Get routes
  static Map<String, WidgetBuilder> getRoutes() => {
        addCompany: _getWidgetForRoute(EditCompany()),
        searchAdress: _getWidgetForRoute(SearchAdress())
      };

  ///Get the widget builder for the route
  static WidgetBuilder _getWidgetForRoute(Widget widget) => (context) => widget;
}
