import 'package:flutter/material.dart';


class LoginFailedComponement extends StatelessWidget {
  LoginFailedComponement({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(bottom: 32),
        child: Container(
          width: 400,
          height: 100,
          decoration: BoxDecoration(
            color: Color.fromRGBO(255, 51, 51, 0.05),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.red, width: 2),
          ),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Identifiant ou mot de passe incorrect',style: TextStyle(color: Color.fromRGBO(255, 51, 51, 1), decorationStyle: TextDecorationStyle.solid))
              ]
          ),
        ));
  }
}