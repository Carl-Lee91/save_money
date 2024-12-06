import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:save_money/feat/auth/view/social_login_view.dart';
import 'package:save_money/feat/setting/view_model/setting_view_model.dart';

class SettingView extends ConsumerWidget {
  static const String routeName = 'setting';
  static const String routeUrl = '/setting';

  const SettingView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final logoutState = ref.watch(settingViewModelProvider);

    ref.listen<AsyncValue<void>>(
      settingViewModelProvider,
      (previous, next) {
        if (next.hasError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('에러 발생: ${next.error}')),
          );
        } else if (next.isLoading) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('처리 중...')),
          );
        } else {
          context.goNamed(SocialLoginView.routeName);
        }
      },
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('설정'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (logoutState.isLoading)
            const Center(child: CircularProgressIndicator())
          else
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () =>
                      ref.read(settingViewModelProvider.notifier).logout(),
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
                  onPressed: () =>
                      ref.read(settingViewModelProvider.notifier).withdrawal(),
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
