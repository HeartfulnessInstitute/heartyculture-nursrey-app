import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'maintenance_list_screen.dart';

class FertilizingScreen extends StatefulWidget {
  const FertilizingScreen({super.key});

  @override
  State<FertilizingScreen> createState() => _FertilizingScreenState();
}

class _FertilizingScreenState extends State<FertilizingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
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
                    backgroundColor: Colors.white,
                    // <-- Button color
                    foregroundColor:
                    Theme.of(context).primaryColor, // <-- Splash color
                  ),
                  child: Icon(
                    Icons.adaptive.arrow_back,
                    color: Colors.black,
                    size: 24,
                  ),
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                    padding: const EdgeInsets.only(left: 50,right: 50),
                    width: double.infinity,
                    child: Image.asset("assets/images/logo_transparent.png")),
                Text(
                  "Fertilizing",
                  style: GoogleFonts.nunito(
                      textStyle: const TextStyle(
                        fontSize: 40,
                        color: Color(0xff212121),
                        fontWeight: FontWeight.w700,
                      )),
                ),
                Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top:0,left: 20,right: 20),
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(Radius.circular(6)),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.25),
                            spreadRadius: 5,
                            blurRadius: 10,
                            offset: const Offset(0, 0), // changes position of shadow
                          ),
                        ],
                      ),
                      child: InkWell(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>const MaintenanceListScreen()));
                        },
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Image.asset(
                                "assets/images/home_remedy_icon.png",
                                height: MediaQuery.of(context).size.height * .10,
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Home Remedy",
                                  style: GoogleFonts.nunito(
                                      textStyle: const TextStyle(
                                        fontSize: 18,
                                        color: Color(0xff212121),
                                        fontWeight: FontWeight.w700,
                                      )),
                                ),
                                Text(
                                  "Heal at Home",
                                  style: GoogleFonts.nunito(
                                      textStyle: const TextStyle(
                                        fontSize: 15,
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
                    Container(
                      margin: const EdgeInsets.only(top:30,left: 20,right: 20),
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(Radius.circular(6)),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.25),
                            spreadRadius: 5,
                            blurRadius: 10,
                            offset: const Offset(0, 0), // changes position of shadow
                          ),
                        ],
                      ),
                      child: InkWell(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>const MaintenanceListScreen()));
                        },
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Image.asset(
                                "assets/images/bio_icon.png",
                                height: MediaQuery.of(context).size.height * .10,
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Bio / Organic",
                                  style: GoogleFonts.nunito(
                                      textStyle: const TextStyle(
                                        fontSize: 18,
                                        color: Color(0xff212121),
                                        fontWeight: FontWeight.w700,
                                      )),
                                ),
                                Text(
                                  "Organic substances",
                                  style: GoogleFonts.nunito(
                                      textStyle: const TextStyle(
                                        fontSize: 15,
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
                    Container(
                      margin: const EdgeInsets.only(top:30,left: 20,right: 20),
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(Radius.circular(6)),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.25),
                            spreadRadius: 5,
                            blurRadius: 10,
                            offset: const Offset(0, 0), // changes position of shadow
                          ),
                        ],
                      ),
                      child: InkWell(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>const MaintenanceListScreen()));
                        },
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Image.asset(
                                "assets/images/chemical_icon.png",
                                height: MediaQuery.of(context).size.height * .10,
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Chemical",
                                  style: GoogleFonts.nunito(
                                      textStyle: const TextStyle(
                                        fontSize: 18,
                                        color: Color(0xff212121),
                                        fontWeight: FontWeight.w700,
                                      )),
                                ),
                                Text(
                                  "Synthetic Solutions",
                                  style: GoogleFonts.nunito(
                                      textStyle: const TextStyle(
                                        fontSize: 15,
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
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
