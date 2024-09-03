import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  const UserModel({
    required this.name,
    required this.email,
    required this.id,
  });

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      name: (map['name'] ?? '') as String,
      email: (map['email'] ?? '') as String,
      id: (map['id'] ?? '') as String,
    );
  }
  const UserModel.empty() : this(name: '', email: '', id: '');
  final String name;
  final String email;
  final String id;

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [name, email, id];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'email': email,
      'id': id,
    };
  }
}
