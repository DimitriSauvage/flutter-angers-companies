import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hello_world/models/company.dart';

import '../routes.dart';

class AddCompany extends StatelessWidget {
  //Controller for the fields
  final TextEditingController _nameEditingController = TextEditingController();
  final GlobalKey<FormState> _formValidationKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    //Get the company to edit
    final Map<String, dynamic> args = ModalRoute.of(context).settings.arguments;
    if (args != null && args.containsKey("company")) {
      Company company = args['company'] as Company;
      this._nameEditingController.text = company.name;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Ajouter une entreprise"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: Form(
          key: this._formValidationKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                controller: this._nameEditingController,
                validator: (value) => value == null || value.isEmpty
                    ? "Merci de renseigner le nom de l'entrepris"
                    : null,
                autofocus: true,
                decoration: InputDecoration(
                    labelText: "Nom de l'entreprise*",
                    icon: Icon(Icons.business)),
              ),
              TextFormField(
                decoration: InputDecoration(
                    labelText: "Adresse de l'entreprise",
                    icon: Icon(Icons.business)),
                readOnly: true,
                onTap: () =>
                    Navigator.of(context).pushNamed(Routes.searchAdress),
              ),
              RaisedButton(
                  onPressed: () {
                    if (this._formValidationKey.currentState.validate()) {
                      Navigator.of(context)
                          .pop(Company(name: this._nameEditingController.text));
                    }
                  },
                  child: Text("Valider"))
            ],
          ),
        ),
      ),
    );
  }
}
