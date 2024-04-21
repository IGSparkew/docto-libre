import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AppointementScreen extends StatefulWidget {

  AppointementScreen({Key? key}) : super(key: key);

  @override
  _AppointementScreenState createState() => _AppointementScreenState();
}

class _AppointementScreenState extends State<AppointementScreen> {
  Future fetchData(int id) async {
    Map<String, dynamic> requestBody = {'id': id};
    String requestBodyJson = jsonEncode(requestBody);
    final response = await http.post(
      Uri.https('aucoindufeu.myasustor.com:442', '/api/specialist/lireUn'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: requestBodyJson,
    );
    if (response.statusCode == 200) {
      dynamic jsonData = jsonDecode(response.body);
      print(jsonData);
      return jsonData['data'];
    } else {
      throw Exception('Failed to load data');
    }
  }

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
      appBar: AppBar(
        title: Text('Liste des rendez-vous'),
      ),
      body: FutureBuilder(
          future: fetchData(id),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child:
                    CircularProgressIndicator(), // Afficher un indicateur de chargement
              );
            } else if (snapshot.hasError) {
              return Text('Erreur : ${snapshot.error}'); // Gérer les erreurs
            } else if (snapshot.data == null) {
              return Text('Aucune donnée à afficher');
            } else {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(snapshot.data['nom']!),
                    Text(snapshot.data['description']!),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/validate',
                            arguments: {'userUuid': userUuid, 'id': id});
                      },
                      child: Text('Valider'),
                    ),
                  ],
                ),
              );
            }
          }),
    );
  }
}