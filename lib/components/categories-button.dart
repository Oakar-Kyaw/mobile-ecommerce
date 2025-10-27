import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class CategoryButton extends StatelessWidget {
  final String title;
  final bool isSelected;
  final VoidCallback onTap;

  const CategoryButton({
    super.key,
    required this.title,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = ShadTheme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 7),
      child: ShadButton.outline(
        width: 15,
        decoration: ShadDecoration(
          color: isSelected
              ? colorScheme.secondary.withOpacity(0.2)
              : colorScheme.background,
          border: ShadBorder.all(
            color: isSelected ? colorScheme.primary : colorScheme.border,
            width: isSelected ? 2 : 1,
            radius: BorderRadius.circular(24),
          ),
        ),
        onPressed: onTap,
        child: Text(
          "Myanmar",
          style: TextStyle(
            color: isSelected ? colorScheme.primary : colorScheme.foreground,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
          ),
        ),
      ),
    );
  }
}
