import 'package:flutter/material.dart';
import 'package:hello_world/repositories/company_repository.dart';
import 'package:hello_world/screens/home.dart';
import 'package:hello_world/stores/company_store.dart';
import 'package:provider/provider.dart';

import 'routes.dart';

void main() {
  //Shared fields
  CompanyRepository companyRepository = CompanyRepository();
  CompanyStore companyStore = CompanyStore(companyRepository);

  runApp(Provider<CompanyStore>(
    create: (_) => companyStore,
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    //Load data before app initialization
    Provider.of<CompanyStore>(context).load();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Entreprises angevines',
      routes: Routes.getRoutes,
      theme: ThemeData(
        primarySwatch: Colors.limeAccent[50],
      ),
      home: Home(),
    );
  }
}
