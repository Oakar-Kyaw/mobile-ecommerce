import 'package:ecommerce_mobile/components/app-bar.dart';
import 'package:ecommerce_mobile/components/divider.dart';
import 'package:ecommerce_mobile/components/product-card.dart';
import 'package:ecommerce_mobile/riverpod/system-configuration.dart';
import 'package:ecommerce_mobile/src/app-route.dart';
import 'package:ecommerce_mobile/ui/horizontal-scroll-avatar.ui.dart';
import 'package:ecommerce_mobile/ui/horizontal-scroll-item.ui.dart';
import 'package:ecommerce_mobile/ui/product-tab-bar.ui.dart';
import 'package:ecommerce_mobile/ui/title.dart';
import 'package:ecommerce_mobile/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BrandDetailPage extends ConsumerStatefulWidget {
  const BrandDetailPage({super.key});

  @override
  ConsumerState<BrandDetailPage> createState() => _BrandDetailPageState();
}

class _BrandDetailPageState extends ConsumerState<BrandDetailPage>
    with SingleTickerProviderStateMixin {

  late TabController tabController;
  double _tabContentHeight = 50;
  String _tabValue = "products";

  final List<Map<String, dynamic>> brandAssets = [
    {'title': 'BMW', 'imageUrl': 'assets/images/bmw.jpg'},
    {'title': 'Ford', 'imageUrl': 'assets/images/ford.jpg'},
    {'title': 'Nike', 'imageUrl': 'assets/images/nike.jpg'},
    {'title': 'Tesla', 'imageUrl': 'assets/images/tesla.jpg'},
    {'title': 'Toyota', 'imageUrl': 'assets/images/toyota.jpg'},
    {'title': 'Shirt Co.', 'imageUrl': 'assets/images/shirt.jpg'},
    {'title': 'Facebook', 'imageUrl': 'assets/images/facebook.png'},
  ];

  final List<Map<String, dynamic>> products = [
    {
      "title": "Classic White Shirt",
      "imageUrl": "assets/images/menshirt.jpg",
      "description": "Soft cotton white shirt, perfect for casual or formal wear.",
      "price": 40000,
      "currency": "MMK"
    },
    {
      "title": "Denim Jeans",
      "imageUrl": "assets/images/jean.jpg",
      "description": "Slim fit denim jeans with stretchable fabric.",
      "price": 55000,
      "currency": "MMK"
    },
    {
      "title": "Leather Jacket",
      "imageUrl": "assets/images/jacket.jpg",
      "description": "Premium black leather jacket with inner lining.",
      "price": 120000,
      "currency": "MMK"
    },
    {
      "title": "Sneakers",
      "imageUrl": "assets/images/sneaker.jpg",
      "description": "Comfortable and lightweight sneakers for everyday use.",
      "price": 65000,
      "currency": "MMK"
    },
  ];

  @override
  void initState() {
    super.initState();

    tabController = TabController(length: 2, vsync: this);

    tabController.addListener(() {
      if (!tabController.indexIsChanging) {
        setState(() {
          _tabValue =
              tabController.index == 0 ? 'products' : 'profile';

          _tabContentHeight =
              _tabValue == 'products' ? 150 : MediaQuery.of(context).size.height;
        });
      }
    });
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

   void handleTabBar(int value, String? pf) {
    print("pf $pf");
    setState(() {
      _tabValue = value == 0 ? "products" : "profile";
      _tabContentHeight = value == 0  ? 150 : MediaQuery.of(context).size.height;
    });
  }

  @override
  Widget build(BuildContext context) {
    final IAppColorAbstract config = ref.watch(appColorProvider);

    return Scaffold(
      appBar: CustomAppBar(
        config: config,
        title: "Brand Info",
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: const Icon(Icons.arrow_back),
        ),
      ),
      body: Container(
        color: config.greyColor,
        child: CustomScrollView(
          slivers: [
            /// 🔹 BRAND HEADER
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  children: [
                    Container(
                      width: 70,
                      height: 70,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: AssetImage("assets/images/puma.jpg"),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          "Brand Name (Brand code)",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text("99% positive feedback"),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            //Divider
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.only(top: 5),
                child: Divider(
                  color: config.lineColor,
                ),
              ),
            ),

            SliverToBoxAdapter(
              child: TabBar(
                isScrollable: true,
                tabAlignment: TabAlignment.start,
                labelColor: config.primary,
                overlayColor: WidgetStateColor.transparent,
                labelStyle: TextStyle(
                fontWeight: FontWeight.bold
                ),
                unselectedLabelStyle: TextStyle(
                    fontWeight: FontWeight.normal
                ),
                labelPadding: EdgeInsets.zero,
                indicatorColor: config.primary,
                indicatorPadding: EdgeInsetsGeometry.only(left: 20),
                //indicatorPadding: _tabValue == "products" ? EdgeInsetsGeometry.only(left: 20): EdgeInsetsGeometry.zero,
                dividerColor: config.lineColor,
                controller: tabController,
                onTap: (value) => handleTabBar(value, "this is on tap"),
               // onFocusChange: (value, index) => handleTabBar(value as int, "change focust"),
                tabs: [
                Tab(
                  child: Padding(
                    padding: const EdgeInsets.only(left :20),
                    child: Text('Products'),
                  )
                ),
                Tab(
                  child: Padding(
                      padding: EdgeInsets.only(left: 20),
                      child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text('Profile'),
                        ],
                        ),
                      ),
                        ),
                ],
              ),
            ),
           
           /// 🔹 BRAND INFO TAB CONTENT
            SliverToBoxAdapter(
              child: SizedBox(
                height: _tabContentHeight,
                child: TabBarView(
                  controller: tabController,
                  children: [
                    SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                        child: const Text(
                          'A product is anything offered for sale to satisfy a customer is need or want, encompassing tangible goods (like cars, food), intangible services (like software, consulting), digital items (ebooks, apps), or even concepts, forming the core offering a business provides to the market, resulting from production and exchange for value. Key aspects of a product:Tangible vs. Intangible: Can be a physical item (clothing, electronics) or an intangible service (streaming, education).',
                          //overflow: TextOverflow.clip,
                          style: TextStyle(fontSize: 14),
                        ),
                      ),
                    ),
                    // Reviews tab placeholder
                    SingleChildScrollView(
                      padding: EdgeInsetsGeometry.symmetric(vertical: 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                           Padding(
                             padding: const EdgeInsets.all(20),
                             child: Text("About this company", style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
                           ),
                           Padding(
                             padding: const EdgeInsets.symmetric(horizontal:  20),
                             child: Text("A company profile description is a concise overview of a business, like a professional biography, detailing its mission, history, products/services, goals, and values to inform customers, investors, partners, and potential employees. It acts as a key marketing and branding tool, building trust and presenting a strong, cohesive brand identity across various platforms, from websites to investor pitches. ", overflow: TextOverflow.clip,),
                           ),
                           const SizedBox(height: 20,),
                           Container(
                             color: config.lineColor,
                             padding:  EdgeInsets.symmetric(vertical: 20),
                             child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                   Padding(
                                     padding: const EdgeInsets.all(20),
                                     child: Text("Company Info", style: TextStyle(fontWeight: FontWeight.bold),),
                                   ),
                                   Padding(
                                     padding: const EdgeInsets.only(bottom:  10, left: 20),
                                     child: Row(
                                       children: [
                                         Text("Address:   "),
                                         Text("Yangon, Myanmar")
                                       ],
                                     ),
                                   ),
                                   Padding(
                                     padding: const EdgeInsets.only(bottom:  10, left: 20),
                                     child: Row(
                                       children: [
                                         Text("Phone:    "),
                                         Text("09454353452")
                                       ],
                                     ),
                                   ),
                                   Padding(
                                     padding: const EdgeInsets.only(bottom:  10, left: 20),
                                     child: Row(
                                       children: [
                                         Text("Email:   "),
                                         Text("alex@gmail.com")
                                       ],
                                     ),
                                   ),
                                ],
                             ),
                           )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            if(_tabValue == "products")
            /// 🔹 CATEGORIES
            SliverToBoxAdapter(
              child: TitleWidget(
                'Categories',
                onTap: () =>
                    Navigator.pushNamed(context, AppRoute.categories),
              ),
            ),

            if(_tabValue == "products")
            SliverToBoxAdapter(
              child: SizedBox(
                height: 100,
                child: HorizontalScrollableBrand(datas: brandAssets, type: "brand",),
              ),
            ),

            if(_tabValue == "products")
            /// 🔹 DIVIDER
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: DoubleLineTriangleDivider(
                  color: config.lineColor,
                ),
              ),
            ),

            if(_tabValue == "products")
            /// 🔹 TRENDING ITEMS
            SliverToBoxAdapter(
              child: TitleWidget(
                "Trending Items",
                onTap: () =>
                    Navigator.pushNamed(context, AppRoute.trendingItems),
              ),
            ),

            if(_tabValue == "products")
            SliverToBoxAdapter(
              child: SizedBox(
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
            ),

            /// 🔹 BOTTOM SPACE
            const SliverToBoxAdapter(
              child: SizedBox(height: 40),
            ),
          ],
        ),
      ),
    );
  }
}
