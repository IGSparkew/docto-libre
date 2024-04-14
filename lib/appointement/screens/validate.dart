import 'package:flutter/material.dart';

import '../../componements/header.dart';

class ValidateScreen extends StatelessWidget {
  ValidateScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic>? args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;

    if (args == null || args['userUuid'] == null || args['id'] == null) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Erreur'),
        ),
        body: Center(
          child: Text('Arguments manquants'),
        ),
      );
    }

    final userUuid = args['userUuid'];
    final id = args['id'];
    return Scaffold(
      appBar: Header(),
      body: Center(),
    );
  }
}
