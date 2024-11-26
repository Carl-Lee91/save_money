import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:save_money/feat/dashboard/homepage/homepage_view.dart';
import 'package:save_money/feat/dashboard/record/record_view.dart';
import 'package:save_money/feat/global_widget/app_bar/app_bar.dart';
import 'package:save_money/feat/global_widget/bottom_navigation_bar.dart/bottom_navigation_bar.dart';

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
  final List<String> _tabs = ['home', 'record'];

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
            child: const HomePageView(),
          ),
          Offstage(
            offstage: _selectedIndex != 1,
            child: const RecordView(),
          ),
        ],
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        onTap: _onTap,
        selectedIndex: _selectedIndex,
      ),
    );
  }
}
