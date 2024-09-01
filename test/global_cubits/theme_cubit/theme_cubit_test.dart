import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:mocktail/mocktail.dart';
import 'package:personal_expense_tracker/global_cubits/theme_cubit/theme_cubit.dart';

class MockStorage extends Mock implements Storage {}

void main() {
  late MockStorage mockStorage;
  setUp(() {
    mockStorage = MockStorage();
    when(
      () => mockStorage.write(any(), any<dynamic>()),
    ).thenAnswer((_) async {});
    HydratedBloc.storage = mockStorage;
  });
  group('ThemeCubit Test', () {
    blocTest<ThemeCubit, ThemeMode>(
      'should emit the correct dark mode theme when user toggles to dark mode',
      build: ThemeCubit.new,
      act: (cubit) {
        cubit.toggleThemeMode(themeMode: ThemeMode.dark);
      },
      expect: () => [
        ThemeMode.dark,
      ],
    );
    blocTest<ThemeCubit, ThemeMode>(
      'should emit the correct system theme mode theme when user '
      'toggles to system theme mode',
      build: ThemeCubit.new,
      act: (cubit) {
        cubit.toggleThemeMode(themeMode: ThemeMode.system);
      },
      expect: () => [
        ThemeMode.system,
      ],
    );
    blocTest<ThemeCubit, ThemeMode>(
      'should emit the correct light theme mode theme when user '
      'toggles to light theme mode',
      build: ThemeCubit.new,
      act: (cubit) {
        cubit.toggleThemeMode(themeMode: ThemeMode.light);
      },
      expect: () => [
        ThemeMode.light,
      ],
    );
  });
}
