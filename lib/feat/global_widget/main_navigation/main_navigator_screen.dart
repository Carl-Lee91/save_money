import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:save_money/feat/global_widget/app_bar/app_bar.dart';
import 'package:save_money/feat/homepage/homepage_screen.dart';
import 'package:save_money/feat/homepage/widgets/calender.dart';

class MainNavigation extends ConsumerStatefulWidget {
  static const String routeName = 'mainNavigation';

  const MainNavigation({
    super.key,
    required this.tab,
  });

  final String tab;

  @override
  ConsumerState<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends ConsumerState<MainNavigation> {
  final List<String> _tabs = ['home', 'budget'];

  late int _selectedIndex = _tabs.indexOf(widget.tab);

  void _onTap(int index) {
    context.go('/${_tabs[index]}');
    _selectedIndex = index;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MainAppBar(),
      body: Stack(
        children: [
          Offstage(
            offstage: _selectedIndex != 0,
            child: const HomePageScreen(),
          ),
          Offstage(
            offstage: _selectedIndex != 1,
            child: const CalendarScreen(),
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.fromLTRB(12, 12, 12, 30),
        child: NavigationBar(
          labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
          indicatorColor: Colors.transparent,
          selectedIndex: _selectedIndex,
          onDestinationSelected: _onTap,
          destinations: [
            NavigationDestination(
              selectedIcon: SvgPicture.asset(
                'assets/svg/navigation/home_enable.svg',
                width: 24,
                height: 24,
              ),
              icon: SvgPicture.asset(
                'assets/svg/navigation/home_disable.svg',
                width: 24,
                height: 24,
              ),
              label: '홈',
            ),
            NavigationDestination(
              selectedIcon: SvgPicture.asset(
                'assets/svg/navigation/edit_enable.svg',
                width: 24,
                height: 24,
              ),
              icon: SvgPicture.asset(
                'assets/svg/navigation/edit_disable.svg',
                width: 24,
                height: 24,
              ),
              label: '예산',
            ),
          ],
        ),
      ),
    );
  }
}
