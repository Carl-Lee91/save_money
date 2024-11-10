import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomePageScreen extends ConsumerStatefulWidget {
  static const String routeName = 'home';
  static const String routeUrl = '/home';

  const HomePageScreen({super.key});

  @override
  ConsumerState<HomePageScreen> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePageScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(16),
            ),
          ],
        ),
      ),
    );
  }
}
