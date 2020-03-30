import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hello_world/models/address.dart';
import 'package:hello_world/models/company.dart';

import '../routes.dart';

class EditCompany extends StatelessWidget {
  //Controller for the fields
  final TextEditingController _nameEditingController = TextEditingController();
  final TextEditingController _addressEditingController =
      TextEditingController();
  Company _company;
  final GlobalKey<FormState> _formValidationKey = GlobalKey<FormState>();
  //Screen title
  String _title;

  ///Reset the current company
  void _resetCompany() {
    this._company = Company(name: '');
    this._nameEditingController.text = "";
    this._addressEditingController.text = "";
    this._title = "Ajouter une entreprise";
  }

  @override
  Widget build(BuildContext context) {
    //Get the company to edit
    final Map<String, dynamic> args = ModalRoute.of(context).settings.arguments;
    if (args == null) {
      //Add a new company
      this._resetCompany();
    } else {
      //Edit company
      Company editedCompany = args['company'] as Company;

      if (editedCompany != null) {
        //If it is a new company
        if (this._company == null || (this._company.id != editedCompany.id)) {
          this._company = editedCompany;
          this._nameEditingController.text = this._company.name;
          this._addressEditingController.text = this._company.address != null
              ? this._company.address.fullAddress
              : "";

          this._title = "Édition de " + this._company.name;
        }
      } else {
        this._resetCompany();
      }
      //Check if it is a new company

    }
    return Scaffold(
      appBar: AppBar(
        title: Text(this._title),
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
                    ? "Merci de renseigner le nom de l'entreprise"
                    : null,
                autofocus: true,
                decoration: InputDecoration(
                    labelText: "Nom de l'entreprise*",
                    icon: Icon(Icons.business)),
              ),
              TextFormField(
                  controller: this._addressEditingController,
                  decoration: InputDecoration(
                      labelText: "Adresse de l'entreprise",
                      icon: Icon(Icons.business)),
                  readOnly: true,
                  onTap: () async {
                    Address address = await Navigator.of(context)
                        .pushNamed(Routes.searchAdress) as Address;
                    if (address != null) {
                      this._company.address = address;
                      this._addressEditingController.text =
                          this._company.address.fullAddress;
                    }
                  }),
              RaisedButton(
                  onPressed: () {
                    if (this._formValidationKey.currentState.validate()) {
                      Navigator.of(context).pop(this._company);
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
