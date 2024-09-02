part of 'expenditure_cubit.dart';

class ExpenditureState extends Equatable {
  const ExpenditureState({
    required this.expenditures,
    required this.errorMessage,
    required this.apiStatus,
    required this.expenditureDeletionStatus,
  });
  const ExpenditureState.initial()
      : expenditures = const [],
        errorMessage = null,
        expenditureDeletionStatus = ApiStatus.initial,
        apiStatus = ApiStatus.initial;

  const ExpenditureState.success({
    required this.expenditures,
  })  : errorMessage = null,
        expenditureDeletionStatus = ApiStatus.initial,
        apiStatus = ApiStatus.success;

  const ExpenditureState.failed({
    required this.errorMessage,
  })  : expenditures = const [],
        expenditureDeletionStatus = ApiStatus.initial,
        apiStatus = ApiStatus.failure;

  const ExpenditureState.loading()
      : expenditures = const [],
        errorMessage = null,
        expenditureDeletionStatus = ApiStatus.initial,
        apiStatus = ApiStatus.loading;

  final List<ExpenditureModel> expenditures;
  final String? errorMessage;
  final ApiStatus apiStatus;
  final ApiStatus expenditureDeletionStatus;

  ExpenditureState isDeletionInProgress() => copyWith(
        expenditureDeletionStatus: ApiStatus.loading,
      );
  ExpenditureState isDeletionSuccess({
    required List<ExpenditureModel> updatedExpenditures,
  }) =>
      copyWith(
        expenditures: updatedExpenditures,
        expenditureDeletionStatus: ApiStatus.success,
      );
  ExpenditureState isDeletionFailure() => copyWith(
        expenditureDeletionStatus: ApiStatus.failure,
      );

  @override
  List<Object?> get props =>
      [expenditures, expenditureDeletionStatus, errorMessage, apiStatus];

  ExpenditureState copyWith({
    List<ExpenditureModel>? expenditures,
    String? errorMessage,
    ApiStatus? apiStatus,
    ApiStatus? expenditureDeletionStatus,
  }) {
    return ExpenditureState(
      expenditures: expenditures ?? this.expenditures,
      errorMessage: errorMessage ?? this.errorMessage,
      apiStatus: apiStatus ?? this.apiStatus,
      expenditureDeletionStatus:
          expenditureDeletionStatus ?? this.expenditureDeletionStatus,
    );
  }
}
