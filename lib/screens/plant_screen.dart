import 'dart:convert';
import 'dart:developer';
import 'dart:typed_data';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../notofications/notification_controller.dart';
import 'plant_information.dart';
import 'package:provider/provider.dart';

import '../constants.dart';
import '../modules/plant_module.dart';
import '../modules/session_module.dart';
import '../network/api_service_singelton.dart';
import '../preference_storage/my_plants_preference_notifier.dart';
import '../preference_storage/storage_notifier.dart';

class PlantScreen extends StatefulWidget {
  const PlantScreen({super.key, required this.plantId});

  final String plantId;

  @override
  State<PlantScreen> createState() => _PlantScreenState();
}

class _PlantScreenState extends State<PlantScreen> {
  Plants? plants;
  bool isErrorInAPI = false;
  List<Plants>myPlantsList = [];
  Plants? plantPresent;

  @override
  void initState() {
    super.initState();
    callGetSpecificPlantAPI();
  }

  @override
  Widget build(BuildContext context) {
    Uint8List? bytes;
    if(plants!=null){
      myPlantsList =Provider.of<MyPlantsPreferenceNotifier>(context, listen: true).myPlantsList;
      plantPresent = myPlantsList.firstWhereOrNull((element)=>element.id==plants!.id);
      if(plants?.image256 is String && plants?.image256.isNotEmpty) {
        bytes = base64.decode(plants?.image256);
      }
    }
    return Scaffold(
      body: SafeArea(
        child: plants != null
            ? Stack(
                children: [
                  bytes == null
                      ? Image.network(
                          'https://www.ugaoo.com/cdn/shop/products/ajwain-plant-32220864446596.jpg',
                          width: double.infinity,
                          height: MediaQuery.of(context).size.height / 2,
                          fit: BoxFit.cover,
                        )
                      : Image.memory(
                          bytes,
                          width: double.infinity,
                          height: MediaQuery.of(context).size.height / 2,
                          fit: BoxFit.cover,
                        ),
                  Positioned(
                    top: 0,
                    left: 0,
                    child: Container(
                      margin: const EdgeInsets.only(top: 5),
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        style: ElevatedButton.styleFrom(
                          shape: const CircleBorder(),
                          padding: const EdgeInsets.all(8),
                          backgroundColor: Colors.black.withOpacity(.5),
                          // <-- Button color
                          foregroundColor: Colors.white, // <-- Splash color
                        ),
                        child: Icon(
                          Icons.adaptive.arrow_back,
                          color: Colors.white,
                          size: 24,
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      decoration: const BoxDecoration(
                          color: Colors.white),
                      height: MediaQuery.of(context).size.height / 2,
                      width: double.infinity,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(top: 10, bottom: 10),
                            child: Column(
                              children: [
                                Text(
                                  plants!.name.toString().split('|')[0].trim(),
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.nunito(
                                      textStyle: const TextStyle(
                                    fontSize: 32,
                                    color: Color(0xff212121),
                                    fontWeight: FontWeight.w700,
                                  )),
                                ),
                                Text(
                                  "(${plants!.name.toString().split('|')[1].trim()})",
                                  style: GoogleFonts.nunito(
                                      textStyle: const TextStyle(
                                    fontSize: 18,
                                    color: Color(0xff212121),
                                    fontWeight: FontWeight.w400,
                                  )),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: double.infinity,
                            margin: const EdgeInsets.only(left: 25, right: 25),
                            child: ElevatedButton(
                                onPressed: () async {
                                  if(plantPresent!=null){
                                    Provider.of<MyPlantsPreferenceNotifier>(context, listen: false).removePlantFromList(plants!);
                                    NotificationController.stopNotifications(plants!);
                                  }else{
                                    Provider.of<MyPlantsPreferenceNotifier>(context, listen: false).addPlantsToList(plants!);
                                    NotificationController.createNewNotification(plants!);
                                  }
                                },
                                style: ButtonStyle(
                                    overlayColor: MaterialStateProperty.all(Theme.of(context).primaryColor.withOpacity(.2)),
                                    elevation: MaterialStateProperty.all(0),
                                    backgroundColor:
                                        MaterialStateProperty.all(Colors.white),
                                    padding: MaterialStateProperty.all(
                                        const EdgeInsets.all(20)),
                                    shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                            side: BorderSide(color: Theme.of(context).primaryColor,width: 2),
                                            borderRadius:
                                                BorderRadius.circular(50.0)))),
                                child: Text(
                                  plantPresent!=null?"Remove from my plants":"Add to my plant",
                                  style: GoogleFonts.nunito(
                                      textStyle: TextStyle(
                                    fontSize: 18,
                                    color: Theme.of(context).primaryColor,
                                    fontWeight: FontWeight.w700,
                                  )),
                                )),
                          ),
                          Container(
                            width: double.infinity,
                            margin: const EdgeInsets.only(left: 25, right: 25),
                            child: ElevatedButton(
                                onPressed: () {},
                                style: ButtonStyle(
                                    elevation: MaterialStateProperty.all(0),
                                    backgroundColor:
                                        MaterialStateProperty.all(Colors.white),
                                    padding: MaterialStateProperty.all(
                                        const EdgeInsets.all(20)),
                                    shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                            side: BorderSide(color: Theme.of(context).primaryColor,width: 2),
                                            borderRadius:
                                                BorderRadius.circular(50.0)))),
                                child: Text(
                                  "Buy now",
                                  style: GoogleFonts.nunito(
                                      textStyle: TextStyle(
                                    fontSize: 18,
                                    color: Theme.of(context).primaryColor,
                                    fontWeight: FontWeight.w700,
                                  )),
                                )),
                          ),
                          Container(
                            width: double.infinity,
                            margin: const EdgeInsets.only(left: 25, right: 25),
                            child: ElevatedButton(
                                onPressed: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) =>
                                          PlantInformationScreen(
                                              plant: plants!)));
                                },
                                style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(
                                      Theme.of(context).primaryColor,
                                    ),
                                    padding: MaterialStateProperty.all(
                                        const EdgeInsets.all(20)),
                                    shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(50.0)))),
                                child: Text(
                                  "More Information",
                                  style: GoogleFonts.nunito(
                                      textStyle: const TextStyle(
                                    fontSize: 18,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700,
                                  )),
                                )),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              )
            : isErrorInAPI
                ? const Center(child: Text("Error"))
                : Center(
                    child: CircularProgressIndicator(
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
      ),
    );
  }

  Future<void> callGetSpecificPlantAPI() async {
    var cookie = await SessionTokenPreference.getSessionToken();
    if(cookie.isEmpty){
       callCookieAPI();
    }else{
      specificPlantAPI(cookie);
    }
  }

  void specificPlantAPI(String cookie) async {
    try{
      var query =
          "{id, price, list_price, standard_price, name, description, image_256"
          ",vegetation_type,plant_average_life_span,plant_max_height"
          ",plant_temperature,plant_habit_image,plant_stem_image"
          ",plant_leaf_image,plant_inflorescence_image,plant_flower_image}";
      var response = await ApiServiceSingleton.instance
          .getSpecificPlant(cookie, query, widget.plantId);
      if(response.response.statusCode == 200){
        setState(() {
          plants = response.data;
        });
      }else{
        setState(() {
          isErrorInAPI = true;
        });
      }
    } catch (e){
      setState(() {
        isErrorInAPI = true;
      });
      log("error:$e");
    }  }

  void callCookieAPI() {
    try {
      SessionModule sessionModule = SessionModule();
      Params params = Params();
      params.db = Constants.db;
      params.login =  Constants.login;
      params.password = Constants.password;
      sessionModule.params = params;
      ApiServiceSingleton.instance
          .getSessionCookie(sessionModule)
          .then((response) {
        final cookies = response.response.headers['set-cookie'];
        List<String>? parts = cookies?[0].split(';');
        String? sessionId = parts?[0].trim();
        if (sessionId != null) {
          SessionTokenPreference.setSessionToken(sessionId)
              .then((value) {
               specificPlantAPI(sessionId);
          });
        }
      });
    } catch (e) {
      //error
    }
  }
}
