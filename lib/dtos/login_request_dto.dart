import 'dart:convert';

import 'package:equatable/equatable.dart';

class LoginRequestDto extends Equatable {
  const LoginRequestDto({
    required this.email,
    required this.password,
  });

  factory LoginRequestDto.fromMap(Map<String, dynamic> map) {
    return LoginRequestDto(
      email: (map['email'] ?? '') as String,
      password: (map['password'] ?? '') as String,
    );
  }

  factory LoginRequestDto.fromJson(String source) =>
      LoginRequestDto.fromMap(json.decode(source) as Map<String, dynamic>);
  final String email;
  final String password;

  LoginRequestDto copyWith({
    String? email,
    String? password,
  }) {
    return LoginRequestDto(
      email: email ?? this.email,
      password: password ?? this.password,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'email': email,
      'password': password,
    };
  }

  String toJson() => json.encode(toMap());

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [email, password];
}
