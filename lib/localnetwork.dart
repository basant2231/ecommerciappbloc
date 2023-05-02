import 'package:shared_preferences/shared_preferences.dart';

class CacheNetwork {
  static late SharedPreferences sharedprefs;
  
  static Future cacheInitialization() async {
    sharedprefs = await SharedPreferences.getInstance();
  }

// set, get, delete, and clear cache methods
 static Future<bool> insertToCache(
      {required String key, required String value}) async {
    return await sharedprefs.setString(key, value);
  }

  static String getcacheDate({required String key}) {
    return sharedprefs.getString(key) ?? '';
  }
 static Future<bool> deletecacheItem({required String key})async{
    return await sharedprefs.remove(key);
  }
}
