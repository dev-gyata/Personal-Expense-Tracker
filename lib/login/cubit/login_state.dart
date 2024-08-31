// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'login_cubit.dart';

class LoginState extends Equatable {
  const LoginState({
    this.status = FormzSubmissionStatus.initial,
    this.email = const EmailModel.pure(),
    this.password = const PasswordModel.pure(),
    this.isValid = false,
  });
  final EmailModel email;
  final PasswordModel password;
  final bool isValid;
  final FormzSubmissionStatus status;

  @override
  List<Object> get props => [
        status,
        email,
        password,
        isValid,
      ];

  LoginState copyWith({
    EmailModel? email,
    PasswordModel? password,
    bool? isValid,
    FormzSubmissionStatus? status,
  }) {
    return LoginState(
      email: email ?? this.email,
      password: password ?? this.password,
      isValid: isValid ?? this.isValid,
      status: status ?? this.status,
    );
  }
}
