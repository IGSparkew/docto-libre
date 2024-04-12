import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import 'authentification/service/loginService.dart';

class AppProvider extends StatefulWidget {
  final Widget app;

  const AppProvider({required this.app, super.key});

  @override
  State<AppProvider> createState() => _AppProviderState();
}

class _AppProviderState extends State<AppProvider> {
  final loginService = LoginService(FirebaseAuth.instance);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider.value(value: loginService),
      ],
      child: widget.app,
    );
  }
}