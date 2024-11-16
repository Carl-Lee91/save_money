import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

late SharedPreferences prefs;
late FlutterSecureStorage secureStorage;

class PublicMethod {
  static Future<void> preferenceinit() async {
    WidgetsFlutterBinding.ensureInitialized();
    prefs = await SharedPreferences.getInstance();
  }

  static void secureStorageInit() {
    WidgetsFlutterBinding.ensureInitialized();
    secureStorage = const FlutterSecureStorage();
  }
}
