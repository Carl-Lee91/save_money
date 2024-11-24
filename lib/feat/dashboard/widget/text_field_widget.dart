import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:save_money/theme/app_colors.dart';

class TextFieldWidget extends ConsumerWidget {
  const TextFieldWidget({
    super.key,
    required this.hintText,
    required this.deleteOnTap,
    required this.textEditingController,
    required this.focusNode,
  });

  final String hintText;
  final VoidCallback deleteOnTap;
  final TextEditingController textEditingController;
  final FocusNode focusNode;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return TextField(
      controller: textEditingController,
      focusNode: focusNode,
      cursorColor: AppColors.lightPrimaryColor,
      cursorWidth: 1,
      decoration: InputDecoration(
        hintText: hintText,
        isDense: false,
        contentPadding: const EdgeInsets.fromLTRB(4, 9, 0, 9),
        border: UnderlineInputBorder(
          borderSide: BorderSide(
            color: focusNode.hasFocus
                ? AppColors.mainTextColor
                : AppColors.lineSubTextColor,
          ),
        ),
        suffixIcon: focusNode.hasFocus && textEditingController.text.isNotEmpty
            ? GestureDetector(
                onTap: textEditingController.clear,
                child: SvgPicture.asset(
                  'assets/svg/delete.svg',
                  width: 22,
                  height: 22,
                ),
              )
            : null,
      ),
    );
  }
}
