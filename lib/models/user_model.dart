import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  const UserModel({
    required this.name,
    required this.email,
    required this.id,
  });
  const UserModel.empty() : this(name: '', email: '', id: '');
  final String name;
  final String email;
  final String id;

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [name, email, id];
}
