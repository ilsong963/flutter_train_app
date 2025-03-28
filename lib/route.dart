import 'package:flutter_train_app/botton_navigation_bar_scaffold.dart';
import 'package:flutter_train_app/page/details/details_page.dart';
import 'package:flutter_train_app/page/home/home.dart';
import 'package:flutter_train_app/page/seat_select/seat_page.dart';
import 'package:flutter_train_app/page/station_list/station_list_page.dart';
import 'package:go_router/go_router.dart';

final router = GoRouter(
  initialLocation: '/home',
  routes: [
    StatefulShellRoute.indexedStack(
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/home',
              pageBuilder:
                  (context, state) => const NoTransitionPage(child: HomePage()),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/details',
              pageBuilder:
                  (context, state) =>
                      const NoTransitionPage(child: DetailsPage()),
            ),
          ],
        ),
      ],

      builder:
          (context, state, child) => BottomNavigationBarScaffold(child: child),
    ),
    GoRoute(
      path: '/seat',
      pageBuilder:
          (context, state) => NoTransitionPage(
            child: SeatPage(
              startingStation: (state.extra as Map)['startingStation'],
              destinationStation: (state.extra as Map)['destinationStation'],
            ),
          ),
    ),
    GoRoute(
      path: '/stationList',
      pageBuilder:
          (context, state) => NoTransitionPage(
            child: StationListPage(
              title: (state.extra as Map)['title'],
              exceptStation: (state.extra as Map)['exceptStation'],
            ),
          ),
    ),
  ],
);
