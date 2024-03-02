import 'package:flutter/material.dart';
import 'package:garbage_game/src/spacing.dart';

class BlockButton extends StatelessWidget {
  final double width;
  final double height;
  final void Function()? onPressed;
  final String label;
  final bool isLoading;

  const BlockButton({
    Key? key,
    this.width = double.infinity,
    this.height = 53,
    required this.onPressed,
    required this.label,
    this.isLoading = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        child: isLoading
            ? SizedBox(
                height: Spacing.md,
                width: Spacing.md,
                child: CircularProgressIndicator(
                  color: theme.scaffoldBackgroundColor,
                ),
              )
            : Text(
                label,
                style: const TextStyle().copyWith(
                  fontSize: theme.textTheme.titleLarge?.fontSize,
                  fontWeight: FontWeight.w900,
                ),
              ),
      ),
    );
  }
}
