import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class SharedPrefs {
  static SharedPreferences? _prefs;

  static const String _tokenKey = "auth_token";
  static const String _userKey = "user_data";

  static Future<void> init() async {
    _prefs ??= await SharedPreferences.getInstance();
  }

  static Future<bool> setToken(String token) async {
    if (_prefs == null) await init();
    return await _prefs!.setString(_tokenKey, token);
  }

  static String? getToken() {
    return _prefs?.getString(_tokenKey);
  }

  static Future<bool> setUser(Map<String, dynamic> user) async {
    if (_prefs == null) await init();
    return await _prefs!.setString(_userKey, jsonEncode(user));
  }

  static Map<String, dynamic>? getUser() {
    final String? userStr = _prefs?.getString(_userKey);
    if (userStr == null) return null;
    return jsonDecode(userStr);
  }

  static Future<bool> removeToken() async {
    if (_prefs == null) await init();
    return await _prefs!.remove(_tokenKey);
  }

  static Future<bool> clear() async {
    if (_prefs == null) await init();
    return await _prefs!.clear();
  }
  
  static bool isLoggedIn() {
    return getToken() != null;
  }
}
