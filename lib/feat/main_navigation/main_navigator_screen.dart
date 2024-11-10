import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:save_money/feat/homepage/homepage_screen.dart';

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
      appBar: AppBar(
        title: const Text('절약??'),
      ),
      body: Stack(
        children: [
          Offstage(
            offstage: _selectedIndex != 0,
            child: const HomePageScreen(),
          ),
          Offstage(
            offstage: _selectedIndex != 1,
            child: const Center(child: Text('예산')),
          ),
        ],
      ),
      bottomNavigationBar: NavigationBar(
        labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
        backgroundColor: Theme.of(context).primaryColor,
        indicatorColor: Colors.transparent,
        selectedIndex: _selectedIndex,
        onDestinationSelected: _onTap,
        destinations: [
          NavigationDestination(
            icon:
                SvgPicture.asset('assets/svg/navigation/home_light_enable.svg'),
            label: '홈',
          ),
          const NavigationDestination(
            icon: FaIcon(
              FontAwesomeIcons.house,
            ),
            label: '예산',
          ),
        ],
      ),
    );
  }
}
