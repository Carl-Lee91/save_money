import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SocialLoginBtn extends ConsumerWidget {
  const SocialLoginBtn({
    super.key,
    required this.onTap,
    required this.btnColor,
    required this.assetsPath,
    required this.isBorder,
    this.borderColor,
  });

  final VoidCallback onTap;
  final Color btnColor;
  final String assetsPath;
  final bool isBorder;
  final Color? borderColor;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 60,
        width: 60,
        decoration: BoxDecoration(
          color: btnColor,
          shape: BoxShape.circle,
          border: isBorder ? Border.all(color: borderColor!, width: 1) : null,
        ),
        child: Padding(
          padding:
              isBorder ? const EdgeInsets.all(14) : const EdgeInsets.all(15),
          child: SvgPicture.asset(assetsPath),
        ),
      ),
    );
  }
}
