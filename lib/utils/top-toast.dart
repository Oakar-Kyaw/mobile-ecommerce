import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class TopToast {
  /// Show a top toast
  static void show({
    required BuildContext context,
    String? title,
    String? description,
    IconData? icon = LucideIcons.circleCheckBig,
    Color? iconColor = Colors.green,
    Duration duration = const Duration(seconds: 5),
    BorderRadius? borderRadius,
    Alignment alignment = Alignment.topCenter,
    Widget? action,
    Widget? closeIcon,
  }) {
    return ShadToaster.of(context).show(
      ShadToast(
        alignment: alignment,
        action: action,
        closeIcon: closeIcon,
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (icon != null)
              Icon(icon, color: iconColor, size: 20, weight: 700),
            if (icon != null) const SizedBox(width: 10),
            if (title != null)
              Text(
                title,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
          ],
        ),
        description: Row(
          children: [
            if (icon != null) const SizedBox(width: 30),
            if (description != null) Text(description),
          ],
        ),
        radius: borderRadius ?? BorderRadius.circular(12),
        duration: duration,
      ),
    );
  }
}
