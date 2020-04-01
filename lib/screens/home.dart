import 'package:flutter/material.dart';
import 'package:hello_world/tabs/company_list.dart';
import 'package:hello_world/tabs/map_tab.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _index = 0;

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
          MapTab(),
          CompanyList(),
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
