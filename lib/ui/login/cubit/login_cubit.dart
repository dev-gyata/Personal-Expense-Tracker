import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:personal_expense_tracker/exceptions/login_exception.dart';
import 'package:personal_expense_tracker/models/models.dart';
import 'package:personal_expense_tracker/repositories/authentication_repository.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit({
    required AuthenticationRepository authenticationRepository,
  })  : _authenticationRepository = authenticationRepository,
        super(const LoginState());
  final AuthenticationRepository _authenticationRepository;

  void onEmailChanged(String email) {
    final updatedEmail = EmailModel.dirty(email);
    emit(
      state.copyWith(
        email: updatedEmail,
        isValid: Formz.validate([updatedEmail, state.password]),
      ),
    );
  }

  void onPasswordChanged(String password) {
    final updatedPassword = PasswordModel.dirty(password);
    emit(
      state.copyWith(
        password: updatedPassword,
        isValid: Formz.validate([updatedPassword, state.email]),
      ),
    );
  }

  void onToggleRememberMe() {
    emit(
      state.copyWith(
        rememberMe: !state.rememberMe,
      ),
    );
  }

  // ignore: avoid_void_async
  Future<void> onSubmit() async {
    if (state.isValid) {
      emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
      try {
        await _authenticationRepository.logIn(
          email: state.email.value,
          password: state.password.value,
          rememberMe: state.rememberMe,
        );
        emit(state.copyWith(status: FormzSubmissionStatus.success));
      } on LoginException catch (e) {
        emit(
          state.copyWith(
            status: FormzSubmissionStatus.failure,
            errorMessage: e.message,
          ),
        );
      }
    }
  }
}
