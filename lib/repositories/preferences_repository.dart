import 'package:shared_preferences/shared_preferences.dart';

class PreferencesRepository {
  ///Save elements
  Future<void> save(String key, List<String> elements) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setStringList(key, elements);
  }

  ///Load elements
  Future<List<String>> getElements(String key) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getStringList(key);
  }
}
