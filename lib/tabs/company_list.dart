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

  ///Edit a company
  Future<void> editCompany(Company company) async {
    Company editedCompany = await Navigator.of(context)
            .pushNamed(Routes.editCompany, arguments: {"company": company})
        as Company;
    if (editedCompany != null) this._companyStore.save(editedCompany);
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

              return Dismissible(
                background: Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.only(left: 20.0),
                  color: Colors.orangeAccent,
                  child: Icon(Icons.edit, color: Colors.white),
                ),
                secondaryBackground: Container(
                  alignment: Alignment.centerRight,
                  padding: EdgeInsets.only(right: 20.0),
                  color: Colors.redAccent,
                  child: Icon(Icons.delete, color: Colors.white),
                ),
                key: Key(company.id),
                confirmDismiss: (direction) async {
                  bool dismiss = false;
                  if (direction == DismissDirection.startToEnd) {
                    //Edition
                    this.editCompany(company);
                  } else {
                    //Remove
                    await this._companyStore.remove(company);
                    dismiss = true;
                    // Show a snackbar. This snackbar could also contain "Undo" actions.
                    Scaffold.of(context).showSnackBar(
                        SnackBar(content: Text("${company.name} supprimé")));
                  }
                  return dismiss;
                },
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 5),
                  child: ListTile(
                      leading: Icon(Icons.business), //Building icon to the left
                      trailing: Icon(
                        Icons.keyboard_arrow_right,
                        size: 35,
                      ), //Right arrow icon to the left
                      title: Text(company?.name),
                      onTap: () async {
                        this.editCompany(company);
                      }),
                ),
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              Widget result = Container();
              if (index >= 0) {
                result = Container(
                    decoration: BoxDecoration(
                        border: Border(
                  top: BorderSide(color: Colors.grey, width: 0.3),
                )));
              }
              return result;
            },
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
