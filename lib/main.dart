import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';
import 'package:get_storage/get_storage.dart';
import 'package:the_movie_box/core/routes/routes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'core/client/api_client.dart';
import 'package:firebase_performance/firebase_performance.dart';

final getIt = GetIt.instance;
final navigatorKey = GlobalKey<NavigatorState>();
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  await GetStorage.init();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await initializeClient();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  FirebasePerformance performance = FirebasePerformance.instance;
  FlutterError.onError = (errorDetails) {
    FirebaseCrashlytics.instance.recordFlutterError(errorDetails);
  };
  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack);
    return true;
  };
  runApp(MyApp());
}

Future<void> initializeClient() async {
  final apiClient = ApiClient();
  getIt.registerSingleton<ApiClient>(apiClient);
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  final approuter = AppRouter();
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
        title: 'Movie Box',
        theme: ThemeData.dark(
          useMaterial3: true,
        ),
        routeInformationParser: approuter.router.routeInformationParser,
        routeInformationProvider: approuter.router.routeInformationProvider,
        routerDelegate: approuter.router.routerDelegate,
        backButtonDispatcher: RootBackButtonDispatcher());
  }
}
