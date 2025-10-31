class UserModel {
  final String firstName;
  final String lastName;
  final String country;
  final String flag; // emoji or asset path

  UserModel({
    required this.firstName,
    required this.lastName,
    required this.country,
    required this.flag,
  });
}
