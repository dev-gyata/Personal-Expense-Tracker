import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

class ThemeCubit extends HydratedCubit<ThemeMode> {
  ThemeCubit() : super(ThemeMode.system) {
    hydrate();
  }

  void toggleThemeMode({
    required ThemeMode themeMode,
  }) {
    emit(themeMode);
  }

  @override
  ThemeMode? fromJson(Map<String, dynamic> json) {
    return ThemeMode.values.firstWhere(
      (e) => e.name == json['themeMode'],
      orElse: () => ThemeMode.system,
    );
  }

  @override
  Map<String, dynamic>? toJson(ThemeMode state) {
    return {
      'themeMode': state.name,
    };
  }
}
