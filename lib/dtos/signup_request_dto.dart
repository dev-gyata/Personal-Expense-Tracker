// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

class SignupRequestDto extends Equatable {
  final String email;
  final String name;
  final String password;
  const SignupRequestDto({
    required this.email,
    required this.name,
    required this.password,
  });

  SignupRequestDto copyWith({
    String? email,
    String? name,
    String? password,
  }) {
    return SignupRequestDto(
      email: email ?? this.email,
      name: name ?? this.name,
      password: password ?? this.password,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'email': email,
      'name': name,
      'password': password,
    };
  }

  factory SignupRequestDto.fromMap(Map<String, dynamic> map) {
    return SignupRequestDto(
      email: (map['email'] ?? '') as String,
      name: (map['name'] ?? '') as String,
      password: (map['password'] ?? '') as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory SignupRequestDto.fromJson(String source) =>
      SignupRequestDto.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [email, name, password];
}
