import 'package:ecommerce_mobile/api/brand-api.service.dart';
import 'package:ecommerce_mobile/api/categories-api.service.dart';
import 'package:ecommerce_mobile/api/product.api.dart';
import 'package:ecommerce_mobile/components/app-bar.dart';
import 'package:ecommerce_mobile/components/bottom-navigation-bar.dart';
import 'package:ecommerce_mobile/components/divider.dart';
import 'package:ecommerce_mobile/components/search-input.dart';
import 'package:ecommerce_mobile/components/swiper.dart';
import 'package:ecommerce_mobile/response/brand.dart';
import 'package:ecommerce_mobile/response/category.dart';
import 'package:ecommerce_mobile/response/product.dart';
import 'package:ecommerce_mobile/riverpod/system-configuration.dart';
import 'package:ecommerce_mobile/riverpod/theme-provider.dart';
import 'package:ecommerce_mobile/src/app-route.dart';
import 'package:ecommerce_mobile/ui/horizontal-scroll-avatar.ui.dart';
import 'package:ecommerce_mobile/ui/title.dart';
import 'package:ecommerce_mobile/ui/horizontal-scroll-item.ui.dart';
import 'package:ecommerce_mobile/utils/constant.dart';
import 'package:ecommerce_mobile/utils/system-configuration-constant.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce_mobile/components/product-card.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

final categoriesProvider = FutureProvider.autoDispose<List<Category>>((ref) async {
  final List<Category> response = await getAllCategoriesApiData();
 // print("response is: $response");
  return response;
});

