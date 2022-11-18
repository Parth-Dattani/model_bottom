import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHelper {
  SharedPreferences? prefs;

  Future getSharedPreferencesInstance() async {
    prefs = await SharedPreferences.getInstance();
  }

  // store boolean preference data
  Future storeBoolPrefData(String key, bool res) async {
    await prefs!.setBool(key, res);
  }

  // store string preference data
  Future storePrefData(String key, String res) async {
    await prefs?.setString(key, res);
  }

  // store DataList preference data
  Future storePrefDataList(String key, List<String> res) async {
    await prefs!.setStringList(key, res);
  }

  // retrieve string preference data
  Future<String> retrievePrefData(String key) async {
    String str = prefs?.getString(key) ?? '';
    return str;
  }

  // retrieve bool preference data
  Future<bool> retrievePrefBoolData(String key) async {
    return prefs!.getBool(key) ?? false;
  }

  // retrive DataList preference data
  Future<List<String>?> retrievePrefDataList(String key) async {
    return prefs!.getStringList(key);
  }

  // clear all preference data
  Future clearPrefData() async {
    await prefs!.clear();
  }

  Future clearPrefDataByKey(String key) async {
    await prefs!.remove(key);
  }
}

SharedPreferencesHelper sharedPreferencesHelper = SharedPreferencesHelper();
