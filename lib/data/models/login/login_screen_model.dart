class LoginScreenModel {
  String username;
  String password;
  bool rememberMe;
  int expiresInMins;

  LoginScreenModel({
    required this.username,
    required this.password,
    this.rememberMe = false,
    this.expiresInMins = 30,
  });

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'password': password,
    };
  }
}
