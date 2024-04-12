import 'package:docto_libre/authentification/model/UserData.dart';
import 'package:docto_libre/authentification/service/loginService.dart';
import 'package:flutter/material.dart';


import 'package:firebase_auth/firebase_auth.dart';

class LoginController extends ValueNotifier<UserData> {
  final LoginService loginService;

  LoginController(this.loginService) : super(UserData.instance);

  final mailController = TextEditingController();
  final passwordController = TextEditingController();

  void login({required ValueChanged<UserCredential> onSuccess}) async {
    value = UserData.instance;
    try {
      final result = await loginService.login(mailController.text, passwordController.text);
      if (result != null) {
        onSuccess(result);
        value = UserData.loginInstance;
      } else {
        value = UserData.failedInstance;
      }
    } catch (err) {
      print('ERROR !!! login $err');
      value = UserData.failedInstance;

    }
  }

}