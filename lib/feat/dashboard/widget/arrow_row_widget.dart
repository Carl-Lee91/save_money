import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:save_money/theme/app_colors.dart';

class ArrowRowWidget extends ConsumerWidget {
  const ArrowRowWidget({
    super.key,
    required this.leftGap,
    required this.rightGap,
    required this.leftOnTap,
    required this.rightOnTap,
    required this.contextWidget,
  });

  final double leftGap;
  final double rightGap;
  final VoidCallback leftOnTap;
  final VoidCallback rightOnTap;
  final Widget contextWidget;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      children: [
        _chevBtn(
          svgAsset: ThemeMode.system == ThemeMode.dark
              ? 'chev_left_dark.svg'
              : 'chev_left_light.svg',
          onTap: leftOnTap,
        ),
        Gap(leftGap),
        contextWidget,
        Gap(rightGap),
        _chevBtn(
          svgAsset: ThemeMode.system == ThemeMode.dark
              ? 'chev_right_dark.svg'
              : 'chev_right_light.svg',
          onTap: rightOnTap,
        ),
      ],
    );
  }

  Widget _chevBtn({
    required String svgAsset,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 32,
        height: 32,
        decoration: BoxDecoration(
          border: Border.all(
            width: 1,
            color: ThemeMode.system == ThemeMode.dark
                ? AppColors.lightSubTextColor
                : AppColors.lineSubTextColor,
          ),
          borderRadius: BorderRadius.circular(8),
          boxShadow: const [
            BoxShadow(
              color: Color(0xFF000000),
              offset: Offset(0, 1),
              blurRadius: 2,
              spreadRadius: 0,
            ),
          ],
          color: ThemeMode.system == ThemeMode.dark
              ? AppColors.darkCardColor
              : AppColors.whiteColor,
        ),
        child: SvgPicture.asset('assets/svg/dashboard/$svgAsset'),
      ),
    );
  }
}
