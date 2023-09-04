import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hcn_flutter/modules/session_module.dart';
import 'package:hcn_flutter/network/api_service_singelton.dart';
import 'package:hcn_flutter/preference_storage/storage_notifier.dart';
import 'package:hcn_flutter/screens/home_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor:
          Theme.of(context).primaryColor, //or set color with: Color(0xFF0000FF)
    ));
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Image.asset("assets/images/logo_transparent.png"),
            Image.asset(
              "assets/images/plants_home.png",
              height: MediaQuery.of(context).size.height * .33,
            ),
            Container(
              margin: const EdgeInsets.only(left: 25, right: 25),
              child: Text(
                  "Dive into our vast selection of thriving plants, each cultivated with care and expertise.",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.oleoScriptSwashCaps(
                      textStyle: const TextStyle(
                    fontWeight: FontWeight.w400,
                    decoration: TextDecoration.none,
                    fontSize: 22,
                    color: Color(0xff717171),
                  ))),
            ),
            ElevatedButton(
              onPressed: () {
                try {
                  SessionModule sessionModule = SessionModule();
                  Params params = Params();
                  params.db = "hc-nursery";
                  params.login = "vignesh.manickam@volunteer.heartfulness.org";
                  params.password = "hcnVignesh";
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
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const HomeScreen()));
                      });
                    }
                  });
                } catch (e) {
                  //error
                }
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
            )
          ],
        ),
      ),
    );
  }
}
