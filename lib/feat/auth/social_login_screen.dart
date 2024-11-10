import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:save_money/constants/app_colors.dart';
import 'package:save_money/feat/auth/widgets/social_login_btn.dart';
import 'package:save_money/feat/passing/passing_screen.dart';

class SocialLoginScreen extends ConsumerWidget {
  static const String routeName = 'login';
  static const String routeUrl = '/login';

  const SocialLoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Column(
        children: [
          const Gap(80),
          const Text('절약하는 즐거움\n가치있는 소비생활의 시작'),
          const Gap(11),
          const Text('로고영역'),
          const Spacer(),
          const Text('sns계정으로 간편하게 시작해 보세요'),
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
              ),
              const Gap(20),
              SocialLoginBtn(
                onTap: () => context.goNamed(PassingScreen.routeName),
                assetsPath: 'assets/svg/login/apple.svg',
                btnColor: AppColors.appleLoginColor,
                isBorder: false,
              ),
            ],
          ),
          const Gap(120),
        ],
      ),
    );
  }
}
