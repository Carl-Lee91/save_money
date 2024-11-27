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
  late DateTime _focusedDate;

  @override
  void initState() {
    super.initState();
    _focusedDate = DateTime.now();
  }

  void _beforeMonth() {
    setState(() {
      _focusedDate = DateTime(
        _focusedDate.year,
        _focusedDate.month - 1,
        1,
      );
    });
  }

  void _nextMonth() {
    setState(() {
      _focusedDate = DateTime(
        _focusedDate.year,
        _focusedDate.month + 1,
        1,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          _homeTop(context),
          const Gap(20),
          CalenderWidget(
            focusedDate: _focusedDate,
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
                const Gap(16),
                ArrowRowWidget(
                  leftGap: 8,
                  rightGap: 8,
                  leftOnTap: _beforeMonth, // 이전 월로 이동
                  rightOnTap: _nextMonth, // 다음 월로 이동
                  contextWidget: Text(
                    '${_focusedDate.month}월',
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          fontWeight: FontWeight.w700,
                          fontSize: 20,
                          color: AppColors.whiteColor,
                        ),
                  ),
                ),
                const Gap(16),
                Text.rich(
                  TextSpan(
                    text: '이번달 소비 목표보다',
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          fontWeight: FontWeight.w700,
                          fontSize: 22,
                          color: AppColors.whiteColor,
                        ),
                    children: [
                      TextSpan(
                        text: '\n12만원',
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                              fontWeight: FontWeight.w700,
                              fontSize: 22,
                              color: const Color(0xFFF2C94C),
                            ),
                      ),
                      TextSpan(
                        text: ' 더 썼어요',
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                              fontWeight: FontWeight.w700,
                              fontSize: 22,
                              color: AppColors.whiteColor,
                            ),
                      ),
                    ],
                  ),
                ),
                const Gap(16),
                _budget(
                  title: '수입',
                  money: '3,000,000원',
                  moneyTextStyle:
                      Theme.of(context).textTheme.bodyLarge!.copyWith(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: AppColors.whiteColor,
                          ),
                ),
                _budget(
                  title: '지출',
                  money: '-700,000원',
                  moneyTextStyle:
                      Theme.of(context).textTheme.bodyLarge!.copyWith(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFFF2C94C),
                          ),
                ),
                const Gap(30),
              ],
            ),
          ),
        ),
        Positioned(
          right: 16,
          bottom: 22,
          child: Image.asset(
            'assets/images/big_dollar.png',
            width: 151,
          ),
        ),
      ],
    );
  }

  Widget _budget({
    required String title,
    required String money,
    required TextStyle moneyTextStyle,
  }) {
    return Row(
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                fontSize: 18,
                color: AppColors.whiteColor,
              ),
        ),
        const Gap(4),
        Text(
          money,
          style: moneyTextStyle,
        ),
      ],
    );
  }
}
