import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import '../modules/maintenance_module.dart';
import 'maintenance_detail_screen.dart';

class MaintenanceListScreen extends StatefulWidget {
  const MaintenanceListScreen({super.key,required this.maintenanceModule});

  final MaintenanceModule maintenanceModule;

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
          widget.maintenanceModule.name.toString(),
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
            itemCount: widget.maintenanceModule.listData?.length,
            itemBuilder:(context,index){
          return listChild(widget.maintenanceModule.listData![index]);
        }),
      ),
    );
  }

  Widget listChildOld(){
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

  Widget listChild(ListData listData){
    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.only(top:15,left: 10,right: 10),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(5)),
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
          openUrl(listData.videoUrl!);
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Image.network(
                  fit: BoxFit.contain,
                  width:double.infinity,
                  getYouTubeThumbnail(extractVideoId(listData.videoUrl!))
                ),
                Positioned.fill(
                  child: Center(
                    child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.black.withOpacity(.5)
                        ),
                        padding: const EdgeInsets.all(7),
                        child: const Icon(Icons.play_arrow,size: 50,color: Colors.white,)),
                  ),
                ),
              ],
            ),
            const Padding(padding: EdgeInsets.only(top: 8)),
            Text(
              listData.title.toString(),
              style: GoogleFonts.nunito(
                  textStyle: const TextStyle(
                    fontSize: 18,
                    color: Color(0xff212121),
                    fontWeight: FontWeight.w700,
                  )),
            ),
            Text(
              listData.description.toString(),
              style: GoogleFonts.nunito(
                  textStyle: TextStyle(
                    fontSize: 14,
                    color: const Color(0xff212121).withOpacity(.4),
                    fontWeight: FontWeight.w400,
                  )),
            ),
          ],
        ),
      ),
    );
  }

  String? extractVideoId(String url) {
    // Regular expression for extracting YouTube video IDs from various URL formats
    RegExp regExp = RegExp(
      r'^(?:https?:\/\/)?(?:www\.)?(?:youtube\.com\/(?:[^\/\n\s]+\/\S+\/|(?:v|e(?:mbed)?)\/|\S*?[?&]v=)|youtu\.be\/)([a-zA-Z0-9_-]{11})',
      caseSensitive: false,
      multiLine: false,
    );

    // Match the regular expression to get the video ID
    RegExpMatch? match = regExp.firstMatch(url);

    if (match != null && match.groupCount >= 1) {
      return match.group(1);
    } else {
      return null; // No match found
    }
  }

  String getYouTubeThumbnail(String? videoId) {
    if(videoId!=null){
      return 'https://img.youtube.com/vi/$videoId/0.jpg';
    }else{
      return 'https://cdn.pixabay.com/photo/2013/07/13/11/45/play-158609_1280.png';
    }
  }

  void openUrl(String url) async {
    await launchUrl(Uri.parse(url));
  }
}
