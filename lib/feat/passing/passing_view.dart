import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class PassingView extends ConsumerWidget {
  static const String routeName = 'passing';
  static const String routeUrl = '/passing';

  const PassingView({super.key});

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
                '거지방',
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
