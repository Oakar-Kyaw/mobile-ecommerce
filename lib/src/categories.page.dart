import 'package:ecommerce_mobile/api/categories-api.service.dart';
import 'package:ecommerce_mobile/components/app-bar.dart';
import 'package:ecommerce_mobile/riverpod/system-configuration.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ecommerce_mobile/response/category.dart';

// --- Provider inside this file ---
final categoriesProvider = FutureProvider.autoDispose<List<Category>>((ref) async {
  final List<Category> response = await getAllCategoriesApiData();
  print("response is: $response");
  return response;
});

class CategoriesPage extends ConsumerStatefulWidget {
  const CategoriesPage({super.key});

  @override
  ConsumerState<CategoriesPage> createState() => _CategoriesPageState();
}

class _CategoriesPageState extends ConsumerState<CategoriesPage> {
  List<SubCategory> subCate = [];

  @override
  Widget build(BuildContext context) {
    final config = ref.watch(appColorProvider);
    final categoriesAsync = ref.watch(categoriesProvider);

    return Scaffold(
      appBar: CustomAppBar(
        config: config,
        title: "Categories",
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: const Icon(Icons.arrow_back),
        ),
      ),
      body: categoriesAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => Center(child: Text("Error: $error")),
        data: (categories) {
          return Container(
            color: config.greyColor,
            child: Row(
              children: [
                // LEFT SIDE MENU
                Container(
                  width: 90,
                  color: config.background,
                  child: ListView.separated(
                    separatorBuilder: (_, __) => const Divider(
                      color: Color.fromARGB(255, 236, 235, 235),
                    ),
                    itemCount: subCate.length,
                    itemBuilder: (context, index) {
                      return subCate.isNotEmpty ? Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 15,
                          horizontal: 20,
                        ),
                        child: Center(
                          child: Text(
                            subCate[index].title,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ) : Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 15,
                          horizontal: 20,
                        ),
                        child: Text("No Subcategories", style: TextStyle(color: config.textPrimary),)
                        );
                    },
                  ),
                ),

                // RIGHT GRID
                Expanded(
                  child: CustomScrollView(
                    slivers: [
                      SliverPadding(
                        padding: const EdgeInsets.only(
                          left: 10,
                          right: 20,
                          top: 10,
                        ),
                        sliver: SliverGrid(
                          delegate: SliverChildBuilderDelegate(
                            (context, index) {
                              final data = categories[index]; // List<Category>
                              final String? photoUrl = data.photoUrl;
                              final Image image = (photoUrl != null && photoUrl.isNotEmpty)
                                  ? Image.network(photoUrl, fit: BoxFit.cover)
                                  : Image.asset("assets/images/default.jpg", fit: BoxFit.cover);

                              return GestureDetector(
                                onTap: () {
                                  print("click is ${data.subCategory}");
                                  setState(() {
                                    subCate = data.subCategory ?? [] ;
                                  });
                                },
                                child: Column(
                                  children: [
                                    // IMAGE
                                    Expanded(
                                      child: Center(
                                        child: AspectRatio(
                                          aspectRatio: 1,
                                          child: ClipOval(child: image),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 6),
                                    // TEXT
                                    SizedBox(
                                      height: 18,
                                      child: Text(
                                        data.title,
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
                            childCount: categories.length, // <-- use categories.length, not brandList
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
          );
        },
      ),
    );
  }
}
