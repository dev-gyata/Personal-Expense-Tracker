import 'dart:convert';

import 'package:equatable/equatable.dart';

class UserResponseDto extends Equatable {
  const UserResponseDto({
    required this.name,
    required this.email,
    required this.id,
  });

  factory UserResponseDto.fromMap(Map<String, dynamic> map) {
    return UserResponseDto(
      name: (map['name'] ?? '') as String,
      email: (map['email'] ?? '') as String,
      id: (map['id'] ?? '') as String,
    );
  }

  factory UserResponseDto.fromJson(String source) =>
      UserResponseDto.fromMap(json.decode(source) as Map<String, dynamic>);
  final String name;
  final String email;
  final String id;

  UserResponseDto copyWith({
    String? name,
    String? email,
    String? id,
  }) {
    return UserResponseDto(
      name: name ?? this.name,
      email: email ?? this.email,
      id: id ?? this.id,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'email': email,
      'id': id,
    };
  }

  String toJson() => json.encode(toMap());

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [name, email, id];
}
