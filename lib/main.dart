import 'package:docto_libre/appointement/screens/appointement.dart';
import 'package:docto_libre/appointement/screens/validate.dart';
import 'package:docto_libre/firebase_options.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'appointement/screens/appointement_list.dart';
import 'authentification/screens/login.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
     options: DefaultFirebaseOptions.currentPlatform,
  );
  await FirebaseAppCheck.instance.activate(
      webProvider: ReCaptchaV3Provider('recaptcha-v3-site-key'),
      androidProvider: AndroidProvider.debug,
      appleProvider: AppleProvider.appAttest);

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Docto Libre',
      theme: ThemeData(
        scaffoldBackgroundColor: Color(0xFFF1F7FE),
        primaryColor: Color(0xFF004080),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => LoginScreen(),
        '/appointements': (context) => AppointementListScreen(),
        '/appointement': (context) => AppointementScreen(),
        '/validate':(context) => ValidateScreen(),
      },
    );
  }
}
