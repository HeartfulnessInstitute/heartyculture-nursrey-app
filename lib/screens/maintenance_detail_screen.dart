import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MaintenanceDetailScreen extends StatefulWidget {
  const MaintenanceDetailScreen({super.key});

  @override
  State<MaintenanceDetailScreen> createState() => _MaintenanceDetailScreenState();
}

class _MaintenanceDetailScreenState extends State<MaintenanceDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
        color: Colors.white,
        width: double.infinity,
        height: double.infinity,
        child: Stack(
          children: [
            Container(
              margin: const EdgeInsets.all(20),
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Turmeric",
                      style: GoogleFonts.nunito(
                          textStyle: const TextStyle(
                              fontSize: 18,
                              color: Color(0xff212121),
                              fontWeight: FontWeight.w700))),
                  Image.network(
                    "https://cdn.pixabay.com/photo/2013/07/13/11/45/play-158609_1280.png",
                    height: MediaQuery.of(context).size.height * .28,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: Text(
                        "How to Use Trichoderma Viride (Bio-Fungicide) in Garden | Organic Protection for Plants (ENGLISH)",
                        textAlign: TextAlign.start,
                        style: GoogleFonts.nunito(
                            textStyle: const TextStyle(
                                fontSize: 20,
                                color: Color(0xff212121),
                                fontWeight: FontWeight.w800))),
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: Text("Description",
                        textAlign: TextAlign.start,
                        style: GoogleFonts.nunito(
                            textStyle: const TextStyle(
                                fontSize: 18,
                                color: Color(0xff212121),
                                fontWeight: FontWeight.w400))),
                  ),
                  Container(
                      decoration: const BoxDecoration(
                          color: Color(0xffF5F5F5),
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      width: double.infinity,
                      padding: const EdgeInsets.all(20),
                      child: Text(
                          "Apply NPK monthly during active growth period (Mar, Apr, May, Jun, Sep, Oct). Apply balanced fertilizer (19:19:19) during normal growth period. Apply Bioagents Trichoderma viride or Pseudomonas fluorescens or Bacillus subtilis @ 10-15 ml or gm /lit for wilts, leafspots and root rots. Apply NPK monthly during active growth period (Mar, Apr, May, Jun, Sep, Oct). Apply balanced fertilizer (19:19:19) during normal growth period. ",
                          textAlign: TextAlign.justify,
                          style: GoogleFonts.nunito(
                              textStyle: const TextStyle(
                                  fontSize: 16,
                                  color: Color(0xff212121),
                                  fontWeight: FontWeight.w700))))
                ],
              ),
            ),
            Positioned(
              top: 0,
              right: 0,
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
                    Icons.adaptive.share,
                    color: Colors.black,
                    size: 24,
                  ),
                ),
              ),
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
          ],
        ),
      )),
    );
  }
}
