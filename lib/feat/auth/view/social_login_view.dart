import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'package:save_money/feat/auth/view/widgets/social_login_btn.dart';
import 'package:save_money/feat/passing/passing_screen.dart';
import 'package:save_money/public_method/public_method.dart';
import 'package:save_money/theme/app_colors.dart';

class SocialLoginView extends ConsumerWidget {
  static const String routeName = 'login';
  static const String routeUrl = '/login';

  const SocialLoginView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Gap(80),
            _titlePart(context),
            const Gap(8),
            _imagePart(),
            const Spacer(),
            _socialLoginPart(context),
            const Gap(120),
          ],
        ),
      ),
    );
  }

  Widget _titlePart(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            '절약하는 즐거움\n가치있는 소비생활의 시작',
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  fontWeight: FontWeight.w700,
                  fontSize: 22,
                ),
          ),
        ),
        const Gap(11),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            '로고영역',
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  fontWeight: FontWeight.w700,
                  fontSize: 42,
                ),
          ),
        ),
      ],
    );
  }

  Widget _imagePart() {
    return Column(
      children: [
        SizedBox(
          height: 90,
          child: Stack(
            children: [
              Positioned(
                right: 60,
                child: Image.asset(
                  'assets/images/small_dollar_opacity.png',
                  width: 150,
                  height: 90,
                ),
              ),
            ],
          ),
        ),
        const Gap(8),
        SizedBox(
          height: 134,
          child: Stack(
            children: [
              Positioned(
                right: -19,
                child: Image.asset(
                  'assets/images/big_dollar.png',
                  width: 189,
                  height: 134,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _socialLoginPart(BuildContext context) {
    bool deviceApple = Platform.isIOS;

    Future<void> signInKakao() async {
      try {
        final dio = Dio();

        bool isInstalled = await isKakaoTalkInstalled();
        OAuthToken token;
        if (isInstalled) {
          try {
            token = await UserApi.instance.loginWithKakaoTalk();
          } catch (e) {
            token = await UserApi.instance.loginWithKakaoAccount();
          }
        } else {
          token = await UserApi.instance.loginWithKakaoAccount();
        }
        final response = await dio.post(
          'https://kapi.kakao.com/v2/user/me',
          options: Options(
            headers: {
              HttpHeaders.authorizationHeader: 'Bearer ${token.accessToken}',
            },
          ),
        );

        final Map<String, dynamic> profileInfo = response.data;

        print(profileInfo);

        final int? userID = profileInfo['id'];

        await secureStorage.write(
          key: 'kakaoAccessToken',
          value: token.accessToken,
        );
        await secureStorage.write(
          key: 'kakaoRefreshToken',
          value: token.refreshToken,
        );
      } catch (error) {
        debugPrint('카카오 로그인 중 에러가 일어났습니다. 에러내역: $error');
      }
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child: Text(
            'sns계정으로 간편하게 시작해 보세요',
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: ThemeMode.system == ThemeMode.dark
                      ? AppColors.lineSubTextColor
                      : AppColors.lightSubTextColor,
                ),
          ),
        ),
        const Gap(16),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SocialLoginBtn(
              onTap: () async {
                await signInKakao();
              },
              assetsPath: 'assets/svg/login/kakao.svg',
              btnColor: AppColors.kakaoLoginColor,
              isBorder: false,
            ),
            const Gap(20),
            SocialLoginBtn(
              onTap: () => context.goNamed(PassingScreen.routeName),
              assetsPath: 'assets/svg/login/google.svg',
              btnColor: AppColors.whiteColor,
              isBorder: true,
              borderColor: AppColors.lineSubTextColor,
            ),
            const Gap(20),
            if (deviceApple)
              ThemeMode.system == ThemeMode.dark
                  ? SocialLoginBtn(
                      onTap: () => context.goNamed(PassingScreen.routeName),
                      assetsPath: 'assets/svg/login/apple.svg',
                      btnColor: AppColors.appleLoginColor,
                      isBorder: true,
                      borderColor: AppColors.subText2Color,
                    )
                  : SocialLoginBtn(
                      onTap: () => context.goNamed(PassingScreen.routeName),
                      assetsPath: 'assets/svg/login/apple.svg',
                      btnColor: AppColors.appleLoginColor,
                      isBorder: false,
                    ),
          ],
        ),
      ],
    );
  }
}
