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
    required this.contextWidget,
  });

  final double leftGap;
  final double rightGap;
  final Widget contextWidget;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      children: [
        _chevBtn(svgAsset: 'chev_left.svg'),
        Gap(leftGap),
        contextWidget,
        Gap(rightGap),
        _chevBtn(svgAsset: 'chev_right.svg'),
      ],
    );
  }

  Widget _chevBtn({required String svgAsset}) {
    return Container(
      width: 32,
      height: 32,
      decoration: BoxDecoration(
        border: Border.all(width: 1, color: AppColors.lineSubTextColor),
        borderRadius: BorderRadius.circular(8),
        boxShadow: const [
          BoxShadow(
            color: Color(0xFF000000),
            offset: Offset(0, 1),
            blurRadius: 2,
            spreadRadius: 0,
          ),
        ],
        color: AppColors.whiteColor,
      ),
      child: SvgPicture.asset('assets/svg/dashboard/$svgAsset'),
    );
  }
}