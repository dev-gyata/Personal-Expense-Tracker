import 'package:flutter_test/flutter_test.dart';
import 'package:personal_expense_tracker/models/user_model.dart';

void main() {
  group('UserModel Test', () {
    test('Test that UserModel.empty() returns an empty attributes', () {
      const user = UserModel.empty();
      expect(user.name, '');
      expect(user.email, '');
      expect(user.id, '');
    });
    test('Test that UserModel compares object correctly', () {
      const user1 = UserModel(name: 'Kofi', email: 'kofi@example.com', id: '1');
      const user2 = UserModel(name: 'Kofi', email: 'kofi@example.com', id: '1');
      expect(user1, user2);
    });
  });
}
