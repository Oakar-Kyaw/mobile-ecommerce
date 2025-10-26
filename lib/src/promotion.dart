import 'package:ecommerce_mobile/components/app-bar.dart';
import 'package:ecommerce_mobile/components/categories-button.dart';
import 'package:ecommerce_mobile/components/filter-component.dart';
import 'package:ecommerce_mobile/components/search-input.dart';
import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart'; // 👈 Import your button file

class PromotionPage extends StatefulWidget {
  const PromotionPage({super.key});

  @override
  State<PromotionPage> createState() => _PromotionPageState();
}

class _PromotionPageState extends State<PromotionPage> {
  final List<String> categories = [
    "All",
    "Electronics",
    "Fashion",
    "Home",
    "Beauty",
    "Toys",
    "Sports",
    "Books",
    "Groceries",
  ];

  String selectedCategory = "All";

  @override
  Widget build(BuildContext context) {
    final colorScheme = ShadTheme.of(context).colorScheme;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: CustomAppBar(title: 'promotion')
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            
            // Search input
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: SearchInput(),
            ),
            const SizedBox(height: 5),
            FilterComponent(),
            ]
          ),
        )
    //   body: SafeArea(
    //     child: Column(
    //       crossAxisAlignment: CrossAxisAlignment.start,
    //       children: [
    //         // 🔹 Category section
    //         SingleChildScrollView(
    //           scrollDirection: Axis.horizontal,
    //           padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    //           child: Row(
    //             children: categories.map((category) {
    //               final isSelected = category == selectedCategory;
    //               return CategoryButton(
    //                 title: category,
    //                 isSelected: isSelected,
    //                 onTap: () {
    //                   setState(() => selectedCategory = category);
    //                   print("Selected category: $category");
    //                 },
    //               );
    //             }).toList(),
    //           ),
    //         ),
    //         const SearchInput(),

    //         const FilterComponent(),
    //         // 🔹 Promotion items grid
    //         Expanded(
    //           child: Padding(
    //             padding: const EdgeInsets.all(12),
    //             child: GridView.builder(
    //               itemCount: 8,
    //               gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
    //                 crossAxisCount: 2,
    //                 childAspectRatio: 0.8,
    //                 crossAxisSpacing: 12,
    //                 mainAxisSpacing: 12,
    //               ),
    //               itemBuilder: (context, index) {
    //                 return ShadCard(
    //                   child: Column(
    //                     crossAxisAlignment: CrossAxisAlignment.start,
    //                     children: [
    //                       Expanded(
    //                         child: ClipRRect(
    //                           borderRadius: BorderRadius.circular(12),
    //                           child: Container(
    //                             color: colorScheme.muted.withOpacity(0.2),
    //                             child: const Center(
    //                               child: Icon(
    //                                 LucideIcons.image,
    //                                 size: 48,
    //                                 color: Colors.grey,
    //                               ),
    //                             ),
    //                           ),
    //                         ),
    //                       ),
    //                       const SizedBox(height: 8),
    //                       Text(
    //                         "Product ${index + 1}",
    //                         style: Theme.of(context).textTheme.titleMedium,
    //                       ),
    //                       const SizedBox(height: 4),
    //                       Text(
    //                         "\$${(20 + index * 5)}.00",
    //                         style: TextStyle(
    //                           color: colorScheme.primary,
    //                           fontWeight: FontWeight.bold,
    //                         ),
    //                       ),
    //                       const SizedBox(height: 6),
    //                       ShadButton(
    //                         size: ShadButtonSize.sm,
    //                         onPressed: () => print("Add Product ${index + 1}"),
    //                         child: const Text("Add to Cart"),
    //                       ),
    //                     ],
    //                   ),
    //                 );
    //               },
    //             ),
    //           ),
    //         ),
    //       ],
    //     ),
    //   ),
     );
  }
}
