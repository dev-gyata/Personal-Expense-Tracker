import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:personal_expense_tracker/dtos/expenditure_creation_request_dto.dart';
import 'package:personal_expense_tracker/dtos/expenditure_response_dto.dart';
import 'package:personal_expense_tracker/exceptions/api_exception.dart';
import 'package:personal_expense_tracker/services/expenditure_service.dart';

void main() {
  group('Expenditure Service Test', () {
    late ExpenditureService expenditureService;
    late Dio dio;
    late DioAdapter dioAdapter;
    setUp(() {
      dio = Dio();
      dioAdapter = DioAdapter(dio: dio, printLogs: true);
      expenditureService = ExpenditureService(dio: dio);
    });

    group('User expenditure Creation test', () {
      test(
        'Test that create user expenditure returns a normally when a correct '
        'expenditure is passed to this method',
        () {
          const nameOfItem = 'transport';
          const category = 'transport';
          const estimatedAmount = 500.0;

          dioAdapter.onPost('/user/expenditure', data: {
            'category': 'transport',
            'nameOfItem': 'transport',
            'estimatedAmount': 500,
          }, (server) {
            return server.reply(
              201,
              {
                'message': 'new expenditure added',
              },
            );
          });

          expect(
            () => expenditureService.createUserExpenditure(
              creationRequestDto: const ExpenditureCreationRequestDto(
                category: category,
                estimatedAmount: estimatedAmount,
                nameOfItem: nameOfItem,
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
          const nameOfItem = 'wrong-transport';
          const category = 'wrong-transport';
          const estimatedAmount = 500.0;

          dioAdapter.onPost('/user/expenditure', data: {
            'category': 'wrong-transport',
            'nameOfItem': 'wrong-transport',
            'estimatedAmount': 500.0,
          }, (server) {
            return server.reply(
              400,
              {
                'message': 'Invalid expenditure details',
              },
            );
          });

          expect(
            () => expenditureService.createUserExpenditure(
              creationRequestDto: const ExpenditureCreationRequestDto(
                category: category,
                estimatedAmount: estimatedAmount,
                nameOfItem: nameOfItem,
              ),
            ),
            throwsA(isA<ApiException>()),
          );
        },
      );
    });
    group('User expenditure Delete by id test', () {
      test(
        'Test that delete user expenditure by a valid id returns a valid '
        'income if server response with 200',
        () async {
          dioAdapter.onDelete('/user/expenditure/1', (server) {
            return server.reply(
              200,
              {
                'id': '1',
                'category': 'transport',
                'nameOfItem': 'transport',
                'estimatedAmount': 500.0,
              },
            );
          });
          final deletedExpenditure =
              await expenditureService.deleteUserExpenditure(
            expenditureId: '1',
          );
          expect(
            deletedExpenditure,
            ExpenditureResponseDto.fromMap(const {
              'id': '1',
              'category': 'transport',
              'nameOfItem': 'transport',
              'estimatedAmount': 500.0,
            }),
          );
        },
      );
      test(
        'Test that deleting user expenditure by an invalid id throws an '
        'ApiException if server response with 400 or 404',
        () async {
          dioAdapter.onDelete('/user/expenditure/invalid-id', (server) {
            return server.reply(
              400,
              'Invalid expenditure ID',
            );
          });
          expect(
            () => expenditureService.deleteUserExpenditure(
              expenditureId: 'invalid-id',
            ),
            throwsA(isA<ApiException>()),
          );
        },
      );

      test(
        'Test that deleting user expenditure by id throws an ApiException '
        'when the server returns a 401 unauthorized status code',
        () {
          dioAdapter.onDelete('/user/expenditure/1', (server) {
            return server.reply(
              400,
              {
                'error': 'Missing authentication header',
              },
            );
          });

          expect(
            () => expenditureService.deleteUserExpenditure(expenditureId: '1'),
            throwsA(isA<ApiException>()),
          );
        },
      );
    });
    group('User expenditure Fetching by id test', () {
      test(
        'Test that fetching user expenditure by a valid id returns a valid '
        'expenditure if server response with 200',
        () async {
          dioAdapter.onGet('/user/expenditure/1', (server) {
            return server.reply(
              200,
              {
                'id': '1',
                'category': 'transport',
                'nameOfItem': 'transport',
                'estimatedAmount': 500.0,
              },
            );
          });
          final expenditure = await expenditureService.getUserExpenditureById(
            expenditureId: '1',
          );
          expect(
            expenditure,
            ExpenditureResponseDto.fromMap(const {
              'id': '1',
              'category': 'transport',
              'nameOfItem': 'transport',
              'estimatedAmount': 500.0,
            }),
          );
        },
      );
      test(
        'Test that fetching user expenditure by an invalid id throws an '
        'ApiException if server response with 400 or 404',
        () async {
          dioAdapter.onGet('/user/expenditure/invalid-id', (server) {
            return server.reply(
              400,
              'Invalid expenditure ID',
            );
          });
          expect(
            () => expenditureService.getUserExpenditureById(
              expenditureId: 'invalid-id',
            ),
            throwsA(isA<ApiException>()),
          );
        },
      );

      test(
        'Test that get user expenditure by id throws an ApiException when the '
        'server returns a 401 unauthorized status code',
        () {
          dioAdapter.onGet('/user/expenditure/1', (server) {
            return server.reply(
              400,
              {
                'error': 'Missing authentication header',
              },
            );
          });

          expect(
            () => expenditureService.getUserExpenditureById(expenditureId: '1'),
            throwsA(isA<ApiException>()),
          );
        },
      );
    });

    group('User expenditure Fetching test', () {
      test(
        'Test that fetching user expenditure returns a list of expenditures if '
        'server response with 200',
        () async {
          dioAdapter.onGet('/user/expenditure', (server) {
            return server.reply(
              200,
              {
                'data': [
                  {
                    'id': '1',
                    'category': 'transport',
                    'nameOfItem': 'transport',
                    'estimatedAmount': 500.0,
                  },
                  {
                    'id': '2',
                    'category': 'transport',
                    'nameOfItem': 'transport',
                    'estimatedAmount': 500.0,
                  },
                ],
              },
            );
          });
          final expenditures = await expenditureService.getUserExpenditure();
          expect(expenditures, <ExpenditureResponseDto>[
            ExpenditureResponseDto.fromMap(
              const {
                'id': '1',
                'category': 'transport',
                'nameOfItem': 'transport',
                'estimatedAmount': 500.0,
              },
            ),
            ExpenditureResponseDto.fromMap(const {
              'id': '2',
              'category': 'transport',
              'nameOfItem': 'transport',
              'estimatedAmount': 500.0,
            }),
          ]);
        },
      );

      test(
        'Test that get user expenditure throws an ApiException when the server '
        'returns a 401 unauthorized status code',
        () {
          dioAdapter.onGet('/user/expenditure', (server) {
            return server.reply(
              400,
              {
                'error': 'Missing authentication header',
              },
            );
          });

          expect(
            expenditureService.getUserExpenditure,
            throwsA(isA<ApiException>()),
          );
        },
      );
    });
  });
}
