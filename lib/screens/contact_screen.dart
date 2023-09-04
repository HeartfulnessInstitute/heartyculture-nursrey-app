import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
                    "Opening Hours",
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
          Row(
            children: [
              Container(
                  margin: const EdgeInsets.only(left: 30, right: 30),
                  child: Icon(Icons.link,
                      color: Theme.of(context).primaryColor, size: 50)),
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Social Media",
                    style: GoogleFonts.nunito(
                        textStyle: const TextStyle(
                      fontSize: 16,
                      color: Color(0xff212121),
                      fontWeight: FontWeight.w700,
                    )),
                  ),
                  const Padding(padding: EdgeInsets.only(top: 8)),
                  Text(
                    "Facebook: @heartyculturenursery\n"
                    "Instagram:@heartyclture_nursery\n"
                    "Twitter: @HeartcultureN\n"
                    "Youtube:heartyculturenursery5855\n"
                    "Care@heartyculturenursery.com\n",
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
          Container(
            width: double.infinity,
            margin: const EdgeInsets.only(left: 25, right: 25),
            child: ElevatedButton(
                onPressed: () {

                },
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                      Theme.of(context).primaryColor,
                    ),
                    padding: MaterialStateProperty.all(
                        const EdgeInsets.all(10)),
                    shape: MaterialStateProperty.all<
                        RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius:
                            BorderRadius.circular(8.0)))),
                child: Text(
                  "Contact Us",
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
    );
  }
}
