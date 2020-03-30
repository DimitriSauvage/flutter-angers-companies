import 'package:flutter/material.dart';
import 'package:hello_world/screens/home.dart';

import 'routes.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Entreprises angevines',
      routes: Routes.getRoutes(),
      theme: ThemeData(
        primarySwatch: Colors.limeAccent[50],
      ),
      home: Home(),
    );
  }
}
