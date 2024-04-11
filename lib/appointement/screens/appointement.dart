import 'package:flutter/material.dart';

import '../../componements/header.dart';


class AppointementScreen extends StatelessWidget {
  AppointementScreen({Key? key}) : super(key: key);

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