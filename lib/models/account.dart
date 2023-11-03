import 'package:uuid/uuid.dart';

class Account {
  final Uuid id;
  final String username;
  final String password;

  const Account({
    required this.id,
    required this.username,
    required this.password,
  });

  factory Account.fromJson(Map<String, dynamic> json) {
    return Account(
      id: json['id'] as Uuid,
      username: json['username'] as String,
      password: json['password'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'username': username,
    'password': password
  };
}