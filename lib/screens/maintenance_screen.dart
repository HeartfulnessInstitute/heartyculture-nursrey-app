import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import '../modules/maintenance_module.dart';
import 'fertilizing_screen.dart';
import 'maintenance_list_screen.dart';

class MaintenanceScreen extends StatefulWidget {
  const MaintenanceScreen({super.key});

  @override
  State<MaintenanceScreen> createState() => _MaintenanceScreenState();
}

class _MaintenanceScreenState extends State<MaintenanceScreen> {
  List<MaintenanceModule>? maintenanceList;
  @override
  void initState() {
    super.initState();
    loadJsonData();
  }

  Future<void> loadJsonData() async {
    String jsonData = await rootBundle.loadString('assets/local_json/maintenance.json');
    setState(() {
      maintenanceList= (json.decode(jsonData) as List)
          .map((data) => MaintenanceModule.fromJson(data))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: const BoxDecoration(
        gradient: RadialGradient(
          center: Alignment(-0.3, 0.2),
          colors: [Color(0xffCB9E2B), Color(0xff205C42)],
          radius: 1.0,
        ),
      ),
      child: maintenanceList!=null?Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Image.asset("assets/images/logo_transparent.png"),
          Text(
              "Take care of the plants according to our plan and you will see the result",
              textAlign: TextAlign.center,
              style: GoogleFonts.nunito(
                  textStyle: const TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.w400))),
          InkWell(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => FertilizingScreen(maintenanceList:maintenanceList!)));
            },
            child: Card(
              elevation: 10,
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(6))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    margin: const EdgeInsets.only(left: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Fertilizing",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.nunito(
                                textStyle: const TextStyle(
                                    fontSize: 18,
                                    color: Color(0xff212121),
                                    fontWeight: FontWeight.w700))),
                        Text("Strengthening the Plant",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.nunito(
                                textStyle: const TextStyle(
                                    fontSize: 14,
                                    color: Color(0xff757575),
                                    fontWeight: FontWeight.w400))),
                      ],
                    ),
                  ),
                  Container(
                      margin: const EdgeInsets.all(15),
                      child: Image.asset(
                        "assets/images/fertilizing_icon.png",
                        height: MediaQuery.of(context).size.height * .10,
                      )),
                ],
              ),
            ),
          ),
          InkWell(
            onTap: () {
              var selectedMaintenance = maintenanceList?.firstWhere((element) => element.name=="Insects Pests");
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => MaintenanceListScreen(maintenanceModule: selectedMaintenance!)));
            },
            child: Card(
              elevation: 10,
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(6))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    margin: const EdgeInsets.only(left: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Insect Pests",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.nunito(
                                textStyle: const TextStyle(
                                    fontSize: 18,
                                    color: Color(0xff212121),
                                    fontWeight: FontWeight.w700))),
                        Text("Harmless Pesticides",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.nunito(
                                textStyle: const TextStyle(
                                    fontSize: 14,
                                    color: Color(0xff757575),
                                    fontWeight: FontWeight.w400))),
                      ],
                    ),
                  ),
                  Container(
                      margin: const EdgeInsets.all(15),
                      child: Image.asset(
                        "assets/images/insect_pests_icon.png",
                        height: MediaQuery.of(context).size.height * .10,
                      )),
                ],
              ),
            ),
          ),
          InkWell(
            onTap: () {
              var selectedMaintenance = maintenanceList?.firstWhere((element) => element.name=="Diseases");
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => MaintenanceListScreen(maintenanceModule: selectedMaintenance!)));
            },
            child: Card(
              elevation: 10,
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(6))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    margin: const EdgeInsets.only(left: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Diseases",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.nunito(
                                textStyle: const TextStyle(
                                    fontSize: 18,
                                    color: Color(0xff212121),
                                    fontWeight: FontWeight.w700))),
                        Text("Natural Disease Control",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.nunito(
                                textStyle: const TextStyle(
                                    fontSize: 14,
                                    color: Color(0xff757575),
                                    fontWeight: FontWeight.w400))),
                      ],
                    ),
                  ),
                  Container(
                      margin: const EdgeInsets.all(15),
                      child: Image.asset(
                        "assets/images/diseases_icon.png",
                        height: MediaQuery.of(context).size.height * .10,
                      )),
                ],
              ),
            ),
          )
        ],
      )
          :Center(child: CircularProgressIndicator(color: Theme.of(context).primaryColor)),
    );
  }
}
