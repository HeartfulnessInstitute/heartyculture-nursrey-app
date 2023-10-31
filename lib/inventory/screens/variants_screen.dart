import 'dart:developer';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hcn_flutter/inventory/modules/plant_variants_module.dart';
import 'package:hcn_flutter/inventory/screens/variants_location_screen.dart';
import 'package:provider/provider.dart';

import '../../constants.dart';
import '../../modules/session_module.dart';
import '../../preference_storage/my_plants_preference_notifier.dart';
import '../../preference_storage/storage_notifier.dart';
import '../network/api_service_inventory_singelton.dart';

class VariantsScreen extends StatefulWidget {
  const VariantsScreen(
      {super.key,
      required this.plantId,
      this.plantVariantsNumber,
      this.plantUrl,
      this.plantVariantsValueId});

  final String plantId;
  final int? plantVariantsNumber;
  final String? plantUrl;
  final List<ValueIds>? plantVariantsValueId;

  // final <AttributeLineIds>? specificPlantVariants;

  @override
  State<VariantsScreen> createState() => _VariantsScreenState();
}

class _VariantsScreenState extends State<VariantsScreen> {
  PlantVariants? plantVariants;
  bool isErrorInAPI = false;
  List<PlantVariants> myPlantsVariantsList = [];
  PlantVariants? plantPresent;
  List<PlantVariants> categorisedPlantVariantsList = [];

  List<ValueIds>? plantVariantsValueList;

  late Map<String, String> headersMap;

