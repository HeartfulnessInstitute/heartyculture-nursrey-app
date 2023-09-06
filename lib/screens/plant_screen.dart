import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hcn_flutter/screens/plant_information.dart';

import '../modules/plant_module.dart';
import '../network/api_service_singelton.dart';
import '../preference_storage/storage_notifier.dart';

class PlantScreen extends StatefulWidget {
  const PlantScreen({super.key, required this.plantId});

  final String plantId;

  @override
  State<PlantScreen> createState() => _PlantScreenState();
}

class _PlantScreenState extends State<PlantScreen> {
  Plants? plants;

  @override
  void initState() {
    super.initState();
    callGetSpecificPlantAPI();
  }

  @override
  Widget build(BuildContext context) {
    Uint8List? bytes;
    if(plants!=null){
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
                          color: Colors.black,
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(20),
                              topLeft: Radius.circular(20))),
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
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700,
                                  )),
                                ),
                                Text(
                                  "(${plants!.name.toString().split('|')[1].trim()})",
                                  style: GoogleFonts.nunito(
                                      textStyle: const TextStyle(
                                    fontSize: 18,
                                    color: Colors.white,
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
                                onPressed: () {},
                                style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all(Colors.white),
                                    padding: MaterialStateProperty.all(
                                        const EdgeInsets.all(20)),
                                    shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(50.0)))),
                                child: Text(
                                  "Add to my plant",
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
                                    backgroundColor:
                                        MaterialStateProperty.all(Colors.white),
                                    padding: MaterialStateProperty.all(
                                        const EdgeInsets.all(20)),
                                    shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
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
                                          PlantInformationScreen(plant:plants!)));
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
            : Center(
                child: CircularProgressIndicator(
                  color: Theme.of(context).primaryColor,
                ),
              ),
      ),
    );
  }

  Future<void> callGetSpecificPlantAPI() async {
    var query =
        "{id, price, list_price, standard_price, name, description, image_256"
        ",vegetation_type,plant_average_life_span,plant_max_height"
        ",x_EconomicImportance,plant_temperature,plant_habit_image,plant_stem_image"
        ",plant_leaf_image,plant_inflorescence_image,plant_flower_image}";
    var cookie = await SessionTokenPreference.getSessionToken();
    var response = await ApiServiceSingleton.instance
        .getSpecificPlant(cookie, query, widget.plantId);
    setState(() {
      plants = response;
    });
  }
}
