import 'package:auth_app_riverpod/firebase_options.dart';
import 'package:auth_app_riverpod/root.dart';
import 'package:auth_app_riverpod/router.dart';
import 'package:auth_app_riverpod/ui/splash/splash_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = ColorScheme.fromSeed(seedColor: Colors.yellow);
    return MaterialApp(
      title: 'My App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          colorScheme: colorScheme,
          primaryColor: colorScheme.primary,
          useMaterial3: true,
          buttonTheme: const ButtonThemeData(
              shape: StadiumBorder(), textTheme: ButtonTextTheme.primary),
          textTheme: const TextTheme(
            headlineLarge: TextStyle(fontWeight: FontWeight.bold),
          ),
          inputDecorationTheme: const InputDecorationTheme(
            border: OutlineInputBorder(),
          )),
      initialRoute: SplashPage.route,
      onGenerateRoute: AppRouter.onNavigate,
    );
  }
}
