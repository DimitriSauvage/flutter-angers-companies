import 'package:flutter/material.dart';
import 'package:hello_world/models/address.dart';
import 'package:hello_world/models/company.dart';
import 'package:hello_world/tabs/company_list.dart';
import 'package:hello_world/tabs/map_tab.dart';
import 'package:latlong/latlong.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _index = 0;
  List<Company> _companies = [
    Company(
        name: "Delivagri",
        address: Address(
            city: "Angers",
            street: "Rue Lenepveu",
            number: "25",
            zipCode: "49100",
            coordinate: LatLng(47.4722900390625, -0.5509822964668274))),
    Company(
        name: "CNP",
        address: Address(
            city: "Angers",
            street: "Place François Mitterand",
            number: "1",
            zipCode: "49100",
            coordinate: LatLng(47.47730255126953, -0.5515300035476685))),
    Company(
        name: "ESPL",
        address: Address(
            city: "Angers",
            street: "Rue André Le Nôtre",
            number: "19",
            zipCode: "49000",
            coordinate: LatLng(47.475616455078125, -0.6068845987319946))),
    Company(
        name: "Orkeis",
        address: Address(
            city: "Beaucouzé",
            street: "Rue Michael Faraday",
            number: "13",
            zipCode: "49070",
            coordinate: LatLng(47.47435760498047, -0.6102772355079651))),
  ];

  //Save the company
  void _saveCompany(Company company) {
    //Check if the company exists
    int index = this._companies.indexWhere((x) => x.id == company.id);
    if (index >= 0) {
      this._companies[index] = company;
    } else {
      //Add the company
      this._companies.add(company);
    }
  }

  ///Remove the company
  void _removeCompany(Company company) {
    this._companies.removeWhere((x) => x.id == company.id);
  }

  ///Called when an item is selected in the tab bar
  void _onItemTapped(int index) {
    this.setState(() => this._index = index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: this._index,
        children: <Widget>[
          MapTab(companies: this._companies),
          CompanyList(
            companies: this._companies,
            onRemove: this._removeCompany,
            onSave: this._saveCompany,
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.map), title: Text("Carte")),
          BottomNavigationBarItem(icon: Icon(Icons.list), title: Text("Liste"))
        ],
        currentIndex: this._index,
        onTap: this._onItemTapped,
      ),
    );
  }
}
