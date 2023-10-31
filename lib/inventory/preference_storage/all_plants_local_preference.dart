import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../modules/plant_variants_module.dart';

const String ALL_PLANT_INVENTORY_KEY = "ALL_PLANT_INVENTORY_KEY";
const String ALL_PLANTS_INVENTORY_KEY_DETAILED = "ALL_PLANTS_INVENTORY_KEY_DETAILED";

class AllPlantStorage {
  static Future<void> setAllPlants(List<PlantVariants> plantVariantsList)async {
    final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    List<Map<String, dynamic>> jsonList = plantVariantsList.map((e) => e.toJson()).toList();
    String jsonString = jsonEncode(jsonList);
    final SharedPreferences prefs = await _prefs;
    prefs
        .setString(ALL_PLANT_INVENTORY_KEY, jsonString)
        .then((bool success) {});
  }

  static Future<List<PlantVariants>> getAllPlants() async {
    final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    final SharedPreferences prefs = await _prefs;
    var jsonString ="";
    if (prefs.getString(ALL_PLANT_INVENTORY_KEY) != null) {
      jsonString = prefs.getString(ALL_PLANT_INVENTORY_KEY)!;
    } else {
      return [];
    }
    List<dynamic> jsonList = jsonDecode(jsonString);
    List<PlantVariants> plantVariantsList = jsonList.map((json) => PlantVariants.fromJson(json)).toList();
    return plantVariantsList;
  }
}