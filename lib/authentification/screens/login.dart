import 'package:flutter/material.dart';

import '../../componements/header.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
        return Scaffold(
          appBar: Header(),
          body: Center(
            child: Text('Login'),
          ),
        );
  }

}