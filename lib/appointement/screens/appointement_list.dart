import 'package:flutter/material.dart';

import '../../componements/header.dart';

class AppointementListScreen extends StatelessWidget {
  AppointementListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Header(),
      body: Center(
        child: Text('Hello World!'),
      ),
    );
  }
}