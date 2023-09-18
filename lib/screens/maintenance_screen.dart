import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'fertilizing_screen.dart';
import 'maintenance_list_screen.dart';

class MaintenanceScreen extends StatefulWidget {
  const MaintenanceScreen({super.key});

  @override
  State<MaintenanceScreen> createState() => _MaintenanceScreenState();
}

class _MaintenanceScreenState extends State<MaintenanceScreen> {
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
      child: Column(
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
                  builder: (context) => const FertilizingScreen()));
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
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const MaintenanceListScreen()));
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
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const MaintenanceListScreen()));
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
      ),
    );
  }
}
