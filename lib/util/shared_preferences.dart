import 'package:shared_preferences/shared_preferences.dart';

///sp工具类
///2020年03月28日15:28:30
///xfhy

class SpUtil {
  static SpUtil _instance;
  static SharedPreferences _spf;

  //构造方法也私有化
  SpUtil._();

  static Future<SpUtil> get instance async {
    return await getInstance();
  }

  Future _init() async {
    _spf = await SharedPreferences.getInstance();
  }

  static Future<SpUtil> getInstance() async {
    if (instance == null) {
      _instance = SpUtil._();
    }
    if (_spf == null) {
      await _instance._init();
    }
    return _instance;
  }

  static bool _beforeCheck() {
    if (_spf == null) {
      _instance._init();
      return true;
    }
    return false;
  }


  // 判断是否存在数据
  bool hasKey(String key) {
    Set keys = getKeys();
    return keys.contains(key);
  }

  Set<String> getKeys() {
    if (_beforeCheck()) return null;
    return _spf.getKeys();
  }

  get(String key) {
    if (_beforeCheck()) return null;
    return _spf.get(key);
  }

  getString(String key) {
    if (_beforeCheck()) return null;
    return _spf.getString(key);
  }

  Future<bool> putString(String key, String value) async {
    if (_beforeCheck()) return null;
    return await _spf.setString(key, value);
  }

  bool getBool(String key) {
    if (_beforeCheck()) return null;
    return _spf.getBool(key);
  }

  Future<bool> putBool(String key, bool value) async {
    if (_beforeCheck()) return null;
    return await _spf.setBool(key, value);
  }

  int getInt(String key) {
    if (_beforeCheck()) return null;
    return _spf.getInt(key);
  }

  Future<bool> putInt(String key, int value) async {
    if (_beforeCheck()) return null;
    return await _spf.setInt(key, value);
  }

  double getDouble(String key) {
    if (_beforeCheck()) return null;
    return _spf.getDouble(key);
  }

  Future<bool> putDouble(String key, double value) async {
    if (_beforeCheck()) return null;
    return await _spf.setDouble(key, value);
  }

  List<String> getStringList(String key) {
    return _spf.getStringList(key);
  }

  Future<bool> putStringList(String key, List<String> value) async {
    if (_beforeCheck()) return null;
    return await _spf.setStringList(key, value);
  }

  dynamic getDynamic(String key) {
    if (_beforeCheck()) return null;
    return _spf.get(key);
  }

  Future<bool> remove(String key) {
    if (_beforeCheck()) return null;
    return _spf.remove(key);
  }

  Future<bool> clear() {
    if (_beforeCheck()) return null;
    return _spf.clear();
  }
}
