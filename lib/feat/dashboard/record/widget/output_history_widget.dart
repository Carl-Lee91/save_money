import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:save_money/theme/app_colors.dart';

class OutputHistoryWidget extends ConsumerWidget {
  const OutputHistoryWidget({
    super.key,
    required this.budgetCategory,
    required this.time,
    required this.category,
    required this.output,
    this.memo,
  });

  final String budgetCategory;
  final String time;
  final String category;
  final String output;
  final String? memo;

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
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Column(
              children: [
                Row(
                  children: [
                    Text(
                      budgetCategory,
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            fontSize: 14,
                            color: AppColors.mainTextColor,
                          ),
                    ),
                    const Gap(8),
                    DecoratedBox(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: ThemeMode.system == ThemeMode.dark
                              ? AppColors.subText2Color
                              : AppColors.lineSubTextColor,
                        ),
                      ),
                      child: const SizedBox(
                        height: 6,
                        width: 1,
                      ),
                    ),
                    const Gap(8),
                    Text(
                      time,
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: AppColors.lightSubTextColor,
                          ),
                    ),
                  ],
                ),
                const Gap(12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    DecoratedBox(
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(6)),
                        color: AppColors.kakaoLoginColor,
                      ),
                      child: SizedBox(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 4,
                          ),
                          child: Text(
                            category,
                            style:
                                Theme.of(context).textTheme.bodyLarge!.copyWith(
                                      fontSize: 14,
                                      color: AppColors.whiteColor,
                                    ),
                          ),
                        ),
                      ),
                    ),
                    Text(
                      output,
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: AppColors.mainTextColor,
                          ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          if (memo != null)
            Container(
              decoration: const BoxDecoration(
                color: AppColors.bgColor200,
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: Row(
                  children: [
                    Text(
                      '지출메모: ',
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: AppColors.lightSubTextColor,
                          ),
                    ),
                    const Gap(4),
                    Text(
                      memo!,
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: AppColors.lightSubTextColor,
                          ),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}
