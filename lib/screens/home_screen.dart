// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'all_plants_screen.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: SafeArea(
          child: selectedPageIndex == 0 ? AllPlantsScreen() : Container()),
    );
  }
}
