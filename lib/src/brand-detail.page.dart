import 'package:ecommerce_mobile/components/app-bar.dart';
import 'package:ecommerce_mobile/components/divider.dart';
import 'package:ecommerce_mobile/components/product-card.dart';
import 'package:ecommerce_mobile/riverpod/brand.dart';
import 'package:ecommerce_mobile/riverpod/system-configuration.dart';
import 'package:ecommerce_mobile/src/app-route.dart';
import 'package:ecommerce_mobile/ui/horizontal-scroll-item.ui.dart';
import 'package:ecommerce_mobile/ui/title.dart';
import 'package:ecommerce_mobile/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BrandDetailPage extends ConsumerStatefulWidget {
  final int? id;
  const BrandDetailPage({
    super.key,
    this.id
  });

  @override
  ConsumerState<BrandDetailPage> createState() => _BrandDetailPageState();
}

class _BrandDetailPageState extends ConsumerState<BrandDetailPage>
    with SingleTickerProviderStateMixin {

  late TabController tabController;
  double _tabContentHeight = 50;
  String _tabValue = "products";

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
    setState(() {
      _tabValue = value == 0 ? "products" : "profile";
      _tabContentHeight = value == 0  ? 150 : MediaQuery.of(context).size.height;
    });
  }

  @override
  Widget build(BuildContext context) {
    final IAppColorAbstract config = ref.watch(appColorProvider);
    final brandAsync = ref.watch(brandDetailProvider(widget.id!));

    return Scaffold(
      appBar: CustomAppBar(
        config: config,
        title: "Brand Info",
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: const Icon(Icons.arrow_back),
        ),
      ),
      body: brandAsync.when(
        loading: () => const Center(child: CircularProgressIndicator(),),
        error: (err, stack) => Center(child: Text("Error in Fetching Brand Detail")),
        data: (brand){
          if(brand == null){
            return const Center(child: Text("Brand not found"));
          }
          return Container(
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
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: brand.photoUrl != null && brand.photoUrl!.isNotEmpty ? DecorationImage(
                          image: NetworkImage(brand.photoUrl ?? ""),
                          fit: BoxFit.cover,
                        ) :
                        DecorationImage(
                          image: AssetImage("assets/images/default.jpg"),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          brand.name,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(brand.feedback ?? ""),
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
                        child:  Text( brand.description ?? "",//overflow: TextOverflow.clip,
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
                             child: Text(brand.info ?? "", overflow: TextOverflow.clip,),
                           ),
                           const SizedBox(height: 20,),
                           Container(
                             color: config.lineColor,
                             padding:  EdgeInsets.symmetric(vertical: 20),
                             child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                   Padding(
                                     padding: const EdgeInsets.all(10),
                                     child: Text("Company Info", style: TextStyle(fontWeight: FontWeight.bold),),
                                   ),
                                   Padding(
                                     padding: const EdgeInsets.only(bottom:  10, left: 20),
                                     child: Row(
                                       children: [
                                         Text("Address:   "),
                                         Text(brand.address ?? "")
                                       ],
                                     ),
                                   ),
                                   Padding(
                                     padding: const EdgeInsets.only(bottom:  10, left: 20),
                                     child: Row(
                                       children: [
                                         Text("Phone:    "),
                                         Text(brand.phone ?? "")
                                       ],
                                     ),
                                   ),
                                   Padding(
                                     padding: const EdgeInsets.only(bottom:  10, left: 20),
                                     child: Row(
                                       children: [
                                         Text("Email:   "),
                                         Text(brand.email ?? "")
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
            // SliverToBoxAdapter(
            //   child: SizedBox(
            //     height: 100,
            //     child: HorizontalScrollableBrand(datas: brandAssets, type: "brand",),
            //   ),
            // ),

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
      );
        }
      ),
    );
  }
}