final trendingItemProvider = FutureProvider.autoDispose<List<Product>>((ref) async{
  final productApi = ProductApi();
  final apiResponse = await productApi.getAllProductByTrendingItemApiData();
  print("api is $apiResponse");
  return apiResponse;
});

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  int _selectedIndex = 0; // Tracks the currently selected tab

  @override
  void initState(){
  //   FirebaseMessaging.onMessage.listen((RemoteMessage message) {
  //   print('Foreground message: ${message.messageId}');
  //   if (message.notification != null) {
  //     print('Title: ${message.notification!.title}');
  //     print('Body: ${message.notification!.body}');
  //   }
  // });
   // backgroundHandler()
  }

  requestNotification() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );
  }

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
  {
    "title": "Smart Watch",
    "imageUrl": "assets/images/smartwatch.jpg",
    "description": "Waterproof smartwatch with heart rate and sleep tracking.",
    "price": 850000,
    "currency": "MMK"
  },
];


  Future<List<Brand>> fetchAllBrandData() async {
    final response = await getAllBrandApiData();

    if (response != null && response["success"] == true) {
      final List data = response["data"];
    //  print("response data: ${data}");
      return data.map((e) => Brand.fromJson(Map<String, dynamic>.from(e))).toList();
    }

    return [];
  }

  @override
  Widget build(BuildContext context) {
   
    final IAppColorAbstract config = ref.watch(appColorProvider);
    final currentTheme = ref.watch(themeModeProvider);
    final fontConfig = FontSizeConfiguration.appFontSize(context);
    //categories
    final categoriesAsync = ref.watch(categoriesProvider);
    final trendingProductAsync = ref.watch(trendingItemProvider);
    //print("Current Theme in Home Page: $currentTheme, $themeModeProvider, ScreenWidth: $fontConfig, ScreenHeight: $fontConfig");
    
    return ShadToaster(
      child: Scaffold(
        backgroundColor: config.background,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(kToolbarHeight),
          child: CustomAppBar(
            config: config,
            leading: GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, AppRoute.login);
          },child: Icon(Icons.menu)), lastIcon: GestureDetector(onTap: () => Navigator.pushNamed(context, AppRoute.notifications) , child: Icon(Icons.notifications)), imageUrl: "assets/images/megasmart.png", trailing: GestureDetector(onTap: () => Navigator.pushNamed(context, AppRoute.cart) ,child: Icon(Icons.shopping_cart))),
        ),
        body: ListView.builder(
          padding: const EdgeInsets.only(top: 20),
      
          itemBuilder:(BuildContext context, index){ 
           return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Search input
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: SearchInput(),
              ),
              const SizedBox(height: 20),
      
              // Promotions
              TitleWidget('Promotions', isExistedIcon: false),
              const SizedBox(height: 10),
              SwiperCard(config: config),
              const SizedBox(height: 5),
              
              // Brands section
              TitleWidget('Brands', onTap: () => Navigator.pushNamed(context, AppRoute.brand)),
              SizedBox(
                height: 100,
                child: FutureBuilder<List<Brand>>(
                  future: fetchAllBrandData(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }
      
                    if (snapshot.hasError) {
                      return const Center(child: Text("Failed to load brands"));
                    }
      
                    final brands = snapshot.data ?? [];
      
                    if (brands.isEmpty) {
                      return const Center(child: Text("No brands found"));
                    }
      
                    return HorizontalScrollableBrand(
                      datas: brands,
                      isCheckBorderRadius: true,
                      type: "brand",
                    );
                  },
                ),
              ),
      
              const SizedBox(height: 25),
              DoubleLineTriangleDivider(color: config.lineColor),
      
              // Categories section
              TitleWidget('Categories',  onTap: () => Navigator.pushNamed(context, AppRoute.categories)),
              categoriesAsync.when(
                data: (category){
                  return SizedBox(
                      height: 100,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.symmetric(horizontal: 25),
                        itemCount: category.length,
                        separatorBuilder: (context, index) => const SizedBox(width: 10),
                        itemBuilder: (context, index) {
                          final data = category[index];
                          final String? photoUrl = data.photoUrl;
                          final Image image = (photoUrl != null && photoUrl.isNotEmpty)
                                            ? Image.network(photoUrl, fit: BoxFit.cover)
                                            : Image.asset("assets/images/default.jpg", fit: BoxFit.cover);
                          //final title = type == "brand" ? data.name : data.name;

                          return GestureDetector(
                            onTap: () => Navigator.pushNamed(context, AppRoute.categories, arguments: { "id": data.id}),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  width: 70,
                                  height: 70,
                                // padding: const EdgeInsets.all(2), // space for border
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border:Border.all(color: config.textSecondary, width: 0.5),
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadiusGeometry.circular(100),
                                    child: image,
                                  )
                                ),
                                const SizedBox(height: 4),
                                SizedBox(
                                  width: 60, // limit width for long brand names
                                  child: Text(
                                    data.title,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(fontSize: 12),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    );
  
                }, 
                error: (error, _) => Center(child: Text("Error: $error")),
                loading: () => Center(child: CircularProgressIndicator(),)
              ),

              const SizedBox(height: 25),
              DoubleLineTriangleDivider(color: config.lineColor),
      
              TitleWidget(
                      "Trending Items",
                      onTap: () => Navigator.pushNamed(context, AppRoute.trendingItems),
              ),
              trendingProductAsync.when(
                error: (error, _) => Center(child: Text("Error: $error")),
                loading: () => Center(child: CircularProgressIndicator(),),
                data: (data){
                  return SizedBox(
                    height: 320,
                    child: HorizontalScrollableList(
                      items: data,
                      itemBuilder: (context, product, index) {
                        return ProductCard(
                          id: product.id,
                          config: config,
                          title: product.name,
                          imageUrl: product.mainImage,
                          description: product.description,
                          price: product.mainPrice,
                          currency: "MMK",
                        );
                      },
                    )
                  );
                    },
                  ),
              
              Padding(
                padding: const EdgeInsets.all(20),
                child: Container(width: double.infinity, height: 1, color: config.lineColor),
              ),
               TitleWidget(
                      "New Arrivals",
                      onTap: () => Navigator.pushNamed(context, AppRoute.newArrivals),
                    ),
              SizedBox(
                height: 320,
                child: HorizontalScrollableList<Map<String, dynamic>>(
                  items: products,
                  itemBuilder: (context, product, index) {
                    return ProductCard(
                      id: "2",
                      config: config,
                      title: product["title"],
                      imageAsset: product["imageUrl"],
                      description: product["description"],
                      price: product["price"],
                      currency: product["currency"],
                    );
                  },
                )
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Container(width: double.infinity, height: 1, color: config.lineColor),
              ),
              SizedBox(height: 40)
      
            ],
          );} ,
          itemCount: 1,
        ),
        bottomNavigationBar: CustomerBottomNavigationBar(
          config: config,
          currentIndex: _selectedIndex,
          activeColor: config.primary,
          inactiveColor: config.textSecondary,
        ),
      ),
    );
  }
}
