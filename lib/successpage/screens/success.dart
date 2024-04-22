import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SuccessPage extends StatelessWidget {
  final Appointment appointment = Appointment(
    name: 'Thomas Platome',
    role: 'Généraliste',
    dateTime: DateTime.utc(2024, 5, 5, 16, 0, 0),
    location: '35 avenue de la paix 69006',
  );

  SuccessPage({Key? key}) : super(key: key);

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
    final nom = args['nom'];
    final prenom = args['prenom'];
    final specialite = args['specialite'];

    return Scaffold(
      appBar: AppBar(
        title: Text('Rendez-vous validé'),
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    child: Text(nom[0]),
                  ),
                  SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        prenom + ' ' + nom,
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        specialite,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey[600],
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
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.calendar_today),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(width: 16),
                          Expanded(
                            child: Text(
                              'Rendez-vous confirmé\n${DateFormat.yMMMMd().format(appointment.dateTime)}\n${DateFormat.jm().format(appointment.dateTime)}\n${appointment.location}',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Appointment {
  final String name;
  final String role;
  final DateTime dateTime;
  final String location;

  Appointment({
    required this.name,
    required this.role,
    required this.dateTime,
    required this.location,
  });
}

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Appointment App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SuccessPage(),
    );
  }
}
