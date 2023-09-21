import 'dart:ffi';

import 'package:shared_preferences/shared_preferences.dart';


const String FERTILIZER_NOTIFICATION = "FERTILIZER_NOTIFICATION";

class FertilizerPreference {
  static Future<void> setFertlizerNotificationSent(bool sent)async {
    final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    final SharedPreferences prefs = await _prefs;
    prefs
        .setBool(FERTILIZER_NOTIFICATION, sent)
        .then((bool success) {});
  }

  static Future<bool> getFertlizerNotificationSent() async {
    final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    final SharedPreferences prefs = await _prefs;
    if (prefs.getBool(FERTILIZER_NOTIFICATION) != null) {
      return prefs.getBool(FERTILIZER_NOTIFICATION)!;
    } else {
      return false;
    }
  }
}