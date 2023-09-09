import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'screens/plant_screen.dart';
import 'screens/splash_screen.dart';


void main() {
  runApp(const MyApp());
  //initUniLinks();
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
        routerConfig: router
    );
  }
}

final router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (_, __) => const SplashScreen(),
    ),
    GoRoute(
        path: '/plant/:id',
        builder: (context, state) {
          var plantId = state.params['id'];
          return PlantScreen(plantId: plantId!);
        }),
  ],
);