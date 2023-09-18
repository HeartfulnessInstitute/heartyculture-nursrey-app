import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../main.dart';
import '../modules/notification_module.dart';

const String NOTIFICATION_KEY = "NOTIFICATION_KEY";

class NotificationNotifier extends ChangeNotifier {
  List<NotificationModule> notificationList = [];

  NotificationNotifier() {
    setNotificationList();
  }

  Future<void> setNotificationList() async {
    notificationList = await NotificationPreferenceHelper.getNotificationList();
    notifyListeners();
  }
}

class NotificationPreferenceHelper {


  static Future<List<NotificationModule>> getNotificationList() async {
    final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    final SharedPreferences prefs = await _prefs;
    var jsonString ="";
    if (prefs.getString(NOTIFICATION_KEY) != null) {
      jsonString = prefs.getString(NOTIFICATION_KEY)!;
    } else {
      return [];
    }
    List<dynamic> jsonList = jsonDecode(jsonString);
    List<NotificationModule> notificationList = jsonList.map((json) => NotificationModule.fromJson(json)).toList();
    return notificationList;
  }

  static Future<void> setAllPlants(List<NotificationModule> notificationListParam)async {
    final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    List<Map<String, dynamic>> jsonList = notificationListParam.map((e) => e.toJson()).toList();
    String jsonString = jsonEncode(jsonList);
    final SharedPreferences prefs = await _prefs;
    prefs
        .setString(NOTIFICATION_KEY, jsonString)
        .then((bool success) {});
    var context = MyApp.navigatorKey.currentContext;
    if(context!=null){
      var notificationProvider = Provider.of<NotificationNotifier>(context, listen: false);
      notificationProvider.setNotificationList();
    }
  }

  static Future<void> addNotificationToList(NotificationModule notificationModule) async {
    var list = await getNotificationList();
    list.add(notificationModule);
    setAllPlants(list);
  }

  static Future<void> removePlantFromList(NotificationModule notificationModule) async {
    var list = await getNotificationList();
    list.removeWhere((element)=>element.id == notificationModule.id);
    setAllPlants(list);
  }

  static Future<void> clearAllNotification() async {
    final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    var prefs= await _prefs;
    prefs.remove(NOTIFICATION_KEY);
    setAllPlants([]);
  }
}
