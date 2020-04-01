import 'package:hello_world/models/company.dart';
import 'package:hello_world/repositories/company_repository.dart';
import 'package:mobx/mobx.dart';

part 'company_store.g.dart';

class CompanyStore = _CompanyStore with _$CompanyStore;

abstract class _CompanyStore with Store {
  //Fields
  ///Company manager
  final CompanyRepository _companyRepository;

  ///Companies to manage
  @observable
  ObservableList<Company> companies = ObservableList<Company>();

  //Constructor
  _CompanyStore(this._companyRepository);

  //Private methods
  ///Get a new list of companies
  List<Company> _getClone() {
    return List<Company>.from(this.companies);
  }

  ///Replace all elements in the list with the new list
  void _replaceAll(List<Company> newCompanies) {
    this.companies.clear();
    this.companies.addAll(newCompanies);
  }

  //Methods
  ///Add a new company
  @action
  Future<void> save(Company company) async {
    List<Company> clonedList = this._getClone();

    //Get element index
    int index = clonedList.indexWhere((x) => x.id == company.id);

    if (index >= 0) {
      //ELement exist, replace it
      clonedList[index] = company;
    } else {
      clonedList.add(company);
    }
    try {
      //Add in DB
      await this._companyRepository.saveCompanies(clonedList);
      this._replaceAll(clonedList);
    } catch (e) {
      print("Error while saving in DB");
    }
  }

  ///Remove a company
  Future<void> remove(Company company) async {
    List<Company> cloned = this._getClone();
    //Check if the company is present
    int index = cloned.indexWhere((x) => x.id == company.id);
    if (index >= 0) {
      cloned.removeAt(index);
      //Save changes
      await this._companyRepository.saveCompanies(cloned);
      this._replaceAll(cloned);
    }
  }

  ///Load the companies
  @action
  Future<void> load() async {
    this._replaceAll(await this._companyRepository.getAll());
  }
}
