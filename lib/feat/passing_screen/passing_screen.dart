import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class PassingScreen extends ConsumerWidget {
  static const String routeName = 'passing';
  static const String routeUrl = '/passing';

  const PassingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    void onTap() {
      context.go('/home');
    }

    return Scaffold(
      appBar: AppBar(),
      body: GestureDetector(
        onTap: onTap,
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Text(
                '요리비책',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
