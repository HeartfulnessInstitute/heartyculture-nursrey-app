import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hcn_flutter/modules/session_module.dart';
import 'package:hcn_flutter/network/api_service_singelton.dart';
import 'package:hcn_flutter/preference_storage/storage_notifier.dart';
import 'package:hcn_flutter/screens/home_screen.dart';

import '../constants.dart';
import 'online_store.dart';

class NurseryStore extends StatelessWidget {
  const NurseryStore({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor:
      Theme.of(context).primaryColor, //or set color with: Color(0xFF0000FF)
    ));
    return Scaffold(
      backgroundColor: Color(0xfff5f5f5),
      body: SafeArea(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                onTap: (){
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const OnlineStore()));
                },
                child: SvgPicture.asset(
                  "assets/images/online_store_hcn.svg",
                  width: MediaQuery.of(context).size.width*.85,
                ),
              ),
              InkWell(
                onTap: (){
                  try {
                    showLoadingDialog(context);
                    SessionModule sessionModule = SessionModule();
                    Params params = Params();
                    params.db = Constants.db;
                    params.login =  Constants.login;
                    params.password = Constants.password;
                    sessionModule.params = params;
                    ApiServiceSingleton.instance
                        .getSessionCookie(sessionModule)
                        .then((response) {
                      hideLoadingDialog(context);
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
                child: SvgPicture.asset(
                  "assets/images/offline_store_hcn.svg",
                  width: MediaQuery.of(context).size.width*.85,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }


  void hideLoadingDialog(BuildContext context) {
    Navigator.of(context).pop(); // Close the dialog
  }

  void showLoadingDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false, // Prevent users from dismissing the dialog by tapping outside
      builder: (BuildContext context) {
        return AlertDialog(
          content: Row(
            children: <Widget>[
              CircularProgressIndicator(
                color: Theme.of(context).primaryColor,
              ),
              const SizedBox(width: 20),
              Text("Getting Plants...",
                  style: GoogleFonts.nunito(
                      textStyle: const TextStyle(
                          fontSize: 18,
                          color: Color(0xff212121),
                          fontWeight: FontWeight.w400))
              ),
            ],
          ),
        );
      },
    );
  }
}
