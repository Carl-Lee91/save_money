import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:save_money/feat/dashboard/record/widget/output_history_widget.dart';
import 'package:save_money/feat/dashboard/widget/arrow_row_widget.dart';
import 'package:save_money/feat/dashboard/widget/rec_btn.dart';
import 'package:save_money/theme/app_colors.dart';

class RecordView extends ConsumerWidget {
  static const String routeName = 'record';
  static const String routeUrl = '/record';

  const RecordView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            _homeTop(context),
            _outputDetail(context),
            const OutputHistoryWidget(
              budgetCategory: '지출',
              time: '오전 11시 40분',
              category: '배달',
              output: '-30,000원',
            ),
            const OutputHistoryWidget(
              budgetCategory: '지출',
              time: '오전 11시 40분',
              category: '배달',
              output: '-30,000원',
              memo: '관리비',
            ),
            const OutputHistoryWidget(
              budgetCategory: '지출',
              time: '오전 11시 40분',
              category: '배달',
              output: '-30,000원',
            ),
          ],
        ),
      ),
      floatingActionButton: SvgPicture.asset(
        ThemeMode.system == ThemeMode.dark
            ? 'assets/svg/dashboard/add_dark.svg'
            : 'assets/svg/dashboard/add_light.svg',
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  Widget _outputDetail(context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '소비기록 (3건)',
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: AppColors.mainTextColor,
                ),
          ),
          ArrowRowWidget(
            leftGap: 8,
            rightGap: 8,
            leftOnTap: () {},
            rightOnTap: () {},
            contextWidget: Text(
              '24.11.10',
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    fontSize: 16,
                    color: AppColors.mainTextColor,
                  ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _homeTop(BuildContext context) {
    return Stack(
      children: [
        Container(
          color: ThemeMode.system == ThemeMode.dark
              ? AppColors.darkPrimaryColor
              : AppColors.lightPrimaryColor,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Gap(30),
                Text(
                  '이번달 소비 목표를\n설정해 주세요',
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        fontWeight: FontWeight.w700,
                        fontSize: 22,
                        color: AppColors.whiteColor,
                      ),
                ),
                const Gap(30),
                RecBtn(
                  onTap: () {},
                  backgroundColor: ThemeMode.system == ThemeMode.dark
                      ? AppColors.mainTextColor
                      : AppColors.whiteColor,
                  contextWidget: Text(
                    '소비목표 설정하기',
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          fontSize: 14,
                          color: AppColors.lightPrimaryColor,
                        ),
                  ),
                ),
                const Gap(20),
              ],
            ),
          ),
        ),
        Positioned(
          right: 23,
          top: 24,
          child: Image.asset(
            'assets/images/small_dollar.png',
            width: 134,
            height: 73,
          ),
        ),
      ],
    );
  }
}
