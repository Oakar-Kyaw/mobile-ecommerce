import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class SearchInput extends StatefulWidget {
  const SearchInput({super.key});

  @override
  State<SearchInput> createState() => _SearchInputState();
}

class _SearchInputState extends State<SearchInput> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final colorScheme = ShadTheme.of(context).colorScheme;

    return Container(
      height: 42,
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      alignment: Alignment.center, // 👈 keeps content vertically centered
      child: ShadInput(
        controller: _controller, // 👈 fix misalignment
        placeholder: const Text(
          'Search any product',
          style: TextStyle(fontSize: 14),
        ),
        decoration: ShadDecoration(
          color: colorScheme.background,
          focusedBorder: null,
          border: ShadBorder.all(
            color: colorScheme.border,
            radius: BorderRadius.circular(10),
          ),
        ),
        leading: Icon(
          LucideIcons.search,
          color: colorScheme.mutedForeground,
          size: 18,
        ),
        // trailing: _controller.text.isNotEmpty
        //     ? IconButton(
        //         //padding: EdgeInsets.zero, // 👈 avoid expanding vertically
        //         //constraints: const BoxConstraints(),
        //         icon: Icon(
        //           Icons.close,
        //           color: colorScheme.mutedForeground,
        //           // size: 16,
        //         ),
        //         onPressed: () {
        //           setState(() => _controller.clear());
        //         },
        //       )
        //     : null,
        onChanged: (value) {
          setState(() {});
          print("Search query: $value");
        },
      ),
    );
  }
}
