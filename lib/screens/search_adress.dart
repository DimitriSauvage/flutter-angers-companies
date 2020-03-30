import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hello_world/models/address.dart';
import 'package:hello_world/repositories/adress_repository.dart';

class SearchAdress extends StatefulWidget {
  @override
  _SearchAdressState createState() => _SearchAdressState();
}

class _SearchAdressState extends State<SearchAdress> {
  //Timer to wait for the user to stop taping
  Timer _debounce;
  //Repos
  AdressRepository _repository = new AdressRepository();
  //Adresses
  List<Address> _addresses = [];
  //Min research length
  int _minLength = 3;
  //Debounce time before searching
  Duration _debounceDuration = Duration(milliseconds: 500);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Recherche de l'adresse"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            TextField(
              autofocus: true,
              onChanged: (value) {
                if (this._debounce?.isActive ?? false) {
                  this._debounce.cancel();
                }
                this._debounce =
                    Timer(this._debounceDuration, () async {
                  if (value != null && value.trim().length > this._minLength) {
                    List<Address> result = await this._repository.search(value);
                    this.setState(() {
                      this._addresses = result;
                    });
                  }
                });
              },
            ),
            Expanded(
              child: ListView.separated(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: this._addresses.length,
                itemBuilder: (context, index) {
                  //Get current company
                  Address address = this._addresses[index];
                  //List element
                  return ListTile(
                    title: Text(address.fullAddress),
                    onTap: () {
                      Navigator.of(context).pop(address);
                    },
                  );
                },
                separatorBuilder: (BuildContext context, int index) => Divider(
                  color: Colors.black26,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
