import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

///sp工具类
///2020年03月28日15:28:30
///xfhy

SpUtil spUtil = SpUtil();

class SpUtil {
  SpUtil._internal();

  static SpUtil _singleton = new SpUtil._internal();

  factory SpUtil() => _singleton;

  // 判断是否存在数据
  Future<bool> hasKey(String key) async {
    Set keys = await getKeys();
    return keys.contains(key);
  }

  ///可能为空
  get(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.get(key);
  }

  Future<String> getString(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var strData = prefs.getString(key);
    return strData == null ? "" : strData;
  }

  Future<bool> putString(String key, String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setString(key, value);
  }

  Future<bool> getBool(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var boolData = prefs.getBool(key);
    return boolData == null ? false : boolData;
  }

  Future<bool> putBool(String key, bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setBool(key, value);
  }

  Future<int> getInt(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var intData = prefs.getInt(key);
    return intData == null ? -1 : intData;
  }

  Future<bool> putInt(String key, int value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setInt(key, value);
  }

  Future<double> getDouble(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var doubleData = prefs.getDouble(key);
    return doubleData == null ? 0.0 : doubleData;
  }

  Future<bool> putDouble(String key, double value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setDouble(key, value);
  }

  Future<List<String>> getStringList(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var list = prefs.getStringList(key);
    return list == null ? [] : list;
  }

  Future<bool> putStringList(String key, List<String> value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.setStringList(key, value);
  }

  dynamic getDynamic(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.get(key);
  }

  Future<bool> remove(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.remove(key);
  }

  Future<bool> clear() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.clear();
  }

  Future<Set> getKeys() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var data = prefs.getKeys();
    return data == null ? [] : data;
  }
}
