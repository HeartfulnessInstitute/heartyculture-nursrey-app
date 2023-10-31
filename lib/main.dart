import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hcn_flutter/inventory/screens/all_plants_inventory_screen.dart';
import 'package:hcn_flutter/network/api_service_singelton.dart';
import 'package:hcn_flutter/preference_storage/storage_notifier.dart';
import 'package:hcn_flutter/widgets/onboard_carousel.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'constants.dart';
import 'inventory/network/api_service_inventory_singelton.dart';
import 'modules/session_module.dart';
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
        path: '/',
        builder: (context, state) {

          try {
            SessionModule sessionModule = SessionModule();
            Params params = Params();
            params.db = Constants.db;
            params.login =  Constants.login;
            params.password = Constants.password;
            sessionModule.params = params;
            ApiServiceInventorySingleton.instance
                .getSessionCookie(sessionModule)
                .then((response) {
              // hideLoadingDialog(context);
              final cookies = response.response.headers['set-cookie'];
              List<String>? parts = cookies?[0].split(';');
              String? sessionId = parts?[0].trim();
              if (sessionId != null) {
                SessionTokenPreference.setSessionToken(sessionId)
                    .then((value) {

                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const AllPlantsInventoryScreen()));
                });
              }
            });
          } catch (e) {
            //error
          }

         return AllPlantsInventoryScreen();

         // return   (isBoardingShown != null && isBoardingShown!)
         //      ? const AllPlantsInventoryScreen()
         //      : const AllPlantsInventoryScreen();
        }),
    GoRoute(
        path: '/plant/:id',
        builder: (context, state) {
          var plantId = state.params['id'];
          return PlantScreen(plantId: plantId!);
        }),
  ],
);

void hideLoadingDialog(BuildContext context) {
  Navigator.of(context).pop(); // Close the dialog
}

void showLoadingDialog(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false, // Prevent users from dismissing the dialog by tapping outside
    builder: (BuildContext context) {
      return AlertDialog(
        content: Row(
          children: <Widget>[
            CircularProgressIndicator(
              color: Theme.of(context).primaryColor,
            ),
            const SizedBox(width: 20),
            Text("Getting Plants...",
                style: GoogleFonts.nunito(
                    textStyle: const TextStyle(
                        fontSize: 18,
                        color: Color(0xff212121),
                        fontWeight: FontWeight.w400))
            ),
          ],
        ),
      );
    },
  );
}
