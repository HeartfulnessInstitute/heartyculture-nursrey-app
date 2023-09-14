// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import '../network/api_service_singelton.dart';
import '../preference_storage/all_plants_local_preference.dart';
import '../preference_storage/storage_notifier.dart';
import 'all_plants_screen.dart';
import 'my_plants_screen.dart';
import 'qr_code_scanner.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
      color: Theme.of(context).primaryColor,
    ));
  }

  Future<void> getAllPlants() async {
      var query = "{id,name}";
      var filter = '[["categ_id", "=", "HCN Plants"]]';
      var pageSize = 50000;
      var cookie = await SessionTokenPreference.getSessionToken();
      var response = await ApiServiceSingleton.instance.getPlants(
          cookie, query, filter, pageSize, 1);
      if (response.result != null) {
        AllPlantStorage.setAllPlants(response.result!);
      }
    }

    @override
  void initState() {
    super.initState();
    getAllPlants();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(builder:(context)=>QRCodeScanner()));
        },
        child: Icon(Icons.qr_code),
      ),
      bottomNavigationBar: NavigationBarTheme(
        data: NavigationBarThemeData(
            indicatorColor: Color(0x1A348562),
            backgroundColor: Color(0xffffffff),
            labelTextStyle: MaterialStateProperty.resolveWith(getStyle)),
        child: NavigationBar(
          elevation: 20,
          selectedIndex: selectedPageIndex,
          onDestinationSelected: (int index) {
            if (index == 2) {
              return;
            }
            setState(() {
              selectedPageIndex = index;
            });
          },
          destinations: <NavigationDestination>[
            NavigationDestination(
              selectedIcon: SvgPicture.asset("assets/images/plant_icon.svg"),
              icon: SvgPicture.asset("assets/images/plant_icon.svg"),
              label: 'All Plants',
            ),
            NavigationDestination(
              selectedIcon:
                  Icon(Icons.star, color: Theme.of(context).primaryColor),
              icon: Icon(Icons.star, color: Theme.of(context).primaryColor),
              label: 'My Plants',
            )
          ],
        ),
      ),
      body: IndexedStack(
          index: selectedPageIndex,
          children: const [
            AllPlantsScreen(),
            MyPlantsScreen()
          ]),
    );
  }
}
