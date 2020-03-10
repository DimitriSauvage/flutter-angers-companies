import 'package:flutter/material.dart';
import 'package:hello_world/models/company.dart';

import '../routes.dart';

class CompanyList extends StatefulWidget {
  @override
  _CompanyListState createState() => _CompanyListState();
}

class _CompanyListState extends State<CompanyList> {
  List<Company> _companies = [
    Company(name: "Delivagri"),
    Company(name: "CNP"),
    Company(name: "ESPL"),
    Company(name: "Orkeis")
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Liste des entreprises"),
      ),
      body: Container(
        child: ListView.separated(
          itemCount: this._companies.length,
          itemBuilder: (context, index) {
            //Get current company
            Company company = this._companies[index];

            //List element
            return ListTile(
              leading: Icon(Icons.business), //Building icon to the left
              trailing: Icon(
                Icons.keyboard_arrow_right,
                size: 35,
              ), //Right arrow icon to the left
              // subtitle: Text(
              //     "${company?.street != null ? company.street + ',' : ''} ${company?.zipCode ?? ''} ${company?.city ?? ''}"),
              title: Text(company.name),
              onTap: () async {
                Company editedCompany = await Navigator.of(context).pushNamed(
                    Routes.addCompany,
                    arguments: {"company": company}) as Company;
                if (editedCompany != null)
                  this._companies[index] = editedCompany;
              },
              onLongPress: () {
                this.setState(() {
                  this._companies.remove(company);
                });
              },
            );
          },
          separatorBuilder: (BuildContext context, int index) => Divider(
            color: Colors.black26,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          Company company = await Navigator.of(context)
              .pushNamed(Routes.addCompany) as Company;
          if (company != null) {
            this.setState(() => this._companies.add(company));
          }
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
