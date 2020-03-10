import 'package:flutter/material.dart';

class SearchAdress extends StatelessWidget {
  const SearchAdress({Key key}) : super(key: key);

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
                onTap: () => {
                      //TODO : Search adress geo.api.gouv.fr/adresse
                    })
          ],
        ),
      ),
    );
  }
}
