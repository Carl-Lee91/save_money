import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:save_money/theme/app_colors.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onTap;

  const CustomBottomNavigationBar({
    super.key,
    required this.selectedIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      padding: EdgeInsets.zero,
      color: ThemeMode.system == ThemeMode.dark
          ? AppColors.mainTextColor
          : AppColors.whiteColor,
      child: DecoratedBox(
        decoration: const BoxDecoration(
          border: Border(
            top: BorderSide(width: 1, color: AppColors.lineSubTextColor),
          ),
        ),
        child: SizedBox(
          height: 90,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildNavItem(
                index: 0,
                label: '홈',
                selected: selectedIndex == 0,
                icon: 'assets/svg/navigation/home_disable.svg',
                selectedIcon: 'assets/svg/navigation/home_enable.svg',
                onTap: onTap,
                context: context,
              ),
              _buildNavItem(
                index: 1,
                label: '기록',
                selected: selectedIndex == 1,
                icon: 'assets/svg/navigation/edit_disable.svg',
                selectedIcon: 'assets/svg/navigation/edit_enable.svg',
                onTap: onTap,
                context: context,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem({
    required int index,
    required String label,
    required bool selected,
    required String icon,
    required String selectedIcon,
    required ValueChanged<int> onTap,
    required BuildContext context,
  }) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () => onTap(index),
      child: SizedBox(
        width: MediaQuery.sizeOf(context).width * 0.45,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              selected ? selectedIcon : icon,
              width: 24,
              height: 24,
            ),
            const Gap(6),
            Text(
              label,
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    fontSize: 12,
                    color: selected
                        ? AppColors.lightPrimaryColor
                        : AppColors.disableColor,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