  @override
  void initState() {
    super.initState();
    callGetSpecificPlantAPI();
    SessionTokenPreference.getSessionToken().then((value) {
      setState(() {
        headersMap = {'Cookie': value};
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (plantVariants != null) {
      myPlantsVariantsList =
          Provider.of<MyPlantsPreferenceNotifier>(context, listen: true)
              .myPlantsList
              .cast<PlantVariants>();

      plantVariantsValueList = widget.plantVariantsValueId!;

      plantPresent = myPlantsVariantsList
          .firstWhereOrNull((element) => element.id == plantVariants!.id);
    }
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Theme.of(context).primaryColor,
        leadingWidth: 30,
        leading: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        title: Text('Variants'),
      ),
      body: plantVariants != null
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 10, left: 25),
                  child: Text(
                    // plantVariantsValueList![1].name!,
                    plantVariants!.name.toString().split('|')[0].trim(),
                    // sp[1][0],
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: GoogleFonts.nunito(
                        textStyle: TextStyle(
                      fontSize: 30,
                      color: Color(0xff212121),
                      fontWeight: FontWeight.w500,
                    )),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 10, left: 25),
                  child: Text(
                    '(' +
                        plantVariants!.name.toString().split('|')[1].trim() +
                        ')',
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: GoogleFonts.nunito(
                        textStyle: TextStyle(
                      fontSize: MediaQuery.of(context).size.height * .015,
                      color: Color(0xff757575),
                      fontWeight: FontWeight.w500,
                    )),
                  ),
                ),

                Expanded(
                  child: ListView.builder(
                      itemCount: plantVariantsValueList!.length,
                      itemBuilder: (context, index) {
                        return listChild2(index);
                      }),
                ),
                // Visibility(
                //   visible: categorisedPlantsList.length==0,
                //   child: Container(
                //     // color: Colors.black.withOpacity(.75),
                //     width: double.infinity,
                //     height: double.infinity,
                //     child: Center(
                //       child: CircularProgressIndicator(
                //         color: Theme.of(context).primaryColor,
                //       ),
                //     ),
                //   ),
                // )
              ],
            )
          : isErrorInAPI
              ? const Center(child: Text("Something went wrong!"))
              : Center(
                  child: CircularProgressIndicator(
                    color: Theme.of(context).primaryColor,
                  ),
                ),
    );
  }

  Future<void> callGetSpecificPlantAPI() async {
    var cookie = await SessionTokenPreference.getSessionToken();
    if (cookie.isEmpty) {
      callCookieAPI();
    } else {
      specificPlantAPI(cookie);
    }
  }

  void specificPlantAPI(String cookie) async {
    try {
      var query =
          "{id, name,vegetation_type, origin, x_CanopyType,x_Waterfrequency, x_EconomicValue, attribute_line_ids{display_name, value_ids{name}}}";
      var response = await ApiServiceInventorySingleton.instance
          .getInventorySpecificPlant(cookie, query, widget.plantId);
      if (response.response.statusCode == 200) {
        setState(() {
          plantVariants = response.data;
        });
      } else {
        setState(() {
          isErrorInAPI = true;
        });
      }
    } catch (e) {
      setState(() {
        isErrorInAPI = true;
      });
      log("error:$e");
    }
  }

  void callCookieAPI() {
    try {
      SessionModule sessionModule = SessionModule();
      Params params = Params();
      params.db = Constants.db;
      params.login = Constants.login;
      params.password = Constants.password;
      sessionModule.params = params;
      ApiServiceInventorySingleton.instance
          .getSessionCookie(sessionModule)
          .then((response) {
        final cookies = response.response.headers['set-cookie'];
        List<String>? parts = cookies?[0].split(';');
        String? sessionId = parts?[0].trim();
        if (sessionId != null) {
          SessionTokenPreference.setSessionToken(sessionId).then((value) {
            specificPlantAPI(sessionId);
          });
        }
      });
    } catch (e) {
      //error
    }
  }

  void showToast(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
        message,
        style: GoogleFonts.nunito(
            textStyle: const TextStyle(
          fontSize: 16,
          color: Colors.white,
          fontWeight: FontWeight.w400,
        )),
      ),
    ));
  }

  Widget listChild2(int index) {
    // List<String> nameList = categorisedPlantsList[index].name.toString().split('|');
    double radius = MediaQuery.of(context).size.height * .04;
    return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => VariantsLocationScreen(
                  plantVariantName: plantVariantsValueList![index].name!,
                  plantName: plantVariants!.name.toString(),
                )));
      },
      child: Card(
        elevation: 3,
        margin: EdgeInsets.only(left: 12, right: 12, top: 5, bottom: 5),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            children: [
              CircleAvatar(
                  radius: radius, // Image radius
                  backgroundColor: Theme.of(context).primaryColor,
                  backgroundImage:
                      NetworkImage(widget.plantUrl!, headers: headersMap)),

              // Container(
              //                   margin: const EdgeInsets.all(12),
              //                   child: CircleAvatar(
              //                       radius: 30, // Image radius
              //                       backgroundColor: Theme.of(context).primaryColor,
              //                       backgroundImage: NetworkImage(
              //                           '${Constants.imageBaseURL}${categorisedPlantsList[0].id.toString()}&field=image_128',
              //                           headers: headersMap))
              //
              //               ),
              // CircleAvatar(
              //   radius: 30,
              //   backgroundColor: Theme.of(context).primaryColor,
              // ),
              SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    // 'Cover & Height: Netpot 0-1 Feet',
                    'Cover & Height: ' + plantVariantsValueList![index].name!,
                    style: GoogleFonts.nunito(
                        textStyle: const TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                      fontWeight: FontWeight.w400,
                    )),
                  ),
                  SizedBox(
                    height: 3,
                  ),
                  Text(
                    'Avl Units: 75',
                    // nameList[0].trim(),
                    style: GoogleFonts.nunito(
                        textStyle: const TextStyle(
                      fontSize: 13,
                      color: Color(0xff757575),
                      fontWeight: FontWeight.w400,
                    )),
                  ),
                  SizedBox(
                    height: 3,
                  ),
                  Text(
                    'Unit Price: ₹12.00',
                    // nameList[0].trim(),
                    style: GoogleFonts.nunito(
                        textStyle: const TextStyle(
                      fontSize: 13,
                      color: Color(0xff757575),
                      fontWeight: FontWeight.w400,
                    )),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
