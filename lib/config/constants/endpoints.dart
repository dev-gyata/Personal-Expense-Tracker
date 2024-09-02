/// Constants for API endpoints
abstract class AppEndpoints {
  //Auth endpoints
  static const String loginEndpoint = '/auth/login';
  static const String signupEndpoint = '/auth/signup';

  /// Endpoint for user profile
  /// '*' is a wildcard that will be replaced with the user id
  /// when making the request, you will have to replace * with the
  /// user id in the request.
  /// Example:
  ///   userProfileEndpoint.replaceAll('*', 'userId')
  static const String userProfileEndpoint = '/auth/user/*/profile';

  //Expenditure endpoints
  static const String expenditureEndpoint = '/user/expenditure';

  /// Endpoint for Expenditure by id
  /// '*' is a wildcard that will be replaced with the expenditureId
  /// when making the request, you will have to replace * with the
  /// expendiureId in the request.
  /// Example:
  ///   expenditureByIdEndpoint.replaceAll('*', 'expenditureId')
  static const String expenditureByIdEndpoint = '/user/expenditure/*';

  //Income endpoints
  static const String incomeEndpoint = '/user/income';

  /// Endpoint for Income by id
  /// '*' is a wildcard that will be replaced with the incomeId
  /// when making the request, you will have to replace * with the
  /// incomeId in the request.
  /// Example:
  ///   incomeByIdEndpoint.replaceAll('*', 'incomeId')
  static const String incomeByIdEndpoint = '/user/income/*';
}
