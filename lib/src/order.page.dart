import 'package:ecommerce_mobile/api/order.api.dart';
import 'package:ecommerce_mobile/components/app-bar.dart';
import 'package:ecommerce_mobile/components/fix-content.dart';
import 'package:ecommerce_mobile/components/search-input.dart';
import 'package:ecommerce_mobile/response/orderDetail.dart';
import 'package:ecommerce_mobile/riverpod/system-configuration.dart';
import 'package:ecommerce_mobile/src/app-route.dart';
import 'package:ecommerce_mobile/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:intl/intl.dart';

final allOrderByUserIdProvider = FutureProvider.autoDispose<List<OrderDetail>>((ref) async {
  final orderDetail = await getAllOrderByUserIdApi();
  print("ord detail: $orderDetail");
  return orderDetail;
});

class OrderPage extends ConsumerStatefulWidget {
  const OrderPage({super.key});

  @override
  ConsumerState<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends ConsumerState<OrderPage> {
  DateTime? fromDate;
  DateTime? toDate;

  @override
  Widget build(BuildContext context) {
    final IAppColorAbstract config = ref.watch(appColorProvider);
    final orderDetailAsync = ref.watch(allOrderByUserIdProvider);
    print("date time is : $fromDate $toDate");

    return Scaffold(
      appBar: CustomAppBar(
        config: config,
        leading: GestureDetector(
          child: const Icon(Icons.arrow_back),
          onTap: () => Navigator.pop(context),
        ),
        title: "My Orders",
      ),
      body: orderDetailAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => Center(child: Text("Error: $error")),
        data: (orders) {

          return CustomScrollView(
            slivers: [
              SliverPersistentHeader(
                pinned: true,
                delegate: FixedHeader(
                  height: 190,
                  config: config,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: Text("Orders (${orders.length})"),
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
                                formatDate: (date) =>
                                    DateFormat('yyyy/MM/dd').format(date),
                                placeholder: const Text("From"),
                                onChanged: (date) {
                                  setState(() {
                                    fromDate = date;
                                  });
                                },
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: ShadDatePicker(
                                formatDate: (date) =>
                                    DateFormat('yyyy/MM/dd').format(date),
                                placeholder: const Text("To"),
                                onChanged: (date) {
                                  setState(() {
                                    toDate = date;
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              orders.isEmpty
                  ? SliverFillRemaining(
                      hasScrollBody: false,
                      child: Center(
                        child: Text(
                          "No Order",
                          style: const TextStyle(
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    )
                  : SliverPadding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      sliver: SliverGrid(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 1,
                          crossAxisSpacing: 20,
                          mainAxisSpacing: 20,
                          childAspectRatio: 0.5,
                          mainAxisExtent: 125,
                        ),
                        delegate: SliverChildBuilderDelegate(
                          (context, index) {
                            final order = orders[index];
                            final id = order.id;
                            return GestureDetector(
                              onTap: () => Future.delayed((Duration(milliseconds: 300)) , (){
                                  Navigator.pushNamed(context, AppRoute.orderDetail, arguments: id);
                              }),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Image.network(order.cartItems[0].imageUrl),
                                  const SizedBox(width: 20),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(order.cartItems[0].name),
                                        const SizedBox(height: 10),
                                        Text(order.cartItems[0].brandName),
                                        const SizedBox(height: 10),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "${order.cartItems[0].price} ${order.currency}",
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Text(
                                                "Qty (${order.cartItems[0].quantity})"),
                                          ],
                                        ),
                                        const SizedBox(height: 10),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              order.status,
                                              style: TextStyle(
                                                color: order.status == "PENDING"
                                                    ? config.pending
                                                    : order.status == "PAID"
                                                        ? config.paid
                                                        : order.status ==
                                                                "CONFIRMED"
                                                            ? config.confirmed
                                                            : order.status ==
                                                                    "FAILED"
                                                                ? config.failed
                                                                : order.status ==
                                                                        "SHIPPED"
                                                                    ? config.shipped
                                                                    : order.status ==
                                                                            "DELIVERED"
                                                                        ? config.delivered
                                                                        : config.cancelled,
                                              ),
                                            ),
                                            const SizedBox(width: 10),
                                            Text(DateFormat('dd MMM yyyy')
                                                .format(order.createdAt!)),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                          childCount: orders.length,
                        ),
                      ),
                    ),
              const SliverToBoxAdapter(
                child: SizedBox(height: 50),
              ),
            ],
          );
        },
      ),
    );
  }
}
