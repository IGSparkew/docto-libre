import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../componements/header.dart';
import '../components/loginfailedcomponement.dart';
import 'login_controller.dart';

// login screen
class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Header(),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: LoginForm(),
        ),
      ),
    );
  }
}

class LoginForm extends StatelessWidget {
  LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.read<LoginController>();

    return Form(child: Builder(
      builder: (context) {
        return Column(
          children: [
            Image.asset('assets/logo.png'),
            Padding(
              padding: EdgeInsets.all(64),
              child: Column(
                children: [
                  if (controller.value.isFailed()) LoginFailedComponement(),
                  SizedBox(
                      width: 300,
                      child: TextFormField(
                        controller: controller.mailController,
                        validator: (value) => value!.isNotEmpty
                            ? null
                            : 'Veuillez saisir un identifiant',
                        //onSaved: (value) => userData['username'] = value,
                        inputFormatters: [],
                        decoration: InputDecoration(
                          labelText: 'Identifiant',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30)),
                        ),
                      )),
                  Padding(
                      padding: EdgeInsets.only(top: 32),
                      child: SizedBox(
                          width: 300,
                          child: TextFormField(
                            controller: controller.passwordController,
                            obscureText: true,
                            validator: (value) => value!.isNotEmpty
                                ? null
                                : 'Veuillez saisir un mot de passe',
                            // onSaved: (value) =>
                            // userData['password'] = value,
                            inputFormatters: [],
                            decoration: InputDecoration(
                              labelText: 'Mot de passe',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30)),
                            ),
                          ))),
                  Padding(
                      padding: EdgeInsets.only(top: 32),
                      child: SizedBox(width: 300, child: ValidateButton()))
                ],
              ),
            )
          ],
        );
      },
    ));
  }
}

class ValidateButton extends StatelessWidget {
  ValidateButton({super.key});

  get onSuccess => null;

  @override
  Widget build(BuildContext context) {
    final controller = context.read<LoginController>();
    final form = Form.of(context);

    return OutlinedButton(
      onPressed: () async {
        if (form.validate()) {
          controller.login(onSuccess: (UserCredential credential) {
            Navigator.of(context).pushNamed('/appointements');
          });
        }
      },
      child: Text(
        'Connexion',
        style: TextStyle(color: Colors.black),
      ),
    );
  }
}

class Login extends StatefulWidget {
  Login({super.key});

  @override
  State<StatefulWidget> createState() => LoginScreenState();
}

class LoginScreenState extends State<Login> {
  late final TextEditingController usernameController;
  late final TextEditingController passwordController;
  final formKey = GlobalKey<FormState>();
  late bool isLoginFailed;

  @override
  void initState() {
    super.initState();
    usernameController = TextEditingController();
    passwordController = TextEditingController();
    isLoginFailed = false;
  }

  Map<String, dynamic> userData = {'username': '', 'password': ''};

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
                        if (isLoginFailed) LoginFailedComponement(),
                        SizedBox(
                            width: 300,
                            child: TextFormField(
                              controller: usernameController,
                              validator: (value) => value!.isNotEmpty
                                  ? null
                                  : 'Veuillez saisir un identifiant',
                              onSaved: (value) => userData['username'] = value,
                              inputFormatters: [],
                              decoration: InputDecoration(
                                labelText: 'Identifiant',
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30)),
                              ),
                            )),
                        Padding(
                            padding: EdgeInsets.only(top: 32),
                            child: SizedBox(
                                width: 300,
                                child: TextFormField(
                                  controller: passwordController,
                                  obscureText: true,
                                  validator: (value) => value!.isNotEmpty
                                      ? null
                                      : 'Veuillez saisir un mot de passe',
                                  onSaved: (value) =>
                                      userData['password'] = value,
                                  inputFormatters: [],
                                  decoration: InputDecoration(
                                    labelText: 'Mot de passe',
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(30)),
                                  ),
                                ))),
                        Padding(
                            padding: EdgeInsets.only(top: 32),
                            child: SizedBox(
                                width: 300,
                                child: OutlinedButton(
                                  onPressed: () async {
                                    if (formKey.currentState!.validate()) {
                                      formKey.currentState!.save();
                                      try {
                                        await FirebaseAuth.instance
                                            .signInWithEmailAndPassword(
                                                email: userData["username"],
                                                password: userData["password"]);
                                        formKey.currentState!.reset();
                                        Navigator.of(context)
                                            .pushNamed('/appointements');
                                      } on FirebaseAuthException catch (e) {
                                        setState(() {
                                          isLoginFailed = true;
                                        });
                                      }
                                    }
                                  },
                                  child: Text(
                                    'Connexion',
                                    style: TextStyle(color: Colors.black),
                                  ),
                                )))
                      ],
                    ),
                  )
                ],
              )),
        )));
  }
}
