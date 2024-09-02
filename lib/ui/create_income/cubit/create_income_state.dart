part of 'create_income_cubit.dart';

class CreateIncomeState extends Equatable {
  const CreateIncomeState({
    required this.errorMessage,
    required this.apiStatus,
    required this.nameOfRevenue,
    required this.amount,
  });

  const CreateIncomeState.initial()
      : errorMessage = '',
        nameOfRevenue = const TextInputModel.pure(),
        apiStatus = ApiStatus.initial,
        amount = const AmountModel.pure();
  final String? errorMessage;
  final ApiStatus apiStatus;
  final TextInputModel nameOfRevenue;
  final AmountModel amount;

  @override
  List<Object?> get props => [
        errorMessage,
        apiStatus,
        nameOfRevenue,
        amount,
      ];

  bool get isFormValid => Formz.validate([
        amount,
        nameOfRevenue,
      ]);

  CreateIncomeState loading() {
    return copyWith(
      apiStatus: ApiStatus.loading,
    );
  }

  CreateIncomeState failed({
    required String errorMessage,
  }) {
    return copyWith(
      apiStatus: ApiStatus.failure,
      errorMessage: errorMessage,
    );
  }

  CreateIncomeState success() {
    return copyWith(
      apiStatus: ApiStatus.success,
    );
  }

  CreateIncomeState copyWith({
    String? errorMessage,
    ApiStatus? apiStatus,
    TextInputModel? nameOfRevenue,
    AmountModel? amount,
  }) {
    return CreateIncomeState(
      errorMessage: errorMessage,
      apiStatus: apiStatus ?? this.apiStatus,
      nameOfRevenue: nameOfRevenue ?? this.nameOfRevenue,
      amount: amount ?? this.amount,
    );
  }
}
