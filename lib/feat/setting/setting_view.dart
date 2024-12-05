import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'package:save_money/feat/auth/view/social_login_view.dart';
import 'package:save_money/public_method/public_method.dart';

class SettingView extends ConsumerWidget {
  static const String routeName = 'setting';
  static const String routeUrl = '/setting';

  const SettingView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final GoogleSignIn googleSignIn = GoogleSignIn();

    final String? platform = prefs.getString('platform');

    Future<void> handleLogoutGoogle() async {
      await googleSignIn.signOut();
    }

    Future<void> handleLogoutKakao() async {
      await UserApi.instance.logout();
    }

    Future<void> unLinkKakao() async {
      try {
        OAuthToken? kakaoAccessToken =
            await TokenManagerProvider.instance.manager.getToken();
        if (kakaoAccessToken != null) {
          await AuthApi.instance.refreshToken(oldToken: kakaoAccessToken);

          await UserApi.instance.unlink();
        } else {}
      } catch (e) {
        debugPrint('Kakao 로그아웃 중 오류 발생. 상세내역: $e');
      }
    }

    Future<void> logout() async {
      if (platform == 'kakao') {
        await handleLogoutKakao();
      } else if (platform == 'google') {
        await handleLogoutGoogle();
      }
      prefs.clear();
      secureStorage.deleteAll();
      if (!context.mounted) return;
      context.goNamed(SocialLoginView.routeName);
    }

    Future<void> withdrawal() async {
      if (platform == 'kakao') {
        await unLinkKakao();
      } else if (platform == 'google') {
        await handleLogoutGoogle();
      }
      prefs.clear();
      secureStorage.deleteAll();
      if (!context.mounted) return;
      context.goNamed(SocialLoginView.routeName);
    }

    return Scaffold(
      appBar: AppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () async => await logout(),
                child: const Text(
                  '로그아웃',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                  ),
                ),
              ),
              const Gap(30),
              ElevatedButton(
                onPressed: () async => await withdrawal(),
                child: const Text(
                  '회원탈퇴',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
