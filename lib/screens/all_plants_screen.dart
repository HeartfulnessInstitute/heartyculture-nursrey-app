
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../constants.dart';
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
  bool isSearch = false;

  late List<NotificationModule> notificationList;

  late Map<String, String> headersMap;

  Future<void> callAllPlantsAPI() async {
      var query = "{id, name, description}";
      var filter = '[["categ_id", "=", "HCN Plants"]]';
      var pageSize = 50000;
      var cookie = await SessionTokenPreference.getSessionToken();
      var response = await ApiServiceSingleton.instance.getPlants(
          cookie, query, filter, pageSize, 1);
      if (response.result != null) {
        AllPlantStorage.setAllPlants(response.result!);
          setState(() {
            plantsList = response.result!;
          });
      }
  }

  @override
  void initState() {
    super.initState();
    SessionTokenPreference.getSessionToken().then((value){
      setState(() {
        headersMap = {'Cookie': value};
      });
    });
    AllPlantStorage.getAllPlants().then((value){
      setState(() {
       plantsList = value;
      });
    });
    callAllPlantsAPI();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: isSearch?
      AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Theme.of(context).primaryColor,
        title: CustomAppBar(plantList:plantsList),
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
                itemCount: plantsList.length,
                itemBuilder: (context, index) {
                  return listChild(index);
                }),
            Visibility(
              visible: false,
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

