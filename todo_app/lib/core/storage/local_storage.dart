import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  final SharedPreferences _prefs;
  LocalStorage(this._prefs);

  static Future<LocalStorage> getInstance() async {
    final prefs = await SharedPreferences.getInstance();
    return LocalStorage(prefs);
  }

  Future<void> writeString(String key, String value) async{
    await _prefs.setString(key, value);
  }

  String? readString(String key) {
    return _prefs.getString(key);
  }

  Future<void> remove(String key) async {
    _prefs.remove(key);
  }

  Future<void> writeJson(String key, Object value) async {
    final jsonstr = jsonEncode(value);
    await writeJson(key, jsonstr);
  }

  dynamic readJson(String key) {
    final jsonStr = readString(key);
    if(jsonStr == null) return null;
    return jsonDecode(jsonStr);
  }

}