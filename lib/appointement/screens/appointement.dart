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
        title: Text('Rendez-vous'),
      ),
      body: FutureBuilder(
        future: fetchData(id),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Text('Erreur : ${snapshot.error}');
          } else if (snapshot.data == null) {
            return Text('Aucune donnée à afficher');
          } else {
            return Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          child: Text(snapshot.data['nom'][0]),
                        ),
                        SizedBox(width: 16),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              snapshot.data['prenom'] +
                                  ' ' +
                                  snapshot.data['nom'],
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                    Container(
                      width: 390,
                      height: 500,
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        color: Colors.grey[300],
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                snapshot.data['description']! +
                                    (snapshot.data['vital_card'] == '1'
                                        ? ' et prends la carte vitale'
                                        : ''),
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey[600],
                                ),
                              ),
                              SizedBox(height: 16),
                              Row(
                                mainAxisAlignment: MainAxisAlignment
                                    .center,
                                children: [
                                  ElevatedButton(
                                    onPressed: () {
                                      Navigator.pushNamed(context, '/success',
                                          arguments: {
                                            'userUuid': userUuid,
                                            'id': id,
                                            'nom': snapshot.data['nom'],
                                            'prenom': snapshot.data['prenom'],
                                            'specialite':
                                                snapshot.data['specialty']
                                          });
                                    },
                                    child: Text('Valider'),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
