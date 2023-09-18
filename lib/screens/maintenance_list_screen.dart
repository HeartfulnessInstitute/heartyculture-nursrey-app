import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'maintenance_detail_screen.dart';

class MaintenanceListScreen extends StatefulWidget {
  const MaintenanceListScreen({super.key});

  @override
  State<MaintenanceListScreen> createState() => _MaintenanceListScreenState();
}

class _MaintenanceListScreenState extends State<MaintenanceListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title:  Text(
          "Home Remedy",
          style: GoogleFonts.nunito(
              textStyle: const TextStyle(
                fontSize: 18,
                color: Colors.white,
                fontWeight: FontWeight.w700,
              )),
        ),
      ),
      body: Container(
        child: ListView.builder(
            padding: const EdgeInsets.only(bottom: 10),
            itemCount: 10,
            itemBuilder:(context,index){
          return listChild();
        }),
      ),
    );
  }

  Widget listChild(){
    return Container(
      margin: const EdgeInsets.only(top:15,left: 20,right: 20),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(20)),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 5,
            blurRadius: 15,
            offset: const Offset(0, 0), // changes position of shadow
          ),
        ],
      ),
      child: InkWell(
        onTap: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>const MaintenanceDetailScreen()));
        },
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(10,10,20,10),
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(20)),
                child: Image.network(
                  "https://www.diggers.com.au/cdn/shop/products/turmeric-wtum_76313ac3-509f-40f3-aa30-0e2a512ad03b_1200x.jpg",
                  height: MediaQuery.of(context).size.height * .16,
                ),
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Turmeric",
                    style: GoogleFonts.nunito(
                        textStyle: const TextStyle(
                          fontSize: 22,
                          color: Color(0xff212121),
                          fontWeight: FontWeight.w700,
                        )),
                  ),
                  Divider(
                    height: 10,
                    thickness:2,
                    color: Colors.black.withOpacity(.05),
                    endIndent: 20,
                  ),
                  Text(
                    "Tasty muffins\nwith cream",
                    style: GoogleFonts.nunito(
                        textStyle: TextStyle(
                          fontSize: 15,
                          color: const Color(0xff212121).withOpacity(.4),
                          fontWeight: FontWeight.w700,
                        )),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

}
