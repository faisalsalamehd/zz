class LoginScreenModel {
  final String username;
  final String password;
  final bool rememberMe;
  final int expiresInMins;

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
      'expiresInMins': expiresInMins,
    };
  }
}
