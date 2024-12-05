import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:save_money/feat/auth/view/social_login_view.dart';
import 'package:save_money/feat/global_widget/main_navigation/main_navigator_screen.dart';
import 'package:save_money/feat/passing/passing_view.dart';
import 'package:save_money/feat/setting/setting_view.dart';
import 'package:save_money/public_method/public_method.dart';

final routerProvider = Provider(
  (ref) {
    String uid = prefs.getString('userID') ?? '';
    return GoRouter(
      initialLocation:
          uid.isEmpty ? SocialLoginView.routeUrl : PassingView.routeUrl,
      routes: [
        GoRoute(
          name: SocialLoginView.routeName,
          path: SocialLoginView.routeUrl,
          pageBuilder: (context, state) =>
              const CupertinoPage(child: SocialLoginView()),
        ),
        GoRoute(
          name: PassingView.routeName,
          path: PassingView.routeUrl,
          pageBuilder: (context, state) =>
              const CupertinoPage(child: PassingView()),
        ),
        GoRoute(
          name: SettingView.routeName,
          path: SettingView.routeUrl,
          pageBuilder: (context, state) =>
              const CupertinoPage(child: SettingView()),
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
