import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:personal_expense_tracker/config/config.dart';
import 'package:personal_expense_tracker/extensions/extensions.dart';
import 'package:personal_expense_tracker/global_cubits/authentication_cubit/authentication_cubit.dart';
import 'package:personal_expense_tracker/l10n/l10n.dart';
import 'package:personal_expense_tracker/resources/resources.dart';

class HomePageAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HomePageAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Stack(
      children: [
        const Positioned.fill(
          child: ColoredBox(color: AppColors.primary),
        ),
        Positioned.fill(
          child: Image.asset(
            Images.appBarPattern,
            fit: BoxFit.fill,
          ),
        ),
        AppBar(
          backgroundColor: Colors.transparent,
          title: Row(
            children: [
              CircleAvatar(
                radius: 16,
                backgroundColor: AppColors.kNiagara,
                child: Builder(
                  builder: (context) {
                    final loggedInUserName =
                        context.select<AuthenticationCubit, String>(
                      (cubit) {
                        final name = cubit.state.user.name;
                        return name.length < 2 ? 'Name' : name;
                      },
                    );
                    return Text(
                      loggedInUserName.substring(0, 2).toUpperCase(),
                      style: context.smallText?.copyWith(
                        color: AppColors.kWhiteColor,
                      ),
                    );
                  },
                ),
              ),
              const Gap(15),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n.goodMorning,
                      style: context.smallText?.copyWith(
                        color: AppColors.kWhiteColor,
                      ),
                    ),
                    Builder(
                      builder: (context) {
                        final loggedInUserName =
                            context.select<AuthenticationCubit, String>(
                          (cubit) {
                            return cubit.state.user.name;
                          },
                        );
                        return Text(
                          loggedInUserName,
                          maxLines: 1,
                          style: context.mediumText?.copyWith(
                            fontWeight: FontWeight.w700,
                            color: AppColors.kWhiteColor,
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
          centerTitle: false,
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 10);
}

class DefaultAppBar extends StatelessWidget implements PreferredSizeWidget {
  const DefaultAppBar({
    required this.title,
    super.key,
  });
  final String title;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const Positioned.fill(
          child: ColoredBox(color: AppColors.primary),
        ),
        Positioned.fill(
          child: Image.asset(
            Images.appBarPattern,
            fit: BoxFit.fill,
          ),
        ),
        AppBar(
          centerTitle: true,
          backgroundColor: Colors.transparent,
          title: Text(
            title,
            style: context.appTitleText?.copyWith(
              color: AppColors.kWhiteColor,
            ),
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
