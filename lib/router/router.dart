import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:save_money/feat/main_navigation/main_navigator_screen.dart';
import 'package:save_money/feat/passing_screen/passing_screen.dart';

final routerProvider = Provider(
  (ref) {
    return GoRouter(
      initialLocation: PassingScreen.routeUrl,
      routes: [
        GoRoute(
          name: PassingScreen.routeName,
          path: PassingScreen.routeUrl,
          pageBuilder: (context, state) =>
              const CupertinoPage(child: PassingScreen()),
        ),
        GoRoute(
          path: '/:tab(home|budget)',
          name: MainNavigation.routeName,
          pageBuilder: (context, state) {
            final tab = state.pathParameters['tab']!;
            return CupertinoPage(child: MainNavigation(tab: tab));
          },
        ),
      ],
    );
  },
);
