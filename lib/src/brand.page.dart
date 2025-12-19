import 'package:ecommerce_mobile/api/brand-api.service.dart';
import 'package:ecommerce_mobile/components/app-bar.dart';
import 'package:ecommerce_mobile/riverpod/system-configuration.dart';
import 'package:ecommerce_mobile/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BrandPage extends ConsumerWidget {
  BrandPage({super.key});

  //list all brand data
  Future<List<Map<String, dynamic>>> fetchAllBrandData() async {
    final response = await getAllBrandApiData();

    if (response != null && response["success"] == true) {
      return List<Map<String, dynamic>>.from(
        response["data"].map(
          (e) => Map<String, dynamic>.from(e),
        ),
      );
    }

    return [];
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final IAppColorAbstract config = ref.watch(appColorProvider);
    return Scaffold(
      appBar:  CustomAppBar(config: config, title: "Brand", leading: GestureDetector(
          child: const Icon(Icons.arrow_back),
          onTap: () => Navigator.pop(context),
        ),),
      body: Container(
        color: config.greyColor,
        child: CustomScrollView(
          slivers: [
            // 🔹 Brand Grid
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              sliver: FutureBuilder<List<Map<String, dynamic>>>(
                future: fetchAllBrandData(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const SliverToBoxAdapter(
                        child: Center(child: CircularProgressIndicator()),
                    );
                  }

                  if (snapshot.hasError) {
                    return const SliverToBoxAdapter(child: Center(child: Text("Failed to load brands")));
                  }

                  final brands = snapshot.data ?? [];

                  if (brands.isEmpty) {
                    return const SliverToBoxAdapter(child:  Center(child: Text("No brands found")));
                  }

                  return SliverGrid(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        final brand = brands[index];
                        final String? photoUrl = brand['photoUrl'];
                        print("photoUrl in brand page: $photoUrl");
                        //image
                        final Image image = (photoUrl != null && photoUrl.isNotEmpty)
                            ? Image.network(photoUrl, fit: BoxFit.cover)
                            : Image.asset("assets/images/default.jpg", fit: BoxFit.cover);

                        return GestureDetector(
                          onTap: () {
                            debugPrint("Clicked: ${brand['name']}");
                          },
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              AspectRatio(
                                aspectRatio: 1, // perfect circle
                                child: Container(
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.grey.shade100,
                                  ),
                                  padding: const EdgeInsets.all(2),
                                  child: ClipOval(
                                    child: image,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 6),
                              Text(
                                brand["name"]!,
                                textAlign: TextAlign.center,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        );
                      },
                      childCount: brands.length,
                    ),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                      childAspectRatio: 0.75,
                    ),
                  );
                }
              ),
            ),
        
            // 🔹 Bottom spacing
            const SliverToBoxAdapter(
              child: SizedBox(height: 20),
            ),
          ],
        ),
      ),
    );
  }
}
