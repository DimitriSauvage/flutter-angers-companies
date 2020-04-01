import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:hello_world/models/company.dart';
import 'package:hello_world/stores/company_store.dart';
import 'package:provider/provider.dart';

import '../routes.dart';

class CompanyList extends StatefulWidget {
  @override
  _CompanyListState createState() => _CompanyListState();
}

class _CompanyListState extends State<CompanyList> {
  //Fields
  CompanyStore _companyStore;

  //Get the store
  @override
  void didChangeDependencies() {
    this._companyStore = Provider.of<CompanyStore>(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Liste des entreprises"),
      ),
      body: Container(
        child: Observer(
          builder: (contect) => ListView.separated(
            itemCount: this._companyStore.companies.length,
            itemBuilder: (context, index) {
              //Get current company
              Company company = this._companyStore.companies[index];

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
                  if (editedCompany != null) this._companyStore.save(editedCompany);
                },
                onLongPress: () {
                  this._companyStore.remove(company);
                },
              );
            },
            separatorBuilder: (BuildContext context, int index) => Divider(
              color: Colors.black26,
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          Company company = await Navigator.of(context)
              .pushNamed(Routes.editCompany) as Company;
          if (company != null) {
            this._companyStore.save(company);
          }
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
