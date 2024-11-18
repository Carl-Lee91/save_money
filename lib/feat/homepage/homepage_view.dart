import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:save_money/feat/homepage/widgets/calender_widget.dart';

class HomePageView extends ConsumerStatefulWidget {
  static const String routeName = 'home';
  static const String routeUrl = '/home';

  const HomePageView({super.key});

  @override
  ConsumerState<HomePageView> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePageView> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            CalenderWidget(),
          ],
        ),
      ),
    );
  }
}
