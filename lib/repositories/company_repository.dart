import 'package:hello_world/models/company.dart';
import 'package:hello_world/repositories/preferences_repository.dart';

class CompanyRepository {
  String _companiesKey = "companies";
  PreferencesRepository _preferencesRepository = PreferencesRepository();

  ///Save the companies
  Future<void> saveCompanies(List<Company> companies) async {
    await this
        ._preferencesRepository
        .save(this._companiesKey, companies.map((x) => x.toJson()).toList());
  }

  ///Load the companies
  Future<List<Company>> getAll() async {
    List<String> elements =
        await this._preferencesRepository.getElements(this._companiesKey);

    return elements.map((x) => Company.fromJson(x)).toList();
  }
}
