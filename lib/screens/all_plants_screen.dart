import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../modules/notification_module.dart';
import '../modules/plant_module.dart';
import '../preference_storage/all_plants_local_preference.dart';
import '../preference_storage/notification_preferences.dart';
import 'notifications_screen.dart';
import 'plant_screen.dart';
import '../network/api_service_singelton.dart';
import '../preference_storage/storage_notifier.dart';

class AllPlantsScreen extends StatefulWidget {
  const AllPlantsScreen({super.key});

  @override
  State<AllPlantsScreen> createState() => _AllPlantsScreenState();
}

class _AllPlantsScreenState extends State<AllPlantsScreen> {
  List<Plants> plantsList = [];
  ScrollController _scrollController = ScrollController();
  bool isLoading = false;
  int currentPage=1;
  int totalPages = 10;
  bool isSearch = false;

  //list to search plants, list without pagination list
  List<Plants>? searchPlantList;

  late List<NotificationModule> notificationList;

  Future<void> callAllPlantsAPI() async {
    if (!isLoading) {
      if(currentPage!=1){
        setState(() {
          isLoading = true;
        });
      }
      var query = "{id, price, list_price, standard_price, name, description, image_256}";
      var filter = '[["categ_id", "=", "HCN Plants"]]';
      var pageSize = 50;
      var cookie = await SessionTokenPreference.getSessionToken();
      var response = await ApiServiceSingleton.instance.getPlants(
          cookie, query, filter, pageSize, currentPage);
      if (response.result != null) {
        if(currentPage==1 && response.result!=null){
          AllPlantStorage.setAllPlantsDetailed(response.result!);
        }
        setState(() {
          if(currentPage==1){
            plantsList =  response.result!;
          }else{
            plantsList.addAll(response.result as Iterable<Plants>);
          }
          totalPages = response.totalPages!;
          currentPage++;
          isLoading = false;
        });
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    AllPlantStorage.getAllPlantsDetailed().then((value){
      setState(() {
        plantsList = value;
      });
    });
    getAllPlants();
    callAllPlantsAPI();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      if(currentPage<totalPages){
        callAllPlantsAPI();
      }
    }
  }

  Future<void> getAllPlants() async {
    var plants = await AllPlantStorage.getAllPlants();
    setState(() {
      searchPlantList = plants;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: isSearch?
      AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Theme.of(context).primaryColor,
        title: searchPlantList!=null?CustomAppBar(plantList:searchPlantList!):Container(),
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
        title: Text("All Plants",
            style: GoogleFonts.nunito(
                textStyle: const TextStyle(
                    color: Colors.white, fontWeight: FontWeight.w400))),
        actions: [
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
          InkWell(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>const NotificationScreen()));
            },
            child: Center(
              child: Badge(
                largeSize: getNotificationCount().isEmpty?0:30,
                offset: const Offset(2,1),
                backgroundColor: Colors.transparent,
                label: Container(
                  padding: const EdgeInsets.all(3),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Theme.of(context).primaryColor),
                      color: Colors.white
                  ),
                  child: Text(
                      getNotificationCount(),
                      style: GoogleFonts.nunito(
                          textStyle: TextStyle(
                            fontSize: 10,
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.w400,
                          ))),
                ),
                child: IconButton(
                    icon: const Icon(Icons.notifications),
                    tooltip: 'Notifications',
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>const NotificationScreen()));
                    }),
              ),
            ),
          )
        ],
      ),
      body: Container(
        child: Stack(
          children: [
            ListView.builder(
                controller: _scrollController,
                itemCount: plantsList.length,
                itemBuilder: (context, index) {
                  return listChild(index);
                }),
            Visibility(
              visible: isLoading,
              child: Container(
                color: Colors.black.withOpacity(.75),
                width: double.infinity,
                height: double.infinity,
                child: Center(
                  child: CircularProgressIndicator(
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  String getNotificationCount(){
    var count = Provider.of<NotificationNotifier>(
        context, listen: true).notificationList.length;
    if(count==0){
      return "";
    }else{
      return count.toString();
    }

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
              autofocus: true,
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

