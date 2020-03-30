import 'package:flutter/material.dart';
import 'package:hello_world/models/company.dart';

import '../routes.dart';

typedef void OnSave(Company company);
typedef void OnRemove(Company company);

class CompanyList extends StatelessWidget {
  //Fields
  List<Company> companies;
  OnSave onSave;
  OnRemove onRemove;

  //Constructor
  CompanyList(
      {@required this.companies,
      @required this.onSave,
      @required this.onRemove});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Liste des entreprises"),
      ),
      body: Container(
        child: ListView.separated(
          itemCount: this.companies.length,
          itemBuilder: (context, index) {
            //Get current company
            Company company = this.companies[index];

            //List element
            return ListTile(
              leading: Icon(Icons.business), //Building icon to the left
              trailing: Icon(
                Icons.keyboard_arrow_right,
                size: 35,
              ), //Right arrow icon to the left
              // subtitle: Text(
              //     "${company?.street != null ? company.street + ',' : ''} ${company?.zipCode ?? ''} ${company?.city ?? ''}"),
              title: Text(company?.name),
              onTap: () async {
                Company editedCompany = await Navigator.of(context).pushNamed(
                    Routes.editCompany,
                    arguments: {"company": company}) as Company;
                if (editedCompany != null) this.onSave(editedCompany);
              },
              onLongPress: () {
                this.onRemove(company);
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
              .pushNamed(Routes.editCompany) as Company;
          if (company != null) {
            this.onSave(company);
          }
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
