class UserModel {
  final String? username;

  final String? password;

  UserModel({this.username, this.password});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      username: json['username'] ?? '',
      password: json['password'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {'username': username, 'password': password};
  }
}
