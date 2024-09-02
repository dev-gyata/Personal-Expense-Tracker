import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';
import 'package:personal_expense_tracker/l10n/l10n.dart';
import 'package:personal_expense_tracker/repositories/'
    'expenditure_repository.dart';
import 'package:personal_expense_tracker/repositories/income_repository.dart';
import 'package:personal_expense_tracker/router/app_router.gr.dart';
import 'package:personal_expense_tracker/ui/home/cubits/'
    'expenditure_cubit/expenditure_cubit.dart';
import 'package:personal_expense_tracker/ui/home/cubits/'
    'income_cubit/income_cubit.dart';

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
            appBar: AppBar(
              title: Text(
                switch (tabsRouter.activeIndex) {
                  0 => l10n.dashboard,
                  1 => l10n.expenditure,
                  2 => l10n.settings,
                  _ => '',
                },
              ),
            ),
            body: child,
            floatingActionButtonLocation: ExpandableFab.location,
            floatingActionButton: ExpandableFab(
              overlayStyle: const ExpandableFabOverlayStyle(
                blur: 2,
              ),
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
                  child: Row(
                    children: [
                      const Text('Add Expenditure'),
                      const SizedBox(width: 20),
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
                ),
                GestureDetector(
                  onTap: () {
                    context.navigateTo(
                      CreateIncomeRoute(
                        onIncomeCreated:
                            context.read<IncomeCubit>().onRefreshIncome,
                      ),
                    );
                    _expandableFabKey.currentState?.toggle();
                  },
                  child: Row(
                    children: [
                      const Text('Add Revenue'),
                      const SizedBox(width: 20),
                      FloatingActionButton.small(
                        heroTag: null,
                        child: const Icon(Icons.add),
                        onPressed: () {
                          _expandableFabKey.currentState?.toggle();
                          CreateIncomeRoute(
                            onIncomeCreated:
                                context.read<IncomeCubit>().onRefreshIncome,
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
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
