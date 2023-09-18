import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../modules/plant_module.dart';
import '../preference_storage/my_plants_preference_notifier.dart';
import 'plant_screen.dart';

class MyPlantsScreen extends StatefulWidget {
  const MyPlantsScreen({super.key});

  @override
  State<MyPlantsScreen> createState() => _MyPlantsScreenState();
}

class _MyPlantsScreenState extends State<MyPlantsScreen> {
  List<Plants> plantsList = [];
  bool isSearch = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    plantsList = Provider.of<MyPlantsPreferenceNotifier>(context, listen: true).myPlantsList;
    return Scaffold(
      appBar: isSearch?
      AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Theme.of(context).primaryColor,
        title: Container(),
        actions: [
          IconButton(
              icon: const Icon(Icons.close),
              tooltip: 'Close',
              onPressed: () {
                setState(() {
                  isSearch = false;
                });
              }),
        ],
      ):
      AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Theme.of(context).primaryColor,
        title: Text("My Plants",
            style: GoogleFonts.nunito(
                textStyle: const TextStyle(
                    color: Colors.white, fontWeight: FontWeight.w400))),
       /* actions: [
          IconButton(
              icon: const Icon(Icons.search),
              tooltip: 'Search',
              onPressed: () {
                setState(() {
                  isSearch=true;
                });
              }),
          IconButton(
              icon: const Icon(Icons.sort),
              tooltip: 'Search',
              onPressed: () {}),
          IconButton(
              icon: const Icon(Icons.notifications),
              tooltip: 'Search',
              onPressed: () {})
        ],*/
      ),
      body: Container(
        child: Stack(
          children: [
            ListView.builder(
                itemCount: plantsList.length,
                itemBuilder: (context, index) {
                  return listChild(index);
                })
          ],
        ),
      ),
    );
  }

  Widget listChild(int index) {
    List<String> nameList = plantsList[index].name.toString().split('|');
    Uint8List? bytes;
    double radius = MediaQuery.of(context).size.height*.03;
    if(plantsList[index].image256 is String && plantsList[index].image256.isNotEmpty) {
      bytes = base64.decode(plantsList[index].image256);
    }
    return InkWell(
      onTap: (){
        Navigator.of(context).push(
            MaterialPageRoute(builder: (context)=>PlantScreen(plantId:plantsList[index].id.toString()))
        );
      },
      child: Card(
        elevation: 2,
        child: Row(
          children: [
            Container(
              margin: const EdgeInsets.all(12),
              child: bytes == null
                  ? CircleAvatar(
                  radius: radius, // Image radius
                  backgroundColor: Theme.of(context).primaryColor,
                  backgroundImage: const NetworkImage(
                      'https://www.ugaoo.com/cdn/shop/products/ajwain-plant-32220864446596.jpg'))
                  : ClipOval(
                child: Image.memory(
                  // Decode the base64 string into Uint8List
                  bytes,
                  width: radius*2, // Set the desired width
                  height: radius*2, // Set the desired height
                  fit: BoxFit.cover, // Adjust this to your needs
                ),
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    nameList[0].trim(),
                    style: GoogleFonts.nunito(
                        textStyle: const TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                          fontWeight: FontWeight.w400,
                        )),
                  ),
                  Text(
                    nameList[1].trim(),
                    style: GoogleFonts.nunito(
                        textStyle: const TextStyle(
                          fontSize: 12,
                          color: Color(0xff757575),
                          fontWeight: FontWeight.w400,
                        )),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class CustomAppBar extends StatefulWidget {
  const CustomAppBar({super.key,required this.plantList});

  final List<Plants> plantList;

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  TextEditingController textEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
        child:Autocomplete<Plants>(
          onSelected: (Plants plant) {
            Navigator.push(context, MaterialPageRoute(builder: (context)=>PlantScreen(plantId: plant.id.toString())));
          },
          optionsBuilder: (textEditingValue) {
            return widget.plantList.where((element) => element.name!.toLowerCase().contains(textEditingValue.text.toLowerCase()));
          },
          displayStringForOption: (Plants plant) => plant.name.toString(),
          fieldViewBuilder: (BuildContext context, TextEditingController textEditingControllerRest, FocusNode fieldFocusNode,
              VoidCallback onFieldSubmitted) {
            textEditingController = textEditingControllerRest;
            return TextField(
                autofocus: false,
                controller: textEditingController,
                focusNode: fieldFocusNode,
                textAlign: TextAlign.left,
                maxLines: 1,
                onChanged: (value) {
                },
                decoration: InputDecoration(
                    hintText: "Search Plants",
                    hintStyle: TextStyle(color: Colors.white.withOpacity(.5)),
                    border: InputBorder.none),
                style: GoogleFonts.nunito(
                    textStyle: const TextStyle(
                      fontWeight: FontWeight.w400,
                      decoration: TextDecoration.none,
                      fontSize: 18,
                      color: Colors.white,
                    )));
          },
        )
    );
  }
}

