import 'package:ecommerce_mobile/components/app-bar.dart';
import 'package:ecommerce_mobile/components/fix-content.dart';
import 'package:ecommerce_mobile/components/search-input.dart';
import 'package:ecommerce_mobile/riverpod/system-configuration.dart';
import 'package:ecommerce_mobile/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class OrderPage extends ConsumerWidget {
  const OrderPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final IAppColorAbstract config = ref.watch(appColorProvider);
    // Example order items
    final orders = [
      {"name": "T-shirt", "brandName":"Shein", "price": 25900000, "quantity": 2, "status":"Processing", "imageUrl": "assets/images/shirtimagebg.jpg", "date":"2024-04-20"},
      {"name": "Big Shirt", "brandName":"Shein", "price": 25.0, "quantity": 2, "status":"Delivered", "imageUrl": "assets/images/shirtimagebg.jpg", "date":"2024-04-20"},
    ];

    return Scaffold(
      appBar: CustomAppBar(
        config: config,
        leading: GestureDetector(
          child: const Icon(Icons.arrow_back),
          onTap: () => Navigator.pop(context),
        ),
        title: "My Orders",
      ),
      body: CustomScrollView(
        slivers: [
          SliverPersistentHeader(
            pinned: true,
            delegate: FixedHeader(
            height: 200,
            config: config,
            //height: 40,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Text("Orders (5)"),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: SearchInput(),
                ),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                     Expanded(
                       child: ShadDatePicker(
                          formatDate: (date) => DateFormat('yyyy/MM/dd').format(date),
                          placeholder: Text("From"), 
                        ),
                     ),
                     SizedBox(width: 10),
                     Expanded(
                       child: ShadDatePicker(
                        formatDate: (date) => DateFormat('yyyy/MM/dd').format(date),
                        placeholder: Text("To"),
                       ),
                     ),
                    ],
                  ),
                )
              ],
            ),
          ),
          ),
         SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            sliver: SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20,
                childAspectRatio: 0.5,
                mainAxisExtent: 125
              ),
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final order = orders[index];
                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset("${order["imageUrl"]}"),
                      const SizedBox(width: 20,),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("${order["name"]}"),
                            const SizedBox(height: 10),
                            Text("${order["brandName"]}"),
                            const SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("${order["price"]} MMK", style: TextStyle(fontWeight: FontWeight.bold),),
                                
                                Text("Qty (${order["quantity"]})"),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("${order["status"]}", style: TextStyle(color: order['status'] == "processing" ? config.secondary : config.success ),),
                                const SizedBox(width: 20),
                                Text("${order["date"]}"),
                              ],
                            ),
                          ],
                        ),
                      ),

                  ],
                );
                },
                childCount: orders.length,
              ),
            ),
            )
      ],
      )
    );
  }
}
