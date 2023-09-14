import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../modules/plant_module.dart';

const String MY_PLANTS_LIST_KEY = "MY_PLANTS_LIST_KEY";

class MyPlantsPreferenceNotifier extends ChangeNotifier {
  List<Plants> myPlantsList = [];

  MyPlantsPreferenceNotifier() {
    setPlantsList();
  }

  Future<void> setPlantsList() async {
    myPlantsList = await getMyPlantsList();
    notifyListeners();
  }

  Future<List<Plants>> getMyPlantsList() async {
    final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    final SharedPreferences prefs = await _prefs;
    var jsonString ="";
    if (prefs.getString(MY_PLANTS_LIST_KEY) != null) {
      jsonString = prefs.getString(MY_PLANTS_LIST_KEY)!;
    } else {
      return [];
    }
    List<dynamic> jsonList = jsonDecode(jsonString);
    List<Plants> plantsList = jsonList.map((json) => Plants.fromJson(json)).toList();
    return plantsList;
  }

  Future<void> setAllPlants(List<Plants> plantsList)async {
    final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    List<Map<String, dynamic>> jsonList = plantsList.map((e) => e.toJson()).toList();
    String jsonString = jsonEncode(jsonList);
    final SharedPreferences prefs = await _prefs;
    prefs
        .setString(MY_PLANTS_LIST_KEY, jsonString)
        .then((bool success) {});
    setPlantsList();
  }

  Future<void> addPlantsToList(Plants plant) async {
    var list = await getMyPlantsList();
    list.add(plant);
    setAllPlants(list);
  }

  Future<void> removePlantFromList(Plants plant) async {
    var list = await getMyPlantsList();
    list.removeWhere((element)=>element.id == plant.id);
    setAllPlants(list);
  }

}
