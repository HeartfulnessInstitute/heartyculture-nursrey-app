import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hcn_flutter/screens/all_plants_screen.dart';
import 'package:hcn_flutter/widgets/onboard_carousel.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'constants.dart';
import 'preference_storage/notification_preferences.dart';
import 'notifications/notification_controller.dart';
import 'preference_storage/my_plants_preference_notifier.dart';
import 'screens/nursery_store.dart';
import 'screens/plant_screen.dart';
import 'package:provider/provider.dart';

bool? isBoardingShown = false;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await NotificationController.initializeLocalNotifications();
  await getOnBoardingStatus().then((value) {
    isBoardingShown = value;
  });
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => MyPlantsPreferenceNotifier()),
    ChangeNotifierProvider(create: (_) => NotificationNotifier()),
  ], child: const MyApp()));
  //initUniLinks();
}

class MyApp extends StatelessWidget {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

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
      routerConfig: router,
      debugShowCheckedModeBanner: false,
    );
  }
}

Future<bool?> getOnBoardingStatus() async {
  final Future<SharedPreferences> sharedPreferenceInstance =
      SharedPreferences.getInstance();
  final SharedPreferences preference = await sharedPreferenceInstance;
  return preference.getBool(Constants.ONBOARD_PREFERENCE_KEY);
}

final router = GoRouter(
  navigatorKey: MyApp.navigatorKey,
  routes: [

    GoRoute(
        path: '/plants',
        builder: (context, state) {
          var plantId = state.uri.queryParameters['id'];
          if (plantId != null) {
            return PlantScreen(plantId: plantId);
          } else {
            // Handle the case where 'id' parameter is missing or null
            // For example, you can show an error message or navigate to a default screen
            return             AllPlantsScreen();

        }

        }
        ),

    GoRoute(
        path: '/',
        builder: (context, state) {
          return (isBoardingShown != null && isBoardingShown!)
              ? const NurseryStore()
              : const OnboardCarousel();
        }),
  ],
);

