import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:save_money/feat/auth/view/widgets/social_login_btn.dart';
import 'package:save_money/feat/passing/passing_screen.dart';
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
              onTap: () => context.goNamed(PassingScreen.routeName),
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
