import 'package:docto_libre/authentification/model/UserData.dart';
import 'package:firebase_auth/firebase_auth.dart';


class LoginService {
  final FirebaseAuth auth;

  LoginService(this.auth);

  Future<UserCredential?> login(String email, String password)  async {
    try {
     return await this.auth.signInWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      return null;
    }
  }

}