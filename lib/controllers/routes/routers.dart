import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:reloj_proyecto/models/route_paths.dart';
import 'package:reloj_proyecto/screens/clock_screen.dart';
import 'package:reloj_proyecto/screens/multi_clocks_screen.dart';
import 'package:reloj_proyecto/screens/stop_watch_screen.dart';
import 'package:reloj_proyecto/screens/timer_screen.dart';

class RouterController {
  GoRouter getRoutesConfig() {
    return GoRouter(
      routes: <RouteBase>[
        GoRoute(
          path: '/',
          builder: (BuildContext context, GoRouterState state) {
            return ClockScreen();
          },
          routes: <RouteBase>[
            GoRoute(
              path: RoutePaths.stopWatch,
              builder: (BuildContext context, GoRouterState state) {
                return StopWatchScreen();
              },
            ),
            GoRoute(
              path: RoutePaths.multiClock,
              builder: (BuildContext context, GoRouterState state) {
                return const MultiClocksScreen();
              },
            ),
            GoRoute(
              path: RoutePaths.timer,
              builder: (BuildContext context, GoRouterState state) {
                return const TimerScreen();
              },
            ),
          ],
        ),
      ],
    );
  }
}
