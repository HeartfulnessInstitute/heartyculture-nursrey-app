import 'package:flutter/material.dart';
import 'package:hcn_flutter/screens/plant_screen.dart';
import 'package:hcn_flutter/screens/splash_screen.dart';
import 'package:routemaster/routemaster.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Heartyculture Nursery',
      theme: ThemeData(
        primaryColor: const Color(0xff378564),
        //colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
       // useMaterial3: true,
      ),
      //home: const SplashScreen(),
      routerDelegate: routemaster,
      routeInformationParser: const RoutemasterParser(),
    );
  }
}

const String homeViewRoute = '/';
const String plantDetailsViewRoute = '/plant/:id';
const String notFoundViewRoute = '/404';
final routemaster = RoutemasterDelegate(
  routesBuilder: (context) {
    return RouteMap(
      onUnknownRoute: (_) => const Redirect('/404'),
      routes: {
        homeViewRoute: (_) => const MaterialPage(
          child: SplashScreen()
        ),
        plantDetailsViewRoute: (info) =>
            MaterialPage(child: PlantScreen(plantId: info.pathParameters['id']!)),
        notFoundViewRoute: (_) => MaterialPage(child: Container(height:double.infinity,width:double.infinity,color: Colors.white,)),
      },
    );
  },
);
