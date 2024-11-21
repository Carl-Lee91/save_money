import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RecBtn extends ConsumerWidget {
  const RecBtn({
    super.key,
    required this.onTap,
    required this.backgroundColor,
    required this.contextWidget,
  });

  final VoidCallback onTap;
  final Color backgroundColor;
  final Widget contextWidget;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          color: backgroundColor,
        ),
        child: Center(
          child: contextWidget,
        ),
      ),
    );
  }
}
