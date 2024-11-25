import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:save_money/feat/dashboard/homepage/widgets/calender_widget.dart';
import 'package:save_money/feat/dashboard/widget/arrow_row_widget.dart';
import 'package:save_money/theme/app_colors.dart';

class HomePageView extends ConsumerStatefulWidget {
  static const String routeName = 'home';
  static const String routeUrl = '/home';

  const HomePageView({super.key});

  @override
  ConsumerState<HomePageView> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePageView> {
  late int _selectMonth;

  @override
  void initState() {
    super.initState();
    _selectMonth = DateTime.now().month;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            _homeTop(context),
            const CalenderWidget(),
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
                const Gap(16),
                ArrowRowWidget(
                  leftGap: 8,
                  rightGap: 8,
                  leftOnTap: () {},
                  rightOnTap: () {},
                  contextWidget: Text(
                    '$_selectMonth월',
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          fontWeight: FontWeight.w700,
                          fontSize: 20,
                          color: AppColors.whiteColor,
                        ),
                  ),
                ),
                const Gap(16),
                const Text('이번달 소비 목표보다\n12만원 더 썼어요'),
                const Gap(16),
                _budget(title: '수입', money: '3,000,000원'),
                _budget(title: '지출', money: '-700,000원'),
                const Gap(30),
              ],
            ),
          ),
        ),
        Positioned(
          right: 16,
          child: Image.asset(
            'assets/images/big_dollar.png',
            width: 151,
            height: 107,
          ),
        ),
      ],
    );
  }

  Widget _budget({
    required String title,
    required String money,
  }) {
    return Row(
      children: [
        Text(title),
        const Gap(4),
        Text(money),
      ],
    );
  }
}
