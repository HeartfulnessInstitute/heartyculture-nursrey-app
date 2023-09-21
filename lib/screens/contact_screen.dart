import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactScreen extends StatefulWidget {
  const ContactScreen({super.key});

  @override
  State<ContactScreen> createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Image.asset("assets/images/logo_transparent.png"),
          Row(
            children: [
              Container(
                  margin: const EdgeInsets.only(left: 30, right: 30),
                  child: Icon(Icons.home,
                      color: Theme.of(context).primaryColor, size: 50)),
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Address",
                    style: GoogleFonts.nunito(
                        textStyle: const TextStyle(
                      fontSize: 16,
                      color: Color(0xff212121),
                      fontWeight: FontWeight.w700,
                    )),
                  ),
                  const Padding(padding: EdgeInsets.only(top: 8)),
                  Text(
                    "Kanha Shanti Vanam,\n"
                    "Ranga Reddy District,\n"
                    "Hyderabad - 500022,India",
                    style: GoogleFonts.nunito(
                        textStyle: const TextStyle(
                      fontSize: 14,
                      color: Color(0xff757575),
                      fontWeight: FontWeight.w400,
                    )),
                  ),
                ],
              ))
            ],
          ),
          Row(
            children: [
              Container(
                  margin: const EdgeInsets.only(left: 30, right: 30),
                  child: Icon(Icons.access_time,
                      color: Theme.of(context).primaryColor, size: 50)),
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Working Hours",
                    style: GoogleFonts.nunito(
                        textStyle: const TextStyle(
                      fontSize: 16,
                      color: Color(0xff212121),
                      fontWeight: FontWeight.w700,
                    )),
                  ),
                  const Padding(padding: EdgeInsets.only(top: 8)),
                  Text(
                    "Mon - Fri:09.00am to 06.00pm\n"
                    "Sat - Sun:07.00am to 06.00pm",
                    style: GoogleFonts.nunito(
                        textStyle: const TextStyle(
                      fontSize: 14,
                      color: Color(0xff757575),
                      fontWeight: FontWeight.w400,
                    )),
                  ),
                ],
              ))
            ],
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width*.7,
            child: ElevatedButton(
                onPressed: () {
                    launchUrl(Uri.parse("tel:7396581213"));
                },
                style: ButtonStyle(
                    elevation: MaterialStateProperty.all(0),
                    backgroundColor: MaterialStateProperty.all(
                      Theme.of(context).primaryColor,
                    ),
                    padding: MaterialStateProperty.all(
                        const EdgeInsets.all(6)),
                    shape: MaterialStateProperty.all<
                        RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius:
                            BorderRadius.circular(50.0)))),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(6),
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white
                      ),
                      child: Icon(Icons.phone,color: Theme.of(context).primaryColor,size: 28,),
                    ),
                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.only(right: 30),
                        child: Text(
                          "CALL US",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.nunito(
                              textStyle: const TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                              )),
                        ),
                      ),
                    ),
                  ],
                )),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width*.7,
            child: ElevatedButton(
                onPressed: () {
                  launchUrl(Uri.parse(url()));
                },
                style: ButtonStyle(
                    elevation: MaterialStateProperty.all(0),
                    backgroundColor: MaterialStateProperty.all(
                      Theme.of(context).primaryColor,
                    ),
                    padding: MaterialStateProperty.all(
                        const EdgeInsets.all(6)),
                    shape: MaterialStateProperty.all<
                        RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius:
                            BorderRadius.circular(50.0)))),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(6),
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white
                      ),
                      child: SvgPicture.asset("assets/images/whatsapp_icon.svg",width: 28,)
                    ),
                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.only(right: 30),
                        child: Text(
                          "WHATSAPP",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.nunito(
                              textStyle: const TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                              )),
                        ),
                      ),
                    ),
                  ],
                )),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width*.7,
            child: ElevatedButton(
                onPressed: () async {
                  if (await canLaunchUrl(params)) {
                  await launchUrl(params);
                  } else {
                  throw 'Could not launch $url';
                  }
                },
                style: ButtonStyle(
                    elevation: MaterialStateProperty.all(0),
                    backgroundColor: MaterialStateProperty.all(
                      Theme.of(context).primaryColor,
                    ),
                    padding: MaterialStateProperty.all(
                        const EdgeInsets.all(6)),
                    shape: MaterialStateProperty.all<
                        RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius:
                            BorderRadius.circular(50.0)))),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(6),
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white
                      ),
                      child: Icon(Icons.mail,color: Theme.of(context).primaryColor,size: 28,),
                    ),
                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.only(right: 30),
                        child: Text(
                          "EMAIL",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.nunito(
                              textStyle: const TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                              )),
                        ),
                      ),
                    ),
                  ],
                )),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width*.75,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                    onPressed: () async {
                      launchUrl(Uri.parse("https://www.linkedin.com/company/heartyculture-natural-product-llp"));
                    },
                    style: ButtonStyle(
                        elevation: MaterialStateProperty.all(0),
                        backgroundColor: MaterialStateProperty.all(
                          Colors.transparent,
                        ),
                        overlayColor: MaterialStateProperty.all(Theme.of(context).primaryColor.withOpacity(.2)),
                        side: MaterialStateProperty.all(BorderSide(width: 2,color: Theme.of(context).primaryColor)),
                        shape: MaterialStateProperty.all(const CircleBorder()),
                        padding: MaterialStateProperty.all(
                            const EdgeInsets.all(6))),
                    child: SvgPicture.asset("assets/images/linkedin_icon.svg")),
                ElevatedButton(
                    onPressed: () async {
                       launchUrl(Uri.parse("https://www.facebook.com/HeartycultureN/"));
                    },
                    style: ButtonStyle(
                        elevation: MaterialStateProperty.all(0),
                        backgroundColor: MaterialStateProperty.all(
                          Colors.transparent,
                        ),
                        overlayColor: MaterialStateProperty.all(Theme.of(context).primaryColor.withOpacity(.2)),
                        side: MaterialStateProperty.all(BorderSide(width: 2,color: Theme.of(context).primaryColor)),
                        shape: MaterialStateProperty.all(const CircleBorder()),
                        padding: MaterialStateProperty.all(
                            const EdgeInsets.all(6))),
                    child: SvgPicture.asset("assets/images/fb_icon.svg")),
                ElevatedButton(
                    onPressed: () async {
                      launchUrl(Uri.parse("https://www.instagram.com/heartyculture_nursery/"));
                    },
                    style: ButtonStyle(
                        elevation: MaterialStateProperty.all(0),
                        backgroundColor: MaterialStateProperty.all(
                          Colors.transparent,
                        ),
                        overlayColor: MaterialStateProperty.all(Theme.of(context).primaryColor.withOpacity(.2)),
                        side: MaterialStateProperty.all(BorderSide(width: 2,color: Theme.of(context).primaryColor)),
                        shape: MaterialStateProperty.all(const CircleBorder()),
                        padding: MaterialStateProperty.all(
                            const EdgeInsets.all(6))),
                    child: SvgPicture.asset("assets/images/insta_icon.svg")),
                ElevatedButton(
                    onPressed: () async {
                      launchUrl(Uri.parse("https://www.youtube.com/channel/UCBy4RwUiL7elNRWBacqYkrw"));
                    },
                    style: ButtonStyle(
                        elevation: MaterialStateProperty.all(0),
                        backgroundColor: MaterialStateProperty.all(
                          Colors.transparent,
                        ),
                        overlayColor: MaterialStateProperty.all(Theme.of(context).primaryColor.withOpacity(.2)),
                        side: MaterialStateProperty.all(BorderSide(width: 2,color: Theme.of(context).primaryColor)),
                        shape: MaterialStateProperty.all(const CircleBorder()),
                        padding: MaterialStateProperty.all(
                            const EdgeInsets.all(6))),
                    child: SvgPicture.asset("assets/images/youtube_icon.svg")),
              ],
            ),
          )
        ],
      ),
    );
  }

  String url() {
    if (Platform.isAndroid) {
      // add the [https]
      return "https://wa.me/918328181265/?text=${Uri.parse("Hi Heartyculture Nursery")}"; // new line
    } else {
      // add the [https]
      return "https://api.whatsapp.com/send?phone=918328181265=${Uri.parse("Hi Heartyculture Nursery")}"; // new line
    }
  }

  final Uri params = Uri(
    scheme: 'mailto',
    path: 'care@heartyculturenursery.com',
    query: 'subject=', //add subject and body here
  );
}
