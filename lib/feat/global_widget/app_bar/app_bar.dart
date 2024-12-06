import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:save_money/feat/setting/view/setting_view.dart';

class MainAppBar extends ConsumerWidget implements PreferredSizeWidget {
  const MainAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    void navigateSettingView() {
      context.pushNamed(SettingView.routeName);
    }

    return AppBar(
      actions: [
        SvgPicture.asset(
          'assets/svg/app_bar/notification.svg',
          width: 24,
          height: 24,
        ),
        const Gap(12),
        GestureDetector(
          onTap: navigateSettingView,
          child: SvgPicture.asset(
            'assets/svg/app_bar/setting.svg',
            width: 24,
            height: 24,
          ),
        ),
        const Gap(12),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
