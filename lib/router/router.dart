import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:save_money/feat/auth/view/social_login_view.dart';
import 'package:save_money/feat/global_widget/main_navigation/main_navigator_screen.dart';
import 'package:save_money/feat/passing/passing_screen.dart';

final routerProvider = Provider(
  (ref) {
    return GoRouter(
      initialLocation: PassingScreen.routeUrl,
      routes: [
        GoRoute(
          name: SocialLoginView.routeName,
          path: SocialLoginView.routeUrl,
          pageBuilder: (context, state) =>
              const CupertinoPage(child: SocialLoginView()),
        ),
        GoRoute(
          name: PassingScreen.routeName,
          path: PassingScreen.routeUrl,
          pageBuilder: (context, state) =>
              const CupertinoPage(child: PassingScreen()),
        ),
        GoRoute(
          path: '/:tab(home|record)',
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
