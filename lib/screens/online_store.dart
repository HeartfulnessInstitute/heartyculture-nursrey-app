import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hcn_flutter/modules/session_module.dart';
import 'package:hcn_flutter/network/api_service_singelton.dart';
import 'package:hcn_flutter/preference_storage/storage_notifier.dart';
import 'package:hcn_flutter/screens/home_screen.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../constants.dart';

class OnlineStore extends StatefulWidget {
  const OnlineStore({super.key});

  @override
  State<OnlineStore> createState() => _OnlineStoreState();
}

class _OnlineStoreState extends State<OnlineStore> {
  bool isPageLoading = true;
  bool isPageFailed = false;
  late WebViewController controller;
  @override
  void initState() {
    super.initState();
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // isPageLoading = true;
          },
          onPageStarted: (String url) {
            setState(() {
              isPageLoading = true;
            });
          },
          onPageFinished: (String url) {
            setState(() {
              isPageLoading = false;
            });
          },
          onWebResourceError: (WebResourceError error) {
            /*setState(() {
              isPageLoading = false;
              isPageFailed = true;
            });*/
          },
          /*onNavigationRequest: (NavigationRequest request) {
            return NavigationDecision.navigate;
          },*/
        ),
      )
      ..loadRequest(Uri.parse('https://www.heartyculturenursery.com/'));
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor:
          Theme.of(context).primaryColor, //or set color with: Color(0xFF0000FF)
    ));

    return Scaffold(
      backgroundColor: const Color(0xfff5f5f5),
      body: SafeArea(
        child: Stack(children: [
          WebViewWidget(controller: controller),
          Center(
            child: isPageFailed
                ? const Text(
                    "Oops Something went wrong!",
                    style: TextStyle(fontSize: 20, color: Color(0xff757575)),
                  )
                : isPageLoading!
                    ? CircularProgressIndicator(
                        color: Theme.of(context).primaryColor,
                      )
                    : const SizedBox(),
          )
        ]),
      ),
    );
  }
}
