import 'package:ecommerce_mobile/components/app-bar.dart';
import 'package:ecommerce_mobile/components/product-card.dart';
import 'package:ecommerce_mobile/riverpod/system-configuration.dart';
import 'package:ecommerce_mobile/src/app-route.dart';
import 'package:ecommerce_mobile/ui/horizontal-scroll-item.ui.dart';
import 'package:ecommerce_mobile/ui/product-tab-bar.ui.dart';
import 'package:ecommerce_mobile/ui/review-component.ui.dart';
import 'package:ecommerce_mobile/ui/title.dart';
import 'package:ecommerce_mobile/utils/review.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ecommerce_mobile/utils/constant.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class ProductDetailPage extends ConsumerStatefulWidget {
  const ProductDetailPage({super.key});

  @override
  ConsumerState<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends ConsumerState<ProductDetailPage> with SingleTickerProviderStateMixin {

  final List<Map<String, dynamic>> products = [
    {"title": "Classic White Shirt","imageUrl": "assets/images/menshirt.jpg","description": "Soft cotton white shirt, perfect for casual or formal wear.","price": 40000,"currency": "MMK"},
    {"title": "Denim Jeans","imageUrl": "assets/images/jean.jpg","description": "Slim fit denim jeans with stretchable fabric.","price": 55000,"currency": "MMK"},
    {"title": "Leather Jacket","imageUrl": "assets/images/jacket.jpg","description": "Premium black leather jacket with inner lining.","price": 120000,"currency": "MMK"},
    {"title": "Sneakers","imageUrl": "assets/images/sneaker.jpg","description": "Comfortable and lightweight sneakers for everyday use.","price": 65000,"currency": "MMK"},
    {"title": "Smart Watch","imageUrl": "assets/images/smartwatch.jpg","description": "Waterproof smartwatch with heart rate and sleep tracking.","price": 850000,"currency": "MMK"},
  ];

  final List<String> images = [
    "assets/images/white-shirt.jpg",
    "assets/images/white-shirt.jpg",
    "assets/images/white-shirt.jpg",
    "assets/images/white-shirt.jpg",
  ];

  final List<String> sizes = ["XS", "S", "M", "L", "XL", "XXL"];

  final List<String> colorHex = [
    "#FF0000", "#00FF00", "#0000FF", "#FFFF00", "#FFA500", "#800080",
  ];

  late TabController tabController;
  late double _tabContentHeight = 100;

  String _tabValue = "description";

  Color hexToColor(String code) {
    code = code.replaceAll("#", "");
    if (code.length == 6) code = "FF$code";
    return Color(int.parse(code, radix: 16));
  }

  int quantity = 2;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);

    // Listen for swipe or tap changes
    tabController.addListener(() {
      // Only run when animation is completed
      if (!tabController.indexIsChanging) {
        setState(() {
          _tabValue = tabController.index == 0 ? 'description' : 'reviews';

          // Update dynamic height
          _tabContentHeight = _tabValue == 'description' ? 100 : 600;
        });
      }
    });
  }


  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }
  
  void handleTabBar(int value) {
    setState(() {
      _tabValue = value == 0 ? 'description' : 'reviews';
    });
  }

  @override
  Widget build(BuildContext context) {
    final IAppColorAbstract config = ref.watch(appColorProvider);

    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(
          config: config,
          leading: GestureDetector(
            child: const Icon(Icons.arrow_back),
            onTap: () => Navigator.pop(context),
          ),
          lastIcon: const Icon(Icons.shopping_cart),
          title: "Product Detail",
        ),
        body: CustomScrollView(
          slivers: [
            // Main Product Image
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Stack(
                    children: [
                      Image.asset(
                        "assets/images/white-shirt.jpg",
                        fit: BoxFit.cover,
                        height: 250,
                        width: double.infinity,
                      ),
                      Container(
                        height: 250,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                            colors: [
                              Colors.black.withOpacity(0.5),
                              Colors.transparent,
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        top: 16,
                        right: 16,
                        child: Container(
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            color: config.promotionBadgeColor,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(Icons.favorite_border, size: 18),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // Thumbnail Images
            SliverToBoxAdapter(
              child: SizedBox(
                height: 80,
                child: HorizontalScrollableList(
                  spacing: 8,
                  items: images,
                  itemBuilder: (context, image, index) {
                    return Container(
                      width: 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        image: DecorationImage(
                          image: AssetImage(image),
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),

            // Product Details
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10),
                    const Text("Shirt T (Sis-Burma)", style: TextStyle(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 10),
                    const Text("\$50", style: TextStyle(decoration: TextDecoration.lineThrough, color: Colors.grey)),
                    const SizedBox(height: 5),

                    // Price + Quantity
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text("\$29.99", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                        Row(
                          children: [
                            GestureDetector(
                              onTap: () => setState(() { if(quantity > 1) quantity--; }),
                              child: circleWidget(colorData: config.textSecondary, widgetData: const Icon(Icons.remove, size: 16), height: 28, width: 28),
                            ),
                            const SizedBox(width: 10),
                            Text("$quantity", style: const TextStyle(fontSize: 16)),
                            const SizedBox(width: 10),
                            GestureDetector(
                              onTap: () => setState(() { quantity++; }),
                              child: circleWidget(colorData: config.textPrimary, widgetData: const Icon(Icons.add, size: 16), height: 28, width: 28),
                            ),
                          ],
                        ),
                      ],
                    ),

                    const SizedBox(height: 10),
                    Divider(color: config.lineColor, thickness: 1),
                    const SizedBox(height: 10),
                    Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: const [Text("Color: White"), Text("Availability: In Stock")]),
                    const SizedBox(height: 10),
                    Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: const [Text("Weight: 0.5kg"), Text("Category: T-shirt")]),
                    const SizedBox(height: 10),
                    Divider(color: config.lineColor, thickness: 1),
                    const SizedBox(height: 10),
                    const Text("Size Chart", style: TextStyle(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 10),

                    // Size selector
                    SizedBox(
                      height: 50,
                      child: HorizontalScrollableList(
                        padding: EdgeInsets.all(0),
                        spacing: 8,
                        items: sizes,
                        itemBuilder: (context, size, index) {
                          return circleWidget(colorData: config.textSecondary, widgetData: Text(size, style: const TextStyle(fontWeight: FontWeight.bold)), height: 40, width: 40);
                        },
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text("Color", style: TextStyle(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 10),

                    SizedBox(
                      height: 50,
                      child: HorizontalScrollableList(
                        padding: EdgeInsets.all(0),
                        spacing: 8,
                        items: colorHex,
                        itemBuilder: (context, hex, index) {
                          return circleWidget(colorData: config.textSecondary, widgetData: Container(decoration: BoxDecoration(shape: BoxShape.circle, color: hexToColor(hex))), height: 40, width: 40);
                        },
                      ),
                    ),
                    const SizedBox(height: 10),
                    Divider(color: config.lineColor, thickness: 1),

                    // Branch info
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            circleWidget(colorData: Colors.transparent, widgetData: Image.asset("assets/images/bmw.jpg", fit: BoxFit.cover), height: 60, width: 60),
                            const SizedBox(width: 10),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("BMW Car (Branch Code)", style: TextStyle(fontWeight: FontWeight.bold)),
                                Text("99% positive feedback")
                              ],
                            )
                          ],
                        ),
                        GestureDetector(child: Icon(Icons.message))
                      ],
                    ),
                    const SizedBox(height: 10),
                    Divider(color: config.lineColor, thickness: 1),

                    // TabBar + TabBarView
                    ProductTabBar(config: config, tabValue: _tabValue, reviewLength: reviews.length, tabController: tabController, handleTabBar: handleTabBar),

                    // ✅ Fixed TabBarView for dynamic content height
                    SizedBox(
                      height: _tabContentHeight,
                      child: TabBarView(
                        controller: tabController,
                        children: [
                          SingleChildScrollView(
                            padding: const EdgeInsets.symmetric(vertical: 15),
                            child:  const Text(
                              'A product description is persuasive marketing copy explaining what a product is, its features, benefits, and why a customer should buy it, often using vivid language to help buyers visualize it and feel an emotional connection, ultimately driving sales. It\'s more than just specs; it tells a story, highlights unique selling points (USPs), and uses SEO-friendly language to attract the right audience and answer potential questions, according to resources from Shopify and ClearVoice. Key elements to include: Features & Specs: Dimensions, materials, technical details, colors, weight. Benefits: How the product solves problems or improves the customer\'s life (focus on benefits over just features). Unique Selling Points (USPs): What makes it special or different.A product description is persuasive marketing copy explaining what a product is, its features, benefits, and why a customer should buy it, often using vivid language to help buyers visualize it and feel an emotional connection, ultimately driving sales. It is more than just specs; it tells a story, highlights unique selling points (USPs), and uses SEO-friendly language to attract the right audience and answer potential questions, according to resources from',
                              style: TextStyle(fontSize: 14),
                            ),
                          ),
                          SingleChildScrollView(
                            child: ReviewUI(
                              reviews: reviews,
                              starColor: config.starColor,
                              textSecondary: config.textSecondary,
                              clickColor: config.clickColor,
                              background: config.background,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          child: CircleAvatar(backgroundColor: config.buttonBackgroundPrimary, child: Icon(Icons.home, color: config.primary))
                        ),
                        ShadButton(
                          backgroundColor: config.buttonBackgroundPrimary,
                          onPressed: () { print("Button pressed!"); },
                          leading: Icon(Icons.shopping_cart, color: config.textPrimary),
                          decoration: ShadDecoration(border: ShadBorder.all(radius: BorderRadius.circular(20))),
                          child: const Text("Add to Cart", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
                        ),
                        ShadButton(
                          backgroundColor: config.clickColor,
                          onPressed: () { print("Button pressed!"); },
                          decoration: ShadDecoration(border: ShadBorder.all(radius: BorderRadius.circular(20))),
                          child: const Text("Order Now", style: TextStyle(fontWeight: FontWeight.bold)),
                        ),
                      ],
                    ),
                    const SizedBox(height: 15),
                  ],
                ),
              ),
            ),

            // Related Products
            SliverToBoxAdapter(
              child: Column(
                children: [
                  TitleWidget("Related Product", onTap: () => Navigator.pushNamed(context, AppRoute.trendingItems)),
                  const SizedBox(height: 10),
                  SizedBox(
                    height: 320,
                    child: HorizontalScrollableList<Map<String, dynamic>>(
                      items: products,
                      itemBuilder: (context, product, index) {
                        return ProductCard(
                          config: config,
                          title: product["title"],
                          imageUrl: product["imageUrl"],
                          description: product["description"],
                          price: product["price"],
                          currency: product["currency"],
                        );
                      },
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

/// ✅ Reusable circular widget
Widget circleWidget({
  required Color colorData,
  required Widget widgetData,
  required double height,
  required double width
}) {
  return Container(
    height: height,
    width: width,
    decoration: BoxDecoration(
      border: Border.all(color: colorData, width: 1),
      shape: BoxShape.circle,
    ),
    child: Center(child: widgetData),
  );
}