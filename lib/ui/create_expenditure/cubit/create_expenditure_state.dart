part of 'create_expenditure_cubit.dart';

class CreateExpenditureState extends Equatable {
  const CreateExpenditureState({
    required this.errorMessage,
    required this.apiStatus,
    required this.category,
    required this.nameOfItem,
    required this.estimatedAmount,
  });
  const CreateExpenditureState.initial()
      : errorMessage = '',
        apiStatus = ApiStatus.initial,
        category = const TextInputModel.pure(),
        nameOfItem = const TextInputModel.pure(),
        estimatedAmount = const AmountModel.pure();

  final String? errorMessage;
  final ApiStatus apiStatus;
  final TextInputModel category;
  final TextInputModel nameOfItem;
  final AmountModel estimatedAmount;

  CreateExpenditureState copyWith({
    String? errorMessage,
    ApiStatus? apiStatus,
    TextInputModel? category,
    TextInputModel? nameOfItem,
    AmountModel? estimatedAmount,
  }) {
    return CreateExpenditureState(
      errorMessage: errorMessage,
      apiStatus: apiStatus ?? this.apiStatus,
      category: category ?? this.category,
      nameOfItem: nameOfItem ?? this.nameOfItem,
      estimatedAmount: estimatedAmount ?? this.estimatedAmount,
    );
  }

  CreateExpenditureState loading() {
    return copyWith(
      apiStatus: ApiStatus.loading,
    );
  }

  CreateExpenditureState failed({
    required String errorMessage,
  }) {
    return copyWith(
      apiStatus: ApiStatus.failure,
      errorMessage: errorMessage,
    );
  }

  CreateExpenditureState success() {
    return copyWith(
      apiStatus: ApiStatus.success,
    );
  }

  bool get isFormValid => Formz.validate([
        estimatedAmount,
        category,
        nameOfItem,
      ]);

  @override
  List<Object?> get props => [
        errorMessage,
        apiStatus,
        category,
        nameOfItem,
        estimatedAmount,
      ];
}
