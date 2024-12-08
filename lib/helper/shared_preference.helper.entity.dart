import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceHelper {
  static SharedPreferences? _preferences;

  /// Initialize SharedPreferences instance
  static Future<void> init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  /// Save a String value
  static Future<void> setString(String key, String value) async {
    await _preferences?.setString(key, value);
  }

  /// Get a String value
  static String getString(String key, {String defaultValue = ''}) {
    return _preferences?.getString(key) ?? defaultValue;
  }

  /// Save an integer value
  static Future<void> setInt(String key, int value) async {
    await _preferences?.setInt(key, value);
  }

  /// Get an integer value
  static int getInt(String key, {int defaultValue = 0}) {
    return _preferences?.getInt(key) ?? defaultValue;
  }

  /// Save a boolean value
  static Future<void> setBool(String key, bool value) async {
    await _preferences?.setBool(key, value);
  }

  /// Get a boolean value
  static bool getBool(String key, {bool defaultValue = false}) {
    return _preferences?.getBool(key) ?? defaultValue;
  }

  /// Save a double value
  static Future<void> setDouble(String key, double value) async {
    await _preferences?.setDouble(key, value);
  }

  /// Get a double value
  static double getDouble(String key, {double defaultValue = 0.0}) {
    return _preferences?.getDouble(key) ?? defaultValue;
  }

  /// Save a list of Strings
  static Future<void> setStringList(String key, List<String> value) async {
    await _preferences?.setStringList(key, value);
  }

  /// Get a list of Strings
  static List<String> getStringList(String key, {List<String> defaultValue = const []}) {
    return _preferences?.getStringList(key) ?? defaultValue;
  }

  /// Remove a specific key
  static Future<void> remove(String key) async {
    await _preferences?.remove(key);
  }

  /// Clear all preferences
  static Future<void> clear() async {
    await _preferences?.clear();
  }
}
