import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SubMaintenanceScreen extends StatefulWidget {
  const SubMaintenanceScreen({super.key, required this.screenIndex});

  final int screenIndex;

  @override
  State<SubMaintenanceScreen> createState() => _SubMaintenanceScreenState();
}

class _SubMaintenanceScreenState extends State<SubMaintenanceScreen> {
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
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                      widget.screenIndex == 0
                          ? "Fertilizing"
                          : widget.screenIndex == 1
                              ? "Insect Pests"
                              : "Diseases",
                      style: GoogleFonts.nunito(
                          textStyle: const TextStyle(
                              fontSize: 18,
                              color: Color(0xff212121),
                              fontWeight: FontWeight.w700))),
                  Image.asset(
                    widget.screenIndex == 0
                        ? "assets/images/fertilizing_icon.png"
                        : widget.screenIndex == 1
                        ?  "assets/images/insect_pests_icon.png"
                        :  "assets/images/diseases_icon.png",
                    height: MediaQuery.of(context).size.height * .35,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: Text("Active Growth Period",
                        textAlign: TextAlign.start,
                        style: GoogleFonts.nunito(
                            textStyle: const TextStyle(
                                fontSize: 18,
                                color: Color(0xff212121),
                                fontWeight: FontWeight.w700))),
                  ),
                  Container(
                    child: GridView.builder(
                        shrinkWrap: true,
                        itemCount: 6,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisSpacing: 10,
                                mainAxisSpacing: 10,
                                childAspectRatio: 2,
                                crossAxisCount: 5),
                        itemBuilder: (context, index) {
                          return Container(
                              decoration: BoxDecoration(
                                  color: Theme.of(context).primaryColor,
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(20))),
                              alignment: Alignment.center,
                              child: Text("MAR",
                                  textAlign: TextAlign.start,
                                  style: GoogleFonts.nunito(
                                      textStyle: const TextStyle(
                                          fontSize: 14,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w700))));
                        }),
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: Text("Method",
                        textAlign: TextAlign.start,
                        style: GoogleFonts.nunito(
                            textStyle: const TextStyle(
                                fontSize: 18,
                                color: Color(0xff212121),
                                fontWeight: FontWeight.w700))),
                  ),
                  Container(
                      decoration: const BoxDecoration(
                          color: Color(0xffF5F5F5),
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      width: double.infinity,
                      padding: const EdgeInsets.all(20),
                      child: Text(
                          "Apply NPK monthly during active growth period (Mar, Apr, May, Jun, Sep, Oct). Apply balanced fertilizer (19:19:19) during normal growth period",
                          textAlign: TextAlign.start,
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
