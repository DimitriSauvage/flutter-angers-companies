import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hello_world/models/address.dart';
import 'package:hello_world/repositories/adress_repository.dart';
import 'package:latlong/latlong.dart';

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
                    Timer(const Duration(milliseconds: 400), () async {
                  if (value.trim().isNotEmpty) {
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
