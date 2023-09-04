import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hcn_flutter/screens/plant_information.dart';

class PlantScreen extends StatefulWidget {
  const PlantScreen({super.key});

  @override
  State<PlantScreen> createState() => _PlantScreenState();
}

class _PlantScreenState extends State<PlantScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Image.network(
              'https://www.ugaoo.com/cdn/shop/products/ajwain-plant-32220864446596.jpg',
              width: double.infinity,
              height: MediaQuery.of(context).size.height/2,
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
                    backgroundColor:Colors.black.withOpacity(.5), // <-- Button color
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
                            "Pink Cedar",
                            style: GoogleFonts.nunito(
                                textStyle: const TextStyle(
                              fontSize: 32,
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                            )),
                          ),
                          Text(
                            "(Acrocarpus Fraxinifolius)",
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
                            Navigator.of(context).push(MaterialPageRoute(builder: (context)=>const PlantInformationScreen()));
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
        ),
      ),
    );
  }
}
