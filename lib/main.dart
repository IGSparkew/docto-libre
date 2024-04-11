import 'package:docto_libre/appointement/screens/appointement.dart';
import 'package:flutter/material.dart';

import 'appointement/screens/appointement_list.dart';
import 'authentification/screens/login.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Docto Libre',
      theme: ThemeData(scaffoldBackgroundColor: Color(0xFFF1F7FE), primaryColor: Color(0xFF004080),),
      initialRoute: '/',
      routes: {
        '/': (context) => LoginScreen(),
        '/appointements': (context) => AppointementListScreen(),
        '/appointement': (context) => AppointementScreen(),
      },
    );
  }
}
