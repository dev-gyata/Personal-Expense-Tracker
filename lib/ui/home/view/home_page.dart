import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';
import 'package:gap/gap.dart';
import 'package:personal_expense_tracker/l10n/l10n.dart';
import 'package:personal_expense_tracker/repositories/'
    'expenditure_repository.dart';
import 'package:personal_expense_tracker/repositories/income_repository.dart';
import 'package:personal_expense_tracker/router/app_router.gr.dart';
import 'package:personal_expense_tracker/ui/home/cubits/'
    'expenditure_cubit/expenditure_cubit.dart';
import 'package:personal_expense_tracker/ui/home/cubits/'
    'income_cubit/income_cubit.dart';
import 'package:personal_expense_tracker/ui/widgets/app_bar_widget.dart';

@RoutePage()
class HomePage extends StatelessWidget {
  HomePage({super.key});

  final _expandableFabKey = GlobalKey<ExpandableFabState>();

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ExpenditureCubit(
            expenditureRepository: context.read<ExpenditureRepository>(),
          )..onLoadExpenditure(),
        ),
        BlocProvider(
          create: (context) => IncomeCubit(
            incomeRepository: context.read<IncomeRepository>(),
          )..onLoadIncome(),
        ),
      ],
      child: AutoTabsRouter(
        routes: const [
          DashboardRoute(),
          ExpenditureRoute(),
          SettingsRoute(),
        ],
        transitionBuilder: (context, child, animation) => FadeTransition(
          opacity: animation,
          child: child,
        ),
        builder: (context, child) {
          final tabsRouter = AutoTabsRouter.of(context);
          return Scaffold(
            appBar: switch (tabsRouter.activeIndex) {
              0 => const HomePageAppBar(),
              1 => DefaultAppBar(title: l10n.expenditure),
              2 => DefaultAppBar(title: l10n.settings),
              _ => const DefaultAppBar(title: ''),
            },
            body: child,
            floatingActionButtonLocation: ExpandableFab.location,
            floatingActionButton: Builder(
              builder: (context) {
                final tabsRouter = AutoTabsRouter.of(context, watch: true);
                if (tabsRouter.activeIndex != 0) {
                  return const SizedBox.shrink();
                }
                return ExpandableFab(
                  key: _expandableFabKey,
                  overlayStyle: const ExpandableFabOverlayStyle(
                    blur: 2,
                  ),
                  children: [
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            _expandableFabKey.currentState?.toggle();
                            context.navigateTo(
                              CreateExpenditureRoute(
                                onExpenseCreated: context
                                    .read<ExpenditureCubit>()
                                    .onRefreshExpenditure,
                              ),
                            );
                          },
                          child: Text(l10n.addExpenditure),
                        ),
                        const Gap(10),
                        FloatingActionButton.small(
                          heroTag: null,
                          child: const Icon(Icons.add),
                          onPressed: () {
                            _expandableFabKey.currentState?.toggle();
                            context.navigateTo(
                              CreateExpenditureRoute(
                                onExpenseCreated: context
                                    .read<ExpenditureCubit>()
                                    .onRefreshExpenditure,
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            _expandableFabKey.currentState?.toggle();
                            context.navigateTo(
                              CreateIncomeRoute(
                                onIncomeCreated:
                                    context.read<IncomeCubit>().onRefreshIncome,
                              ),
                            );
                          },
                          child: Text(l10n.addRevenue),
                        ),
                        const Gap(10),
                        FloatingActionButton.small(
                          heroTag: null,
                          child: const Icon(Icons.add),
                          onPressed: () {
                            _expandableFabKey.currentState?.toggle();
                            context.navigateTo(
                              CreateIncomeRoute(
                                onIncomeCreated:
                                    context.read<IncomeCubit>().onRefreshIncome,
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ],
                );
              },
            ),
            bottomNavigationBar: BottomNavigationBar(
              onTap: tabsRouter.setActiveIndex,
              currentIndex: tabsRouter.activeIndex,
              items: [
                BottomNavigationBarItem(
                  icon: const Icon(Icons.home),
                  label: l10n.dashboard,
                ),
                BottomNavigationBarItem(
                  icon: const Icon(Icons.money_off_rounded),
                  label: l10n.expenditure,
                ),
                BottomNavigationBarItem(
                  icon: const Icon(Icons.settings),
                  label: l10n.settings,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
