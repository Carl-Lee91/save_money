import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:save_money/theme/app_colors.dart';

class OutputHistoryWidget extends ConsumerWidget {
  const OutputHistoryWidget({
    super.key,
    required this.budgetCategory,
    required this.time,
  });

  final String budgetCategory;
  final String time;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: ThemeMode.system == ThemeMode.dark
                ? AppColors.lightSubTextColor
                : AppColors.lineSubTextColor,
          ),
        ),
        color: ThemeMode.system == ThemeMode.dark
            ? AppColors.mainTextColor
            : AppColors.whiteColor,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Column(
          children: [
            Row(
              children: [
                Text(budgetCategory),
                const Gap(8),
                const Divider(
                  thickness: 1,
                  height: 6,
                  color: ThemeMode.system == ThemeMode.dark
                      ? AppColors.subText2Color
                      : AppColors.lineSubTextColor,
                ),
                const Gap(8),
                Text(time),
              ],
            ),
            const Gap(12),
            const Row(
              children: [
                //TODO: 여기에 카테고리 및 금액 넣기
              ],
            ),
          ],
        ),
      ),
    );
  }
}
