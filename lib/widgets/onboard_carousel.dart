
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hcn_flutter/constants.dart';
import 'package:hcn_flutter/modules/session_module.dart';
import 'package:hcn_flutter/network/api_service_singelton.dart';
import 'package:hcn_flutter/preference_storage/storage_notifier.dart';
import 'package:hcn_flutter/screens/home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../screens/nursery_store.dart';

class OnboardCarousel extends StatefulWidget {
  const OnboardCarousel({super.key});

  @override
  _OnboardCarouselState createState() => _OnboardCarouselState();
}

class _OnboardCarouselState extends State<OnboardCarousel> {
   final List<String> imageUrls = [
     "assets/images/forest.svg",
     "assets/images/plant_varities.svg",
     "assets/images/nurseries.svg",
  ];

  late PageController _pageController;
  int currentIndex = 0;
   List<Widget> listWidget=[];
  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: currentIndex);
    listWidget.add(
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "10 Million trees Planted",
              textAlign: TextAlign.center,
              style: GoogleFonts.nunito(
                  textStyle: const TextStyle(
                    fontWeight: FontWeight.w700,
                    decoration: TextDecoration.none,
                    fontSize: 25,
                    color: Colors.black,
                  )),
            ),
        Padding(padding: EdgeInsets.all(15), child: Text(
              "About 10 million tress has been planted across the country",
              textAlign: TextAlign.center,
              style: GoogleFonts.nunito(
                  textStyle: const TextStyle(
                    fontWeight: FontWeight.w700,
                    decoration: TextDecoration.none,
                    fontSize: 18,
                    color: Color(0xff757575),
                  )),
            )),
          ],
        )
    );
    listWidget.add(
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "2000+ Species available",
              textAlign: TextAlign.center,
              style: GoogleFonts.nunito(
                  textStyle: const TextStyle(
                    fontWeight: FontWeight.w700,
                    decoration: TextDecoration.none,
                    fontSize: 25,
                    color: Colors.black,
                  )),
            ),
            Padding(padding: EdgeInsets.all(15), child: Text(
              "Wide range of plants available including 356+ endangered species",
              textAlign: TextAlign.center,
              style: GoogleFonts.nunito(
                  textStyle: const TextStyle(
                    fontWeight: FontWeight.w700,
                    decoration: TextDecoration.none,
                    fontSize: 18,
                    color: Color(0xff757575),
                  )),
            )),
          ],
        )
    );
    listWidget.add(
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Handled by experts",
              textAlign: TextAlign.center,
              style: GoogleFonts.nunito(
                  textStyle: const TextStyle(
                    fontWeight: FontWeight.w700,
                    decoration: TextDecoration.none,
                    fontSize: 25,
                    color: Colors.black,
                  )),
            ),
        Padding(padding: EdgeInsets.all(15), child: Text(
              "Running 20+ Nurseries across India",
              textAlign: TextAlign.center,
              style: GoogleFonts.nunito(
                  textStyle: const TextStyle(
                    fontWeight: FontWeight.w700,
                    decoration: TextDecoration.none,
                    fontSize: 18,
                    color: Color(0xff757575),
                  )),
            )),
          ],
        )
    );
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor:
      Theme.of(context).primaryColor, //or set color with: Color(0xFF0000FF)
    ));
    return Container(
      color: Colors.white,
      // height: MediaQuery.of(context).size.height*.6,
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(padding: EdgeInsets.only(top: 80), child:Image.asset("assets/images/logo_transparent.png")),
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              itemCount: 3,
              onPageChanged: (index) {
                setState(() {
                  currentIndex = index;
                });
              },
              itemBuilder: (context, index) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SvgPicture.asset(imageUrls[index%3],height: MediaQuery.of(context).size.height*.4),
                    listWidget[index%3],
                    (index==2)?ElevatedButton(
                      onPressed: () async {
                        final Future<SharedPreferences> sharedPreferenceInstance = SharedPreferences.getInstance();
                        final SharedPreferences preference = await sharedPreferenceInstance;
                        preference.setBool(Constants.ONBOARD_PREFERENCE_KEY, true);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const NurseryStore()));
                      },
                      style: ElevatedButton.styleFrom(
                        shape: const CircleBorder(),
                        padding: const EdgeInsets.all(16),
                        backgroundColor:
                        Theme.of(context).primaryColor, // <-- Button color
                        foregroundColor: Colors.white, // <-- Splash color
                      ),
                      child: Icon(
                        Icons.adaptive.arrow_forward,
                        color: Colors.white,
                        size: 30,
                      ),
                    ):SizedBox(height: 30)
                  ],
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 50.0),
            child: Container(
              height: 20,
              color: Colors.white,
              alignment: Alignment.center,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemCount: imageUrls.length,
                itemBuilder: (context, index) {
                  return Container(
                    width: 8.0,
                    height: 8.0,
                    margin: const EdgeInsets.symmetric(horizontal: 4.0),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: currentIndex%3 == index ? Theme.of(context).primaryColor : const Color(0xffD9D9D9),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }


  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  List<Widget> contentList(){


  return listWidget;
}
}
