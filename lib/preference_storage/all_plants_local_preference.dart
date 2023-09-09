import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../modules/plant_module.dart';


const String ALL_PLANTS_KEY = "ALL_PLANTS_KEY";

class AllPlantStorage {
  static Future<void> setAllPlants(List<Plants> plantsList)async {
    final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    List<Map<String, dynamic>> jsonList = plantsList.map((e) => e.toJson()).toList();
    String jsonString = jsonEncode(jsonList);
    final SharedPreferences prefs = await _prefs;
    prefs
        .setString(ALL_PLANTS_KEY, jsonString)
        .then((bool success) {});
  }

  static Future<List<Plants>> getAllPlants() async {
    final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    final SharedPreferences prefs = await _prefs;
    var jsonString ="";
    if (prefs.getString(ALL_PLANTS_KEY) != null) {
      jsonString = prefs.getString(ALL_PLANTS_KEY)!;
    } else {
      return [];
    }
    List<dynamic> jsonList = jsonDecode(jsonString);
    List<Plants> plantsList = jsonList.map((json) => Plants.fromJson(json)).toList();
    return plantsList;
  }

}