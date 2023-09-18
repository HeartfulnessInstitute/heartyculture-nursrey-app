
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../constants.dart';
import '../modules/plant_module.dart';
import '../preference_storage/my_plants_preference_notifier.dart';
import '../preference_storage/storage_notifier.dart';
import 'plant_screen.dart';

class MyPlantsScreen extends StatefulWidget {
  const MyPlantsScreen({super.key});

  @override
  State<MyPlantsScreen> createState() => _MyPlantsScreenState();
}

class _MyPlantsScreenState extends State<MyPlantsScreen> {
  List<Plants> plantsList = [];
  bool isSearch = false;

  late Map<String, String> headersMap;

  @override
  void initState() {
    super.initState();
    SessionTokenPreference.getSessionToken().then((value){
      setState(() {
        headersMap = {'Cookie': value};
      });
    });
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
    double radius = MediaQuery.of(context).size.height*.03;
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
              child: CircleAvatar(
                  radius: radius, // Image radius
                  backgroundColor: Theme.of(context).primaryColor,
                  backgroundImage: NetworkImage(
                      '${Constants.imageBaseURL}${plantsList[index].id.toString()}&field=image_128',
                      headers: headersMap)
              )
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

