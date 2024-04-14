import 'package:flutter/material.dart';

import '../../componements/header.dart';

class AppointementListScreen extends StatelessWidget {
  AppointementListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic>? args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;

    // Vérifiez si les arguments nécessaires sont présents
    if (args == null || args['userUuid'] == null) {
      // Gérer le cas où les arguments requis sont manquants
      return Scaffold(
        appBar: AppBar(
          title: Text('Erreur'),
        ),
        body: Center(
          child: Text('Arguments manquants'),
        ),
      );
    }

    // Utilisez les arguments comme vous le souhaitez
    final userUuid = args['userUuid'];
    return Scaffold(
      appBar: Header(),
      body: ListView(
        children: [
          CustomCard(
            id: '0',
            title: 'Carte 1',
            subTitle: 'Sous-titre de la carte 1',
            description: 'Description de la carte 1',
            userUuid: userUuid,
          ),
          CustomCard(
            id: '1',
            title: 'Carte 2',
            subTitle: 'Sous-titre de la carte 2',
            description: 'Description de la carte 2',
            userUuid: userUuid,
          ),
          CustomCard(
            id: '2',
            title: 'Carte 3',
            subTitle: 'Sous-titre de la carte 3',
            description: 'Description de la carte 3',
            userUuid: userUuid,
          ),
        ],
      ),
    );
  }
}

class CustomCard extends StatelessWidget {
  final String id;
  final String title;
  final String subTitle;
  final String description;
  final String userUuid;

  const CustomCard({
    required this.id,
    required this.title,
    required this.subTitle,
    required this.description,
    required this.userUuid,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(title),
        subtitle: Text(description),
        onTap: () {
          Navigator.pushNamed(context, '/appointement',
              arguments: {'userUuid': userUuid, 'id': id});
        },
        trailing: Icon(Icons.arrow_forward),
      ),
    );
  }
}
