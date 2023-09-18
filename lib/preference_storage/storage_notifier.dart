import 'package:shared_preferences/shared_preferences.dart';


const String SESSION_TOKEN = "SESSION_TOKEN";

class SessionTokenPreference {
  static Future<void> setSessionToken(String sessionToken)async {
    final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    final SharedPreferences prefs = await _prefs;
    prefs
        .setString(SESSION_TOKEN, sessionToken)
        .then((bool success) {});
  }

  static Future<String> getSessionToken() async {
    final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    final SharedPreferences prefs = await _prefs;
    if (prefs.getString(SESSION_TOKEN) != null) {
      return prefs.getString(SESSION_TOKEN)!;
    } else {
      return "";
    }
  }

}