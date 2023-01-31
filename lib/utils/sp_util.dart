import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class SPUtil {
  static const version = 'version';
  static const searchResult = 'search_result_device_list';
  static const deviceInfo = 'device_info';
  static const notificationIsOpen = 'notification_is_open';
  static const notiSetMode = 'noti_set_mode';
  static const notiSetDuration = 'noti_set_duration';
  static const notiSetInterval = 'noti_set_interval';
  static const tempListData = 'temp_list_data';
  static const notiRecordType = 'noti_record_type';
  static const notiRecordDate = 'noti_record_date';

  static const newRealHandle = 'new_real_handle';

  static SPUtil? _instance;
  factory SPUtil() => _instance ??= SPUtil._initial();
  SharedPreferences? _preferences;
  SPUtil._initial(){
    init();
  }
  void init() async{
    _preferences ??= await SharedPreferences.getInstance();
  }

  static Future<SPUtil?> perInit() async{
    if(_instance == null){
      SharedPreferences preferences = await SharedPreferences.getInstance();
      _instance = SPUtil._pre(preferences);
    }
    return _instance;
  }
  SPUtil._pre(SharedPreferences prefs){
    _preferences = prefs;
  }

  void setString(key, value){
    _preferences?.setString(key, value);
  }

  void setStringList(key, value){
    _preferences?.setStringList(key, value);
  }

  void setBool(key, value){
    _preferences?.setBool(key, value);
  }

  void setDouble(key, value){
    _preferences?.setDouble(key, value);
  }

  void setInt(key, value){
    _preferences?.setInt(key, value);
  }

  void setJson(key, value){
    value = jsonEncode(value);
    _preferences?.setString(key, value);
  }

  /// 通过泛型获取数据
  T? get<T>(key){
    var result = _preferences?.get(key);
    if(result != null){
      return result as T;
    }
    return null;
  }

  /// 默认false
  bool getBool(key){
    if(get(key) != null){
      return get(key);
    } else {
      return false;
    }
  }

  /// 获取JSON
  Map<String, dynamic>? getJson(key){
    String? result = _preferences?.getString(key);
    if(result != null && result.isNotEmpty){
      return jsonDecode(result);
    }
    return null;
  }
  /// 清空全部
  void clean(){
    _preferences?.clear();
  }

  /// 移除某一个
  void remove(key){
    _preferences?.remove(key);
  }
}