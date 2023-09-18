import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constants.dart';
import '../widgets/image_carousel.dart';
import 'contact_screen.dart';

import '../modules/plant_module.dart';
import 'maintenance_screen.dart';
import 'package:collection/collection.dart';

class PlantInformationScreen extends StatefulWidget {
  const PlantInformationScreen({super.key, required this.plant});
  final Plants plant;

  @override
  State<PlantInformationScreen> createState() => _PlantInformationScreenState();
}

class _PlantInformationScreenState extends State<PlantInformationScreen> {
  int selectedPageIndex = 0;

  TextStyle getStyle(Set<MaterialState> states) {
    const Set<MaterialState> interactiveStates = <MaterialState>{
      MaterialState.pressed,
      MaterialState.hovered,
      MaterialState.focused,
      MaterialState.selected,
    };
    if (states.any(interactiveStates.contains)) {
      return GoogleFonts.nunito(
          textStyle: TextStyle(
              color: Theme.of(context).primaryColor,
              fontWeight: FontWeight.w400));
    }
    return GoogleFonts.nunito(
        textStyle: TextStyle(
      color: Colors.black.withOpacity(.65),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBarTheme(
        data: NavigationBarThemeData(
            indicatorColor: Theme.of(context).primaryColor,
            backgroundColor: const Color(0xffffffff),
            labelTextStyle: MaterialStateProperty.resolveWith(getStyle)),
        child: NavigationBar(
          elevation: 20,
          selectedIndex: selectedPageIndex,
          onDestinationSelected: (int index) {
            setState(() {
              selectedPageIndex = index;
            });
          },
          destinations: const <NavigationDestination>[
            NavigationDestination(
              selectedIcon: Icon(Icons.home, color: Colors.white),
              icon: Icon(Icons.home, color: Colors.grey),
              label: 'General',
            ),
            NavigationDestination(
              selectedIcon: Icon(Icons.favorite, color: Colors.white),
              icon: Icon(Icons.favorite, color: Colors.grey),
              label: 'Care',
            ),
            NavigationDestination(
              selectedIcon: Icon(Icons.cut, color: Colors.white),
              icon: Icon(Icons.cut, color: Colors.grey),
              label: 'Maintenance',
            ),
            NavigationDestination(
              selectedIcon: Icon(Icons.person, color: Colors.white),
              icon: Icon(Icons.person, color: Colors.grey),
              label: 'Contact',
            )
          ],
        ),
      ),
      body: SafeArea(
        child: selectedPageIndex == 0 || selectedPageIndex == 1
            ? plantGeneral(selectedPageIndex)
            : selectedPageIndex == 2
              ? const MaintenanceScreen()
            : selectedPageIndex == 3
                ? const ContactScreen()
                : Container(),
      ),
    );
  }

  List<dynamic> getImageList(){
    var prefix = "https://erp.heartyculturenursery.com/web/content/";
    List<String> list = [];
    list.add(
      "${Constants.imageBaseURL}${widget.plant.id.toString()}&field=image_256"
    );
    if(widget.plant.plantInflorescenceImage!=null && widget.plant.plantInflorescenceImage?.isNotEmpty==true){
      list.add(prefix+widget.plant.plantInflorescenceImage![0].toString());
    }
    if(widget.plant.plantFlowerImage!=null && widget.plant.plantFlowerImage?.isNotEmpty==true){
      list.add(prefix+widget.plant.plantFlowerImage![0].toString());
    }
    if(widget.plant.plantHabitImage!=null && widget.plant.plantHabitImage?.isNotEmpty==true){
      list.add(prefix+widget.plant.plantHabitImage![0].toString());
    }
    if(widget.plant.plantLeafImage!=null && widget.plant.plantLeafImage?.isNotEmpty==true){
      list.add(prefix+widget.plant.plantLeafImage![0].toString());
    }
    if(widget.plant.plantStemImage!=null && widget.plant.plantStemImage?.isNotEmpty==true){
      list.add(prefix+widget.plant.plantStemImage![0].toString());
    }
    return list;
  }

  Widget plantGeneral(int index) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
           /* Image.network(
              'https://www.ugaoo.com/cdn/shop/products/ajwain-plant-32220864446596.jpg',
              width: double.infinity,
              height: MediaQuery.of(context).size.height / 2,
              fit: BoxFit.cover,
            ),*/
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
                    backgroundColor: Colors.black.withOpacity(.5),
                    // <-- Button color
                    foregroundColor: Colors.white, // <-- Splash color
                  ),
                  child: Icon(
                    Icons.adaptive.share,
                    color: Colors.white,
                    size: 24,
                  ),
                ),
              ),
            ),
            Column(
              children: [
                Expanded(
                  child: SizedBox(
                      width: double.infinity,
                      child: ImageCarousel(imageList:getImageList())),
                ),
                index == 0
                    ? Expanded(
                      child: Container(
                          decoration: const BoxDecoration(
                              color: Colors.white),
                          width: double.infinity,
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                margin: const EdgeInsets.only(top: 0, bottom: 0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "General Details",
                                      style: GoogleFonts.nunito(
                                          textStyle: const TextStyle(
                                            fontSize: 23,
                                            color: Color(0xff212121),
                                            fontWeight: FontWeight.w600,
                                          )),
                                    ),
                                    ElevatedButton(
                                        onPressed: () {},
                                        style: ButtonStyle(
                                            elevation: MaterialStateProperty.all(0),
                                            overlayColor: MaterialStateProperty.all(
                                                Theme.of(context)
                                                    .primaryColor
                                                    .withOpacity(.1)),
                                            backgroundColor:
                                            MaterialStateProperty.all(
                                                Colors.white),
                                            padding: MaterialStateProperty.all(
                                                const EdgeInsets.only(
                                                    left: 15, right: 15)),
                                            side: MaterialStateProperty.all(BorderSide(
                                                color:
                                                Theme.of(context).primaryColor)),
                                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(borderRadius: BorderRadius.circular(50.0)))),
                                        child: Text(
                                          "Buy Now",
                                          style: GoogleFonts.nunito(
                                              textStyle: TextStyle(
                                                fontSize: 16,
                                                color: Theme.of(context).primaryColor,
                                                fontWeight: FontWeight.w400,
                                              )),
                                        )),
                                  ],
                                ),
                              ),
                              Row(
                                children: [
                                  Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Common Name",
                                            style: GoogleFonts.nunito(
                                                textStyle: const TextStyle(
                                                  fontSize: 15,
                                                  color: Color(0xff757575),
                                                  fontWeight: FontWeight.w600,
                                                )),
                                          ),
                                          Text(
                                            widget.plant.name.toString().split('|')[0].trim(),
                                            style: GoogleFonts.nunito(
                                                textStyle: const TextStyle(
                                                  fontSize: 18,
                                                  color: Color(0xff212121),
                                                  fontWeight: FontWeight.w400,
                                                )),
                                          ),
                                        ],
                                      )),
                                  Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Scientific Name",
                                            style: GoogleFonts.nunito(
                                                textStyle: const TextStyle(
                                                  fontSize: 15,
                                                  color: Color(0xff757575),
                                                  fontWeight: FontWeight.w600,
                                                )),
                                          ),
                                          Text(
                                            widget.plant.name.toString().split('|')[1].trim(),
                                            style: GoogleFonts.nunito(
                                                textStyle: const TextStyle(
                                                  fontSize: 18,
                                                  color: Color(0xff212121),
                                                  fontWeight: FontWeight.w400,
                                                )),
                                          ),
                                        ],
                                      ))
                                ],
                              ),
                              Row(
                                children: [
                                  Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Vegetation Type",
                                            style: GoogleFonts.nunito(
                                                textStyle: const TextStyle(
                                                  fontSize: 15,
                                                  color: Color(0xff757575),
                                                  fontWeight: FontWeight.w600,
                                                )),
                                          ),
                                          Text(
                                            widget.plant.vegetationType.toString(),
                                            style: GoogleFonts.nunito(
                                                textStyle: const TextStyle(
                                                  fontSize: 18,
                                                  color: Color(0xff212121),
                                                  fontWeight: FontWeight.w400,
                                                )),
                                          ),
                                        ],
                                      )),
                                  Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Life Span",
                                            style: GoogleFonts.nunito(
                                                textStyle: const TextStyle(
                                                  fontSize: 15,
                                                  color: Color(0xff757575),
                                                  fontWeight: FontWeight.w600,
                                                )),
                                          ),
                                          Text(
                                            getValueByDisplayName("Life Span"),
                                            style: GoogleFonts.nunito(
                                                textStyle: const TextStyle(
                                                  fontSize: 18,
                                                  color: Color(0xff212121),
                                                  fontWeight: FontWeight.w400,
                                                )),
                                          ),
                                        ],
                                      ))
                                ],
                              ),
                              Row(
                                children: [
                                  Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Category",
                                            style: GoogleFonts.nunito(
                                                textStyle: const TextStyle(
                                                  fontSize: 15,
                                                  color: Color(0xff757575),
                                                  fontWeight: FontWeight.w600,
                                                )),
                                          ),
                                          Text(
                                            "Native Trees",
                                            style: GoogleFonts.nunito(
                                                textStyle: const TextStyle(
                                                  fontSize: 18,
                                                  color: Color(0xff212121),
                                                  fontWeight: FontWeight.w400,
                                                )),
                                          ),
                                        ],
                                      )),
                                  Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Canopy",
                                            style: GoogleFonts.nunito(
                                                textStyle: const TextStyle(
                                                  fontSize: 15,
                                                  color: Color(0xff757575),
                                                  fontWeight: FontWeight.w600,
                                                )),
                                          ),
                                          Text(
                                            widget.plant.canopyType.toString(),
                                            style: GoogleFonts.nunito(
                                                textStyle: const TextStyle(
                                                  fontSize: 18,
                                                  color: Color(0xff212121),
                                                  fontWeight: FontWeight.w400,
                                                )),
                                          ),
                                        ],
                                      ))
                                ],
                              ),
                              Row(
                                children: [
                                  Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Nativity",
                                            style: GoogleFonts.nunito(
                                                textStyle: const TextStyle(
                                                  fontSize: 15,
                                                  color: Color(0xff757575),
                                                  fontWeight: FontWeight.w600,
                                                )),
                                          ),
                                          Text(
                                            widget.plant.origin=="Native"?"Indian":widget.plant.origin,
                                            style: GoogleFonts.nunito(
                                                textStyle: const TextStyle(
                                                  fontSize: 18,
                                                  color: Color(0xff212121),
                                                  fontWeight: FontWeight.w400,
                                                )),
                                          ),
                                        ],
                                      )),
                                  Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Importance",
                                            style: GoogleFonts.nunito(
                                                textStyle: const TextStyle(
                                                  fontSize: 15,
                                                  color: Color(0xff757575),
                                                  fontWeight: FontWeight.w600,
                                                )),
                                          ),
                                          Text(
                                            widget.plant.economicImportance.toString(),
                                            style: GoogleFonts.nunito(
                                                textStyle: const TextStyle(
                                                  fontSize: 18,
                                                  color: Color(0xff212121),
                                                  fontWeight: FontWeight.w400,
                                                )),
                                          ),
                                        ],
                                      ))
                                ],
                              ),
                            ],
                          ),
                      ),
                    )
                    : Expanded(
                      child: Container(
                        decoration: const BoxDecoration(
                            color: Colors.white),
                        height: MediaQuery.of(context).size.height / 2,
                        width: double.infinity,
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Column(
                              children: [
                                Text(
                                  widget.plant.name.toString().split('|')[0].trim(),
                                  style: GoogleFonts.nunito(
                                      textStyle: const TextStyle(
                                        fontSize: 23,
                                        color: Color(0xff212121),
                                        fontWeight: FontWeight.w700,
                                      )),
                                ),
                                Text(
                                  widget.plant.name.toString().split('|')[1].trim(),
                                  style: GoogleFonts.nunito(
                                      textStyle: const TextStyle(
                                        fontSize: 14,
                                        color: Color(0xff757575),
                                        fontWeight: FontWeight.w400,
                                      )),
                                ),
                                Divider(
                                  color: Theme.of(context).primaryColor,
                                )
                              ],
                            ),
                            Container(
                              color: const Color(0xfff5f5f5),
                              child: Row(
                                children: [
                                  Container(
                                      margin: const EdgeInsets.all(10),
                                      child: Icon(Icons.water_drop_outlined,
                                          color: Theme.of(context).primaryColor,
                                          size: 35)),
                                  Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Watering Frequency",
                                            style: GoogleFonts.nunito(
                                                textStyle: const TextStyle(
                                                  fontSize: 15,
                                                  color: Color(0xff757575),
                                                  fontWeight: FontWeight.w600,
                                                )),
                                          ),
                                          Text(
                                            "4 / Week",
                                            style: GoogleFonts.nunito(
                                                textStyle: const TextStyle(
                                                  fontSize: 18,
                                                  color: Color(0xff212121),
                                                  fontWeight: FontWeight.w400,
                                                )),
                                          ),
                                        ],
                                      ))
                                ],
                              ),
                            ),
                            Container(
                              color: const Color(0xfff5f5f5),
                              child: Row(
                                children: [
                                  Container(
                                      margin: const EdgeInsets.all(10),
                                      child: Icon(Icons.wb_sunny_outlined,
                                          color: Theme.of(context).primaryColor,
                                          size: 35)),
                                  Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Light",
                                            style: GoogleFonts.nunito(
                                                textStyle: const TextStyle(
                                                  fontSize: 15,
                                                  color: Color(0xff757575),
                                                  fontWeight: FontWeight.w600,
                                                )),
                                          ),
                                          Text(
                                            getValueByDisplayName("Light"),
                                            style: GoogleFonts.nunito(
                                                textStyle: const TextStyle(
                                                  fontSize: 18,
                                                  color: Color(0xff212121),
                                                  fontWeight: FontWeight.w400,
                                                )),
                                          ),
                                        ],
                                      ))
                                ],
                              ),
                            ),
                            Container(
                              color: const Color(0xfff5f5f5),
                              child: Row(
                                children: [
                                  Container(
                                      margin: const EdgeInsets.all(10),
                                      child: Icon(Icons.thermostat_outlined,
                                          color: Theme.of(context).primaryColor,
                                          size: 35)),
                                  Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Temperature",
                                            style: GoogleFonts.nunito(
                                                textStyle: const TextStyle(
                                                  fontSize: 15,
                                                  color: Color(0xff757575),
                                                  fontWeight: FontWeight.w600,
                                                )),
                                          ),
                                          Text(
                                            getValueByDisplayName("Temperature"),
                                            style: GoogleFonts.nunito(
                                                textStyle: const TextStyle(
                                                  fontSize: 18,
                                                  color: Color(0xff212121),
                                                  fontWeight: FontWeight.w400,
                                                )),
                                          ),
                                        ],
                                      ))
                                ],
                              ),
                            ),
                            Container(
                              color: const Color(0xfff5f5f5),
                              child: Row(
                                children: [
                                  Container(
                                      margin: const EdgeInsets.all(10),
                                      child: Icon(Icons.flourescent,
                                          color: Theme.of(context).primaryColor,
                                          size: 35)),
                                  Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Soil Mix",
                                            style: GoogleFonts.nunito(
                                                textStyle: const TextStyle(
                                                  fontSize: 15,
                                                  color: Color(0xff757575),
                                                  fontWeight: FontWeight.w600,
                                                )),
                                          ),
                                          Text(
                                            getValueByDisplayName("Soil Mix"),
                                            style: GoogleFonts.nunito(
                                                textStyle: const TextStyle(
                                                  fontSize: 16,
                                                  color: Color(0xff212121),
                                                  fontWeight: FontWeight.w400,
                                                )),
                                          ),
                                        ],
                                      ))
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
              ],
            )


          ],
        ),
      ),
    );
  }

  String getValueByDisplayName(String displayName){
    var attributeLine = widget.plant.attributeLineIds?.firstWhereOrNull((element) => element.displayName == displayName);
    if(attributeLine!=null){
      return attributeLine.valueIds?[0].name??"-";
    }else{
      return "-";
    }
  }
}
