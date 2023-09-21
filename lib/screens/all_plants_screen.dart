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
  List<Plants> categorisedPlantsList = [];
  List<String> plantCategories = [];
  int selectedCategoryIndex = 0;
  bool isSearch = false;
  String allPlantsText = 'All Plants';

  late List<NotificationModule> notificationList;

  late Map<String, String> headersMap;

  Future<void> callAllPlantsAPI() async {
    var query = "{id, name, categ_id{name}}";
    var filter = '[["categ_id", "like", "HCN Plants /"]]';
    var pageSize = 50000;
    var cookie = await SessionTokenPreference.getSessionToken();
    var response = await ApiServiceSingleton.instance
        .getPlants(cookie, query, filter, pageSize, 1);
    if (response.result != null) {
      AllPlantStorage.setAllPlants(response.result!);
      setState(() {
        plantsList = response.result!;
        categorisedPlantsList = plantsList;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    SessionTokenPreference.getSessionToken().then((value) {
      setState(() {
        headersMap = {'Cookie': value};
      });
    });
    AllPlantStorage.getAllPlants().then((value) {
      setState(() {
        plantsList = value;
        selectedCategoryIndex = 0;
      });
    });
    callAllPlantsAPI();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: isSearch
          ? AppBar(
              automaticallyImplyLeading: false,
              backgroundColor: Theme.of(context).primaryColor,
              title: CustomAppBar(plantList: plantsList),
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
            )
          : AppBar(
              automaticallyImplyLeading: false,
              backgroundColor: Theme.of(context).primaryColor,
              title: Text((plantCategories.isNotEmpty)?'${plantCategories[selectedCategoryIndex]} (${categorisedPlantsList.length})':'All Plants',
                  style: GoogleFonts.nunito(
                      textStyle: const TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w400))),
              actions: [
                IconButton(
                    icon: const Icon(Icons.search),
                    tooltip: 'Search',
                    onPressed: () {
                      setState(() {
                        isSearch = true;
                      });
                    }),
                IconButton(
                    icon: const Icon(Icons.sort),
                    tooltip: 'Filter',
                    onPressed: () {
                      showFilterList(context);
                    }),
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const NotificationScreen()));
                  },
                  child: Center(
                    child: Badge(
                      largeSize: getNotificationCount().isEmpty ? 0 : 30,
                      offset: const Offset(2, 1),
                      backgroundColor: Colors.transparent,
                      label: Container(
                        padding: const EdgeInsets.all(3),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                                color: Theme.of(context).primaryColor),
                            color: Colors.white),
                        child: Text(getNotificationCount(),
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
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const NotificationScreen()));
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
                itemCount: categorisedPlantsList.length,
                itemBuilder: (context, index) {
                  return listChild(index);
                }),
            Visibility(
              visible: categorisedPlantsList.length==0,
              child: Container(
                // color: Colors.black.withOpacity(.75),
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

  void showFilterList(BuildContext context) {
    if (plantCategories.length == 0) {
      preparePlantCategories();
    }
    showDialog(
      context: context,
      barrierDismissible: true,
      // Prevent users from dismissing the dialog by tapping outside
      builder: (BuildContext context) {
        return AlertDialog(
            contentPadding: EdgeInsets.zero,
            scrollable: true,
            content: StatefulBuilder(
                builder: (BuildContext context, StateSetter setStateDialog) {
              return Container(
                width: MediaQuery.of(context).size.width * .75,
                color: Colors.grey,
                child: Column(
                  children: [
                    Container(
                      color: Theme.of(context).primaryColor,
                      padding: const EdgeInsets.only(
                          top: 10, bottom: 10, left: 15, right: 15),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text("Categories",
                                style: GoogleFonts.nunito(
                                    textStyle: const TextStyle(
                                        fontSize: 20,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w400))),
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.of(context).pop();
                            },
                            child: const Icon(
                              Icons.close,
                              color: Colors.white,
                              size: 22,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * .6,
                      child: SingleChildScrollView(
                        child: Column(
                          children: [...getCategories(context, setStateDialog)],
                        ),
                      ),
                    )
                  ],
                ),
              );
            }));
      },
    );
  }

  String getNotificationCount() {
    var count = Provider.of<NotificationNotifier>(context, listen: true)
        .notificationList
        .length;
    if (count == 0) {
      return "";
    } else {
      return count.toString();
    }
  }

  Widget listChild(int index) {
    List<String> nameList =
        categorisedPlantsList[index].name.toString().split('|');
    double radius = MediaQuery.of(context).size.height * .04;
    return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => PlantScreen(
                plantId: categorisedPlantsList[index].id.toString())));
      },
      child: Card(
        elevation: 2,
        margin: EdgeInsets.only(left: 12,right: 12,top: 5,bottom: 5),
        child: Row(
          children: [
            Container(
                margin: const EdgeInsets.all(12),
                child: CircleAvatar(
                    radius: radius, // Image radius
                    backgroundColor: Theme.of(context).primaryColor,
                    backgroundImage: NetworkImage(
                        '${Constants.imageBaseURL}${categorisedPlantsList[index].id.toString()}&field=image_128',
                        headers: headersMap))),
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
                  Padding(
                    padding: const EdgeInsets.only(bottom: 2.0),
                    child: Text(
                      nameList[1].trim(),
                      style: GoogleFonts.nunito(
                          textStyle: const TextStyle(
                        fontSize: 15,
                        color: Color(0xff757575),
                        fontWeight: FontWeight.w400,
                      )),
                    ),
                  ),
                  Text(
                    categorisedPlantsList[index].category!.name!,
                    style: GoogleFonts.nunito(
                        textStyle: const TextStyle(
                          fontSize: 12,
                          color: Color(0xff424242),
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

  List<Widget> getCategories(BuildContext dialogContext, StateSetter setStateDialog) {
    List<Widget> categories = [];
    for (var i = 0; i < plantCategories.length; i++) {
      categories.add(InkWell(
        onTap: () {
          setStateDialog(() {
            selectedCategoryIndex = i;
          });
          setState(() {
            categorisedPlantsList = getPlantsByCategory(plantCategories[i]);
          });
          Navigator.of(dialogContext).pop();
        },
        child: Container(
          color: Colors.white,
          padding:
              const EdgeInsets.only(top: 10, bottom: 10, left: 15, right: 15),
          child: Row(
            children: [
              Expanded(
                child: Text(plantCategories[i],
                    style: GoogleFonts.nunito(
                        textStyle: const TextStyle(
                            fontSize: 18,
                            color: Colors.black87,
                            fontWeight: FontWeight.w400))),
              ),
              Container(
                padding: EdgeInsets.all(2),
                width: 30,
                height: 30,
                child: (i == selectedCategoryIndex)
                    ? Icon(
                        Icons.done,
                        color: Colors.white,
                        size: 18,
                      )
                    : null,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: (i == selectedCategoryIndex)
                        ? Theme.of(context).primaryColor
                        : Colors.grey.shade100),
              )
            ],
          ),
        ),
      ));
    }
    return categories;
  }

  void preparePlantCategories() {
    plantCategories.clear();
    for (var i = 0; i < plantsList.length; i++) {
      if (!plantCategories.contains(plantsList[i].category!.name!)) {
        plantCategories.add(plantsList[i].category!.name!);
      }
    }
    plantCategories.sort((a, b) => a.toString().compareTo(b.toString()));
    plantCategories.insert(0, allPlantsText);
    print(plantCategories.length);
  }

  List<Plants> getPlantsByCategory(String plantCategory) {
    if (plantCategory == allPlantsText) {
      return plantsList;
    }
    List<Plants> newPlantList = [];
    for (var i = 0; i < plantsList.length; i++) {
      if (plantCategory == plantsList[i].category!.name) {
        newPlantList.add(plantsList[i]);
      }
    }
    return newPlantList;
  }
}

class CustomAppBar extends StatefulWidget {
  const CustomAppBar({super.key, required this.plantList});

  final List<Plants> plantList;

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Autocomplete<Plants>(
      onSelected: (Plants plant) {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    PlantScreen(plantId: plant.id.toString())));
      },
      optionsBuilder: (textEditingValue) {
        return widget.plantList.where((element) => element.name!
            .toLowerCase()
            .contains(textEditingValue.text.toLowerCase()));
      },
      displayStringForOption: (Plants plant) => plant.name.toString(),
      fieldViewBuilder: (BuildContext context,
          TextEditingController textEditingControllerRest,
          FocusNode fieldFocusNode,
          VoidCallback onFieldSubmitted) {
        textEditingController = textEditingControllerRest;
        return TextField(
            autofocus: true,
            controller: textEditingController,
            focusNode: fieldFocusNode,
            textAlign: TextAlign.left,
            maxLines: 1,
            onChanged: (value) {},
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
    ));
  }
}
