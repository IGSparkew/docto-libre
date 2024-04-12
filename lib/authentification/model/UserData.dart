

class UserData {
  late final bool isLogin;
  final bool isLoginFailed;

  bool isFailed() {
    return isLogin && isLoginFailed;
  }

  UserData(this.isLogin, this.isLoginFailed);

  static UserData failedInstance = UserData(true, true);

  static UserData loginInstance = UserData(true, false);

  static UserData instance = UserData(false, false);
}