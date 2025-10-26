import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class FilterComponent extends StatefulWidget {
  const FilterComponent({super.key});

  @override
  State<FilterComponent> createState() => _FilterComponentState();
}

class _FilterComponentState extends State<FilterComponent> {
  @override
  Widget build(BuildContext context) {
    final colorScheme = ShadTheme.of(context).colorScheme;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20 , vertical: 8),
      decoration: BoxDecoration(color: colorScheme.background),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Left: item count
          const Row(
            children: [
              Text("512,344+", style: TextStyle(fontWeight: FontWeight.bold)),
              SizedBox(width: 6),
              Text("items"),
            ],
          ),

          // Right: Sort & Filter buttons
          Row(
            children: [
              Row(
                children: [
                  const Text("Sort"),
                  const SizedBox(width: 6),
                  ShadIconButton.ghost(
                    onPressed: () => print('Primary'),
                    icon: const Icon(LucideIcons.arrowDownUp),
                  ),
                ],
              ),
              const SizedBox(width: 10),
              Row(
                children: [
                  const Text("Filter"),
                  const SizedBox(width: 6),
                  ShadIconButton.ghost(
                    onPressed: () => print('Primary'),
                    icon: const Icon(LucideIcons.listFilter),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
