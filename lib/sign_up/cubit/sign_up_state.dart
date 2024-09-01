// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'sign_up_cubit.dart';

class SignUpState extends Equatable {
  const SignUpState({
    this.status = FormzSubmissionStatus.initial,
    this.email = const EmailModel.pure(),
    this.password = const PasswordModel.pure(),
    this.isValid = false,
    this.name = const NameModel.pure(),
    this.errorMessage,
  });
  final EmailModel email;
  final PasswordModel password;
  final bool isValid;
  final FormzSubmissionStatus status;
  final NameModel name;
  final String? errorMessage;

  @override
  List<Object?> get props => [
        status,
        email,
        password,
        isValid,
        name,
        errorMessage,
      ];

  SignUpState copyWith({
    EmailModel? email,
    PasswordModel? password,
    bool? isValid,
    FormzSubmissionStatus? status,
    NameModel? name,
    String? errorMessage,
  }) {
    return SignUpState(
      email: email ?? this.email,
      password: password ?? this.password,
      isValid: isValid ?? this.isValid,
      status: status ?? this.status,
      name: name ?? this.name,
      errorMessage: errorMessage,
    );
  }
}
