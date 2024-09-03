part of 'login_cubit.dart';

class LoginState extends Equatable {
  const LoginState({
    this.status = FormzSubmissionStatus.initial,
    this.email = const EmailModel.pure(),
    this.password = const PasswordModel.pure(),
    this.isValid = false,
    this.rememberMe = false,
    this.errorMessage,
  });
  final EmailModel email;
  final PasswordModel password;
  final bool isValid;
  final String? errorMessage;
  final bool rememberMe;
  final FormzSubmissionStatus status;

  @override
  List<Object?> get props => [
        status,
        email,
        password,
        isValid,
        rememberMe,
        errorMessage,
      ];

  LoginState copyWith({
    EmailModel? email,
    PasswordModel? password,
    bool? isValid,
    FormzSubmissionStatus? status,
    String? errorMessage,
    bool? rememberMe,
  }) {
    return LoginState(
      email: email ?? this.email,
      password: password ?? this.password,
      isValid: isValid ?? this.isValid,
      status: status ?? this.status,
      errorMessage: errorMessage,
      rememberMe: rememberMe ?? this.rememberMe,
    );
  }
}
