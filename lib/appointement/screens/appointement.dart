import 'package:flutter/material.dart';

import '../../componements/header.dart';

class AppointementScreen extends StatelessWidget {
  AppointementScreen({Key? key}) : super(key: key);

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
    List<Map<String, String>> liste(String userUuid) {
      return [
        {
          'id': '0',
          'title': 'Carte 1',
          'subTitle': 'Sous-titre de la carte 1',
          'description': 'Description de la carte 1',
          'userUuid': userUuid,
        },
        {
          'id': '1',
          'title': 'Carte 2',
          'subTitle': 'Sous-titre de la carte 2',
          'description': 'Description de la carte 2',
          'userUuid': userUuid,
        },
        {
          'id': '2',
          'title': 'Carte 3',
          'subTitle': 'Sous-titre de la carte 3',
          'description': 'Description de la carte 3',
          'userUuid': userUuid,
        },
      ];
    }

    List<Map<String, String>> simpleList = liste(userUuid);
    Map<String, String>? selectedItem;
    for (var item in simpleList) {
      if (item['id'] == id) {
        selectedItem = item;
        break;
      }
    }
    if (selectedItem != null) {
      return Scaffold(
        appBar: Header(),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(selectedItem['title']!),
              Text(selectedItem['description']!),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/validate',
                      arguments: {'userUuid': userUuid, 'id': id});
                },
                child: Text('Valider'),
              ),
            ],
          ),
        ),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          title: Text('Erreur'),
        ),
        body: Center(
          child: Text('Item non trouvé'),
        ),
      );
    }
  }
}
