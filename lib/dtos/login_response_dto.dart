import 'dart:convert';

import 'package:equatable/equatable.dart';

class LoginResponseDto extends Equatable {
  const LoginResponseDto({
    required this.message,
    required this.accessToken,
    required this.expiresIn,
  });

  factory LoginResponseDto.fromMap(Map<String, dynamic> map) {
    return LoginResponseDto(
      message: (map['message'] ?? '') as String,
      accessToken: (map['accessToken'] ?? '') as String,
      expiresIn: (map['expiresIn'] ?? '') as String,
    );
  }

  factory LoginResponseDto.fromJson(String source) =>
      LoginResponseDto.fromMap(json.decode(source) as Map<String, dynamic>);
  final String message;
  final String accessToken;
  final String expiresIn;

  LoginResponseDto copyWith({
    String? message,
    String? accessToken,
    String? expiresIn,
  }) {
    return LoginResponseDto(
      message: message ?? this.message,
      accessToken: accessToken ?? this.accessToken,
      expiresIn: expiresIn ?? this.expiresIn,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'message': message,
      'accessToken': accessToken,
      'expiresIn': expiresIn,
    };
  }

  String toJson() => json.encode(toMap());

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [message, accessToken, expiresIn];
}
