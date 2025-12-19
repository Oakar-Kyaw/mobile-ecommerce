import 'package:ecommerce_mobile/components/app-bar.dart';
import 'package:ecommerce_mobile/riverpod/system-configuration.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CategoriesPage extends ConsumerWidget {
  CategoriesPage({super.key});

  final List<Map<String, String>> brandList = [
    {"name": "Nike", "photoUrl": "assets/images/nike.jpg"},
    {"name": "Puma", "photoUrl": "assets/images/puma.jpg"},
    {"name": "Reebok", "photoUrl": "assets/images/reebook.jpg"},
    {"name": "Shein", "photoUrl": "assets/images/shein.jpg"},
    {"name": "Zara", "photoUrl": "assets/images/zara.jpg"},
    {"name": "H&M", "photoUrl": "assets/images/handm.jpg"},
    {"name": "Asics", "photoUrl": "assets/images/asis.jpg"},
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final config = ref.watch(appColorProvider);

    return Scaffold(
      appBar: CustomAppBar(
        config: config,
        title: "Categories",
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: const Icon(Icons.arrow_back),
        ),
      ),

      body: Container(
        color: config.greyColor,
        child: Row(
          children: [
            /// LEFT SIDE MENU
            Container(
              width: 90,
              color: config.background,
              child: ListView.separated(
                separatorBuilder: (context, index) => const Divider(color: Color.fromARGB(255, 236, 235, 235)),
                itemCount: brandList.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                    child: Center(
                      child: Text(
                        brandList[index]['name']!,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
        
            /// RIGHT GRID
            Expanded(
              child: CustomScrollView(
                slivers: [
                  SliverPadding(
                    padding: const EdgeInsets.only(left: 10, right: 20, top:10),
                    sliver: SliverGrid(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          final brand = brandList[index];
        
                          return GestureDetector(
                            onTap: () {
                              debugPrint("Clicked: ${brand['name']}");
                            },
                            child: Column(
                              children: [
                                /// IMAGE (takes remaining space)
                                Expanded(
                                  child: Center(
                                    child: AspectRatio(
                                      aspectRatio: 1, // ✅ forces square
                                      child: ClipOval(
                                        child: Image.asset(
                                          brand['photoUrl']!,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 6),
        
                                /// TEXT (fixed height)
                                SizedBox(
                                  height: 18,
                                  child: Text(
                                    brand['name']!,
                                    textAlign: TextAlign.center,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(fontSize: 12),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                        childCount: brandList.length,
                      ),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 12,
                        mainAxisSpacing: 12,
                        childAspectRatio: 0.85,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
