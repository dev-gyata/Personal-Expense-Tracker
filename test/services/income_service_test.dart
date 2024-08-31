import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:personal_expense_tracker/dtos/income_creation_request_dto.dart';
import 'package:personal_expense_tracker/dtos/income_response_dto.dart';
import 'package:personal_expense_tracker/exceptions/api_exception.dart';
import 'package:personal_expense_tracker/services/income_service.dart';

void main() {
  group('IncomeService Test', () {
    late IncomeService incomeService;
    late Dio dio;
    late DioAdapter dioAdapter;
    setUp(() {
      dio = Dio();
      dioAdapter = DioAdapter(dio: dio, printLogs: true);
      incomeService = IncomeService(dio: dio);
    });

    group('User income Creation test', () {
      test(
        'Test that create user income returns a normally when a correct '
        'income is paassed to this method',
        () {
          const nameOfRevenue = 'salary';
          const amount = 100.0;

          dioAdapter.onPost('/user/income', data: {
            'nameOfRevenue': 'salary',
            'amount': 100,
          }, (server) {
            return server.reply(
              201,
              {
                'message': 'new income added',
              },
            );
          });

          expect(
            () => incomeService.createUserIncome(
              incomeRequestDto: const IncomeCreationRequestDto(
                nameOfRevenue: nameOfRevenue,
                amount: amount,
              ),
            ),
            returnsNormally,
          );
        },
      );

      test(
        'Test that create user income throws an ApiException when the server '
        'returns a 400 status code',
        () {
          const nameOfRevenue = 'wrong-revenue';
          const amount = -100.0;

          dioAdapter.onPost('/user/income', data: {
            'nameOfRevenue': 'wrong-revenue',
            'amountg': -100.0,
          }, (server) {
            return server.reply(
              400,
              {
                'message': 'Invalid revenue name and amount',
              },
            );
          });

          expect(
            () => incomeService.createUserIncome(
              incomeRequestDto: const IncomeCreationRequestDto(
                nameOfRevenue: nameOfRevenue,
                amount: amount,
              ),
            ),
            throwsA(isA<ApiException>()),
          );
        },
      );
    });
    group('User income Delete by id test', () {
      test(
        'Test that delete user income by a valid id returns a valid income '
        'if server response with 200',
        () async {
          dioAdapter.onDelete('/user/income/1', (server) {
            return server.reply(
              200,
              {
                'id': '1',
                'nameOfRevenue': 'salary',
                'amount': 100.0,
              },
            );
          });
          final income = await incomeService.deleteUserIncome(incomeId: '1');
          expect(
            income,
            IncomeResponseDto.fromMap(const {
              'id': '1',
              'nameOfRevenue': 'salary',
              'amount': 100.0,
            }),
          );
        },
      );
      test(
        'Test that deleting user income by an invalid id throws an '
        'ApiException if server response with 400 or 404',
        () async {
          dioAdapter.onDelete('/user/income/invalid-id', (server) {
            return server.reply(
              400,
              'Invalid income ID',
            );
          });
          expect(
            () => incomeService.deleteUserIncome(incomeId: 'invalid-id'),
            throwsA(isA<ApiException>()),
          );
        },
      );

      test(
        'Test that delete user income by id throws an ApiException when the '
        'server returns a 401 unauthorized status code',
        () {
          dioAdapter.onDelete('/user/income/1', (server) {
            return server.reply(
              400,
              {
                'error': 'Missing authentication header',
              },
            );
          });

          expect(
            () => incomeService.deleteUserIncome(incomeId: '1'),
            throwsA(isA<ApiException>()),
          );
        },
      );
    });
    group('User income Fetching by id test', () {
      test(
        'Test that fetching user income by a valid id returns a valid income '
        'if server response with 200',
        () async {
          dioAdapter.onGet('/user/income/1', (server) {
            return server.reply(
              200,
              {
                'id': '1',
                'nameOfRevenue': 'salary',
                'amount': 100.0,
              },
            );
          });
          final income = await incomeService.getUserIncomeById(incomeId: '1');
          expect(
            income,
            IncomeResponseDto.fromMap(const {
              'id': '1',
              'nameOfRevenue': 'salary',
              'amount': 100.0,
            }),
          );
        },
      );
      test(
        'Test that fetching user income by an invalid id throws an '
        'ApiException if server response with 400 or 404',
        () async {
          dioAdapter.onGet('/user/income/invalid-id', (server) {
            return server.reply(
              400,
              'Invalid income ID',
            );
          });
          expect(
            () => incomeService.getUserIncomeById(incomeId: 'invalid-id'),
            throwsA(isA<ApiException>()),
          );
        },
      );

      test(
        'Test that get user income by id throws an ApiException when the '
        'server returns a 401 unauthorized status code',
        () {
          dioAdapter.onGet('/user/income/1', (server) {
            return server.reply(
              400,
              {
                'error': 'Missing authentication header',
              },
            );
          });

          expect(
            () => incomeService.getUserIncomeById(incomeId: '1'),
            throwsA(isA<ApiException>()),
          );
        },
      );
    });

    group('User income Fetching test', () {
      test(
        'Test that fetching user income returns a list of incomes if '
        'server response with 200',
        () async {
          dioAdapter.onGet('/user/income', (server) {
            return server.reply(
              200,
              {
                'data': [
                  {
                    'id': '1',
                    'nameOfRevenue': 'salary',
                    'amount': 100.0,
                  },
                  {
                    'id': '2',
                    'nameOfRevenue': 'bonus',
                    'amount': 100.0,
                  },
                ],
              },
            );
          });
          final incomes = await incomeService.getUserIncome();
          expect(incomes, <IncomeResponseDto>[
            IncomeResponseDto.fromMap(const {
              'id': '1',
              'nameOfRevenue': 'salary',
              'amount': 100.0,
            }),
            IncomeResponseDto.fromMap(const {
              'id': '2',
              'nameOfRevenue': 'bonus',
              'amount': 100.0,
            }),
          ]);
        },
      );

      test(
        'Test that get user income throws an ApiException when the server '
        'returns a 401 unauthorized status code',
        () {
          dioAdapter.onGet('/user/income', (server) {
            return server.reply(
              400,
              {
                'error': 'Missing authentication header',
              },
            );
          });

          expect(
            () => incomeService.getUserIncome(),
            throwsA(isA<ApiException>()),
          );
        },
      );
    });
  });
}
