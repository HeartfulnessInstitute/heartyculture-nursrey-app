
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hcn_flutter/inventory/network/api_service_inventory_singelton.dart';
import 'package:hcn_flutter/inventory/preference_storage/all_plants_local_preference.dart';
import 'package:hcn_flutter/inventory/screens/variants_screen.dart';
import 'package:hcn_flutter/screens/plant_screen.dart';
import '../../constants.dart';
import '../../preference_storage/storage_notifier.dart';
import '../modules/plant_variants_module.dart';

class AllPlantsInventoryScreen extends StatefulWidget {
  const AllPlantsInventoryScreen({super.key});

  @override
  State<AllPlantsInventoryScreen> createState() =>
      _AllPlantsInventoryScreenState();
}

class _AllPlantsInventoryScreenState extends State<AllPlantsInventoryScreen> {
  List<PlantVariants> plantVariantsList = [];
  List<PlantVariants> categorisedPlantVariantsList = [];
  bool isSearch = false;
  TextEditingController textEditingController = TextEditingController();
  late Map<String, String> headersMap;
  int selectedCategoryIndex = 0;

  List <ValueIds> ttt = [];

  List<ValueIds> fff = [];

  Future<void> callAllPlantVariantsAPI() async {
    var query = "{id, name, base_unit_count, product_variant_count, attribute_line_ids{display_name, value_ids{name}}}";
    var filter = '[["categ_id", "like", "HCN Plants /"]]';
    var pageSize = 50000;
    var cookie = await SessionTokenPreference.getSessionToken();

    var response = await ApiServiceInventorySingleton.instance
        .getInventoryPlants(cookie, query, filter, pageSize, 1);
    if (response.result != null) {
      AllPlantStorage.setAllPlants(response.result!);
      setState(() {
        plantVariantsList = response.result!;
        categorisedPlantVariantsList = plantVariantsList;

        ttt = categorisedPlantVariantsList[2].attributeLineIds![0].valueIds!;

        // fff= ttt[0].valueIds!;

        // ttt =

        print('API Response data');
        // print(fff[1].name);
        // print(PlantVariants.fromJson(response.result.);
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
        plantVariantsList = value;
        selectedCategoryIndex = 0;
      });
    });

    callAllPlantVariantsAPI();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: isSearch
          ? AppBar(
              automaticallyImplyLeading: false,
              backgroundColor: Theme.of(context).primaryColor,
              title: customAppBar(),
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
              leadingWidth: 30,
              leading: Padding(
                padding: const EdgeInsets.only(left: 10),
                child: IconButton(
                  icon: Icon(Icons.arrow_back_ios),
                  onPressed: () {
                    // Navigator.pop(context);
                  },
                ),
              ),
              title: Text('All Plants',
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
                      print(categorisedPlantVariantsList);
                      //  showFilterList(context);
                    }),
              ],
            ),
      body: Container(
        child: Stack(
          children: [
            ListView.builder(
                itemCount: categorisedPlantVariantsList.length,
                itemBuilder: (context, index) {
                  return listChild(index);
                }),
            Visibility(
              visible: categorisedPlantVariantsList.length == 0,
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

  Widget listChild(int index) {
    List<String> nameList =
        categorisedPlantVariantsList[index].name.toString().split('|');
    double radius = MediaQuery.of(context).size.height * .04;
    return InkWell(
      onTap: () {
        print(nameList);
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => VariantsScreen(
                  plantId: categorisedPlantVariantsList[index].id.toString(),
                  plantVariantsNumber: categorisedPlantVariantsList[index].productVariantCount,
                  plantUrl: '${Constants.imageBaseURL}${categorisedPlantVariantsList[index].id.toString()}&field=image_128',
                  plantVariantsValueId: categorisedPlantVariantsList[index].attributeLineIds![0].valueIds!,
                )));
      },

      child: Card(
        elevation: 2,
        margin: EdgeInsets.only(left: 12, right: 12, top: 5, bottom: 5),
        child: Row(
          children: [
            Container(
                margin: const EdgeInsets.all(12),
                child: CircleAvatar(
                    radius: radius, // Image radius
                    backgroundColor: Theme.of(context).primaryColor,
                    backgroundImage: NetworkImage(
                        '${Constants.imageBaseURL}${categorisedPlantVariantsList[index].id.toString()}&field=image_128',
                        headers: headersMap))
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
                  IntrinsicHeight(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'Variants: ${categorisedPlantVariantsList[index].productVariantCount}',
                          style: GoogleFonts.nunito(
                              textStyle: const TextStyle(
                            fontSize: 13,
                            color: Color(0xff757575),
                            fontWeight: FontWeight.w400,
                          )),
                        ),
                        VerticalDivider(
                          color: Color(
                            0xff757575,
                          ),
                          thickness: 1.5,
                          indent: 4,
                          endIndent: 3,
                        ),
                        Text(
                          'Units: ${categorisedPlantVariantsList[index].baseUnitCount}',
                          style: GoogleFonts.nunito(
                              textStyle: const TextStyle(
                            fontSize: 13,
                            color: Color(0xff757575),
                            fontWeight: FontWeight.w400,
                          )),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget customAppBar() {
    return Container(
        child: Autocomplete<PlantVariants>(
      onSelected: (PlantVariants plant) {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    PlantScreen(plantId: plant.id.toString())));
        setState(() {
          isSearch = false;
        });
      },
      optionsBuilder: (textEditingValue) {
        return plantVariantsList.where((element) => element.name!
            .toLowerCase()
            .contains(textEditingValue.text.toLowerCase()));
      },
      displayStringForOption: (PlantVariants plant) => plant.name.toString(),
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
