import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:personal_expense_tracker/extensions/build_context_extensions.dart';
import 'package:personal_expense_tracker/extensions/theme_mode_extensions.dart';
import 'package:personal_expense_tracker/global_cubits/authentication_cubit/authentication_cubit.dart';
import 'package:personal_expense_tracker/global_cubits/theme_cubit/theme_cubit.dart';
import 'package:personal_expense_tracker/l10n/l10n.dart';
import 'package:personal_expense_tracker/widgets/app_dialog.dart';

@RoutePage()
class SettingsTab extends StatelessWidget {
  const SettingsTab({super.key});

  Future<void> _onLogoutTapped(BuildContext context) async {
    final userResponse = await context.showConfirmationDialog(
      message: context.l10n.areYouSureYouWantToLogout,
    );
    if (userResponse == ConfirmationDialogResult.ok) {
      // ignore: use_build_context_synchronously
      context.read<AuthenticationCubit>().logOut();
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return ListView(
      children: [
        const Divider(),
        ListTile(
          leading: const Icon(Icons.palette),
          title: Text(l10n.theme),
          trailing: Builder(
            builder: (context) {
              final currenTheme = context.select<ThemeCubit, ThemeMode>(
                (cubit) => cubit.state,
              );
              return Text(currenTheme.getThemeName(context));
            },
          ),
          onTap: () {
            context.openThemePicker();
          },
        ),
        const Divider(),
        ListTile(
          leading: const Icon(Icons.logout),
          title: Text(l10n.logout),
          trailing: const Icon(Icons.arrow_forward_ios),
          onTap: () => _onLogoutTapped(context),
        ),
        const Divider(),
      ],
    );
  }
}
