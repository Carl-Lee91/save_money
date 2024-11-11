import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:save_money/theme/app_colors.dart';

class MainAppBar extends ConsumerWidget implements PreferredSizeWidget {
  const MainAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AppBar(
      title: const Text('거지방'),
      backgroundColor: AppColors.primaryColor,
      actions: [
        SvgPicture.asset(
          'assets/svg/app_bar/notification.svg',
          width: 24,
          height: 24,
        ),
        const Gap(12),
        SvgPicture.asset(
          'assets/svg/app_bar/setting.svg',
          width: 24,
          height: 24,
        ),
        const Gap(12),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
