import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'notofications/notification_controller.dart';
import 'preference_storage/my_plants_preference_notifier.dart';
import 'screens/plant_screen.dart';
import 'screens/splash_screen.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await NotificationController.initializeLocalNotifications();
  runApp(
      MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) => MyPlantsPreferenceNotifier()),
          ],
        child:const MyApp()
      ));
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