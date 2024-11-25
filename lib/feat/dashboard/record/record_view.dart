import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
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
          ],
        ),
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
                const Text('이번달 소비 목표를\n설정해 주세요'),
                const Gap(30),
                RecBtn(
                  onTap: () {},
                  backgroundColor: ThemeMode.system == ThemeMode.dark
                      ? AppColors.mainTextColor
                      : AppColors.whiteColor,
                  contextWidget: const Text('소비목표 설정하기'),
                ),
                const Gap(20),
              ],
            ),
          ),
        ),
        Positioned(
          right: 23,
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
