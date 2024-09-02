import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:personal_expense_tracker/extensions/build_context_extensions.dart';
import 'package:personal_expense_tracker/extensions/theme_mode_extensions.dart';
import 'package:personal_expense_tracker/global_cubits/theme_cubit/theme_cubit.dart';
import 'package:personal_expense_tracker/l10n/l10n.dart';

class ThemePickerWidget extends StatelessWidget {
  const ThemePickerWidget({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(15),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  l10n.themePreference,
                  style: context.largeText?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  ...ThemeMode.values.reversed.map(
                    (option) => Builder(
                      builder: (context) {
                        final currentTheme =
                            context.select<ThemeCubit, ThemeMode>(
                          (cubit) => cubit.state,
                        );
                        return ListTile(
                          onTap: () {
                            context.read<ThemeCubit>().toggleThemeMode(
                                  themeMode: option,
                                );
                          },
                          title: Text(option.getThemeName(context)),
                          visualDensity: const VisualDensity(
                            horizontal: -4,
                          ),
                          contentPadding: const EdgeInsets.only(
                            left: 5,
                            right: 5,
                          ),
                          minVerticalPadding: 0,
                          trailing: currentTheme == option
                              ? const Icon(Icons.check_rounded)
                              : null,
                          // leading: Radio<ThemeMode>(
                          //   visualDensity: const VisualDensity(
                          //     horizontal: -4,
                          //   ),
                          //   value: option,
                          //   groupValue: currentTheme,
                          //   onChanged: (ThemeMode? value) {
                          //     if (value != null) {
                          //       context.read<ThemeCubit>().toggleThemeMode(
                          //             themeMode: value,
                          //           );
                          //     }
                          //   },
                          // ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
