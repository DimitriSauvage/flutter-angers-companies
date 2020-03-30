import 'package:flutter/material.dart';
import 'package:hello_world/models/address.dart';
import 'package:hello_world/models/company.dart';
import 'package:hello_world/repositories/preference_repository.dart';
import 'package:hello_world/tabs/company_list.dart';
import 'package:hello_world/tabs/map_tab.dart';
import 'package:latlong/latlong.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  PreferenceRepository _preferenceRepository = new PreferenceRepository();
  int _index = 0;
  List<Company> _companies = List<Company>();

  @override
  void initState() {
    this.setState(() {
      this
          ._preferenceRepository
          .loadCompanies()
          .then((values) => this._companies = values);
    });
    super.initState();
  }

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
    this._preferenceRepository.saveCompanies(this._companies);
  }

  ///Remove the company
  void _removeCompany(Company company) {
    this._companies.removeWhere((x) => x.id == company.id);

    this._preferenceRepository.saveCompanies(this._companies);
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
