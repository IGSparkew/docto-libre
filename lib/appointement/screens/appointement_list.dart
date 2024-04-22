import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AppointementListScreen extends StatefulWidget {
  @override
  _AppointementListScreenState createState() => _AppointementListScreenState();
}

class _AppointementListScreenState extends State<AppointementListScreen> {
  Future fetchData() async {
    final response = await http.get(
        Uri.https('aucoindufeu.myasustor.com:442', '/api/specialist/lire'));
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

    if (args == null || args['userUuid'] == null) {
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

    return Scaffold(
      appBar: AppBar(
        title: Text('Liste des rendez-vous'),
      ),
      body: FutureBuilder(
        future: fetchData(),
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
            return ListView.builder(
              itemBuilder: (context, index) {
                // Afficher chaque élément de la liste
                if (index < snapshot.data.length) {
                  return ListTile(
                    title: Text(snapshot.data[index]['nom']),
                    subtitle: Text(snapshot.data[index]['description']),
                    onTap: () {
                      Navigator.pushNamed(context, '/appointement', arguments: {
                        'userUuid': userUuid,
                        'id': snapshot.data[index]['id']
                      });
                    },
                    trailing: Icon(Icons.arrow_forward),
                  );
                }
                return null;
              },
            );
          }
        },
      ),
    );
  }
}


//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Liste de Spécialistes'),
//       ),
//       body: StreamBuilder(
//         stream: specialistsCollection.snapshots(),
//         builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
//           if (!snapshot.hasData) {
//             return Center(child: CircularProgressIndicator());
//           }

//           final specialists = snapshot.data!.docs
//               .map((doc) => doc.data() as Map<String, dynamic>)
//               .toList();
//           return ListView.builder(
//             itemCount: specialists.length,
//             itemBuilder: (context, index) {
//               var specialist = specialists[index];

//               return ListTile(
//                 title: Text('${specialist['nom']} ${specialist['prenom']}'),
//                 subtitle: Text(specialist['description']),
//                 onTap: () {
//                   Navigator.pushNamed(context, '/appointement');
//                 },
//                 trailing: Icon(Icons.arrow_forward),
//               );
//             },
//           );
//         },
//       ),
//     );
//   }
// }
