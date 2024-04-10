import 'package:flutter/material.dart';

import '../../componements/header.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({super.key});

  @override
  State<StatefulWidget> createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  late final TextEditingController usernameController;
  late final TextEditingController passwordController;
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    usernameController = TextEditingController();
    passwordController = TextEditingController();

  }

  Map<String, dynamic> userData = {
    'username': '',
    'password': ''
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: Header(),
        body: Center(
            child: Padding(
          padding: EdgeInsets.all(32),
          child: Form(
              key: formKey,
              child: Column(
            children: [
              Image.asset('assets/logo.png'),
              Padding(
                padding: EdgeInsets.all(64),
                child: Column(
                  children: [
                    SizedBox(
                        width: 300,
                        child: TextFormField(
                          controller: usernameController,
                          validator: (value) => value!.isNotEmpty ? null : 'Veuillez saisir un identifiant',
                          onSaved: (value) => userData['username'] = value,
                          inputFormatters: [],
                          decoration: InputDecoration(
                            labelText: 'Identifiant',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30)
                            ),
                          ),
                        )),
                    Padding(
                        padding: EdgeInsets.only(top: 32),
                        child: SizedBox(
                            width: 300,
                            child: TextFormField(
                              controller: passwordController,
                              obscureText: true,
                              validator: (value) => value!.isNotEmpty ? null : 'Veuillez saisir un mot de passe',
                              onSaved: (value) => userData['password'] = value,
                              inputFormatters: [],
                              decoration: InputDecoration(
                                  labelText: 'Mot de passe',
                                  border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30)
                                  ),
                              ),
                            )
                        )
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 32),
                        child: SizedBox(
                            width: 300,
                            child: OutlinedButton (
                                onPressed: () {
                                  if (formKey.currentState!.validate()) {
                                    formKey.currentState!.save();
                                    // TODO to delete print !!!!
                                    print(userData);
                                    formKey.currentState!.reset();
                                    Navigator.of(context).pushNamed('/appointements');
                                  }
                                },
                                child: Text('Connexion', style: TextStyle(color: Colors.black),),
                            )
                        )
                    )
                  ],
                ),
              )
            ],
          )),
        )));
  }
}
