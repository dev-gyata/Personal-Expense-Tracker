part of 'income_cubit.dart';

class IncomeState extends Equatable {
  const IncomeState({
    required this.income,
    required this.errorMessage,
    required this.apiStatus,
    required this.incomeDeletionStatus,
  });
  const IncomeState.initial()
      : income = const [],
        errorMessage = null,
        incomeDeletionStatus = ApiStatus.initial,
        apiStatus = ApiStatus.initial;

  const IncomeState.success({
    required this.income,
  })  : errorMessage = null,
        incomeDeletionStatus = ApiStatus.initial,
        apiStatus = ApiStatus.success;

  const IncomeState.failed({
    required this.errorMessage,
  })  : income = const [],
        incomeDeletionStatus = ApiStatus.initial,
        apiStatus = ApiStatus.failure;

  const IncomeState.loading()
      : income = const [],
        errorMessage = null,
        incomeDeletionStatus = ApiStatus.initial,
        apiStatus = ApiStatus.loading;

  final List<IncomeModel> income;
  final String? errorMessage;
  final ApiStatus apiStatus;
  final ApiStatus incomeDeletionStatus;

  IncomeState isDeletionInProgress() => copyWith(
        incomeDeletionStatus: ApiStatus.loading,
      );
  IncomeState isDeletionSuccess({
    required List<IncomeModel> updatedIncome,
  }) =>
      copyWith(
        income: updatedIncome,
        incomeDeletionStatus: ApiStatus.success,
      );
  IncomeState isDeletionFailure() => copyWith(
        incomeDeletionStatus: ApiStatus.failure,
      );

  @override
  List<Object?> get props =>
      [income, incomeDeletionStatus, errorMessage, apiStatus];

  IncomeState copyWith({
    List<IncomeModel>? income,
    String? errorMessage,
    ApiStatus? apiStatus,
    ApiStatus? incomeDeletionStatus,
  }) {
    return IncomeState(
      income: income ?? this.income,
      errorMessage: errorMessage ?? this.errorMessage,
      apiStatus: apiStatus ?? this.apiStatus,
      incomeDeletionStatus: incomeDeletionStatus ?? this.incomeDeletionStatus,
    );
  }
}
