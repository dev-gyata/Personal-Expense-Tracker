import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:personal_expense_tracker/models/models.dart';
import 'package:personal_expense_tracker/repositories/authentication_repository.dart';

part 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit({
    required AuthenticationRepository authenticationRepository,
  })  : _authenticationRepository = authenticationRepository,
        super(const SignUpState());

  final AuthenticationRepository _authenticationRepository;

  void onEmailChanged(String email) {
    final updatedEmail = EmailModel.dirty(email);
    emit(
      state.copyWith(
        email: updatedEmail,
        isValid: Formz.validate([updatedEmail, state.name, state.password]),
      ),
    );
  }

  void onPasswordChanged(String password) {
    final updatedPassword = PasswordModel.dirty(password);
    emit(
      state.copyWith(
        password: updatedPassword,
        isValid: Formz.validate([updatedPassword, state.name, state.email]),
      ),
    );
  }

  void onNameChanged(String name) {
    final updatedName = NameModel.dirty(name);
    emit(
      state.copyWith(
        name: updatedName,
        isValid: Formz.validate([updatedName, state.email, state.password]),
      ),
    );
  }

  // ignore: avoid_void_async
  void onSubmit() async {
    if (state.isValid) {
      emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
      try {
        await _authenticationRepository.signUp(
          email: state.email.value,
          name: state.name.value,
          password: state.password.value,
        );
        emit(state.copyWith(status: FormzSubmissionStatus.success));
      } catch (_) {
        emit(state.copyWith(status: FormzSubmissionStatus.failure));
      }
    }
  }
}
