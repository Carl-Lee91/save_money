import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:save_money/theme/app_colors.dart';

class BudgetCategoryWidget extends ConsumerWidget {
  const BudgetCategoryWidget({
    super.key,
    required this.onIncomeTap,
    required this.onOutputTap,
    required this.isIncomeSelected,
    required this.isOutputSelected,
  });

  final VoidCallback onIncomeTap;
  final VoidCallback onOutputTap;
  final bool isIncomeSelected;
  final bool isOutputSelected;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: onIncomeTap,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              '수입',
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    color: isIncomeSelected
                        ? ThemeMode.system == ThemeMode.dark
                            ? AppColors.darkPrimaryColor
                            : AppColors.lightPrimaryColor
                        : AppColors.disableColor,
                  ),
            ),
          ),
        ),
        const Gap(5),
        GestureDetector(
          onTap: onOutputTap,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              '지출',
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    color: isOutputSelected
                        ? ThemeMode.system == ThemeMode.dark
                            ? AppColors.darkPrimaryColor
                            : AppColors.lightPrimaryColor
                        : AppColors.disableColor,
                  ),
            ),
          ),
        ),
      ],
    );
  }
}
