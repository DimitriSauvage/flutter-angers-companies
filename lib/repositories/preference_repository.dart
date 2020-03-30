import 'package:hello_world/models/company.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PreferenceRepository {
  String _companiesKey = "companies";

  ///Save the companies
  Future<void> saveCompanies(List<Company> companies) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setStringList(
        this._companiesKey, companies.map((x) => x.toJson()).toList());
  }

  ///Load the companies
  Future<List<Company>> loadCompanies() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    List<String> companyStrings =
        sharedPreferences.getStringList(this._companiesKey);

    return companyStrings.map((x) => Company.fromJson(x)).toList();
  }
}
