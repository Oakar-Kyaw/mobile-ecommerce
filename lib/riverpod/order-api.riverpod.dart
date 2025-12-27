// import 'package:ecommerce_mobile/api/order.api.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:ecommerce_mobile/api/shipping-address-info.api.dart';

// class OrderNotifier extends AsyncNotifier<Map> {
//   @override
//   Future<List<dynamic>> build() async {
//     return null;
//   }

//   Future<List<dynamic>> _fetchOrderById() async {
//     final response = await getOrderById();
//     if (response["success"]) {
//       return response["data"] as List<dynamic>;
//     }
//     return [];
//   }

//   // Manual refresh method
//   Future<void> refresh() async {
//     state = const AsyncValue.loading();
//     final data = await _fetchOrderById();
//     state = AsyncValue.data(data);
//   }
// }

// // Riverpod provider
// final orderDetailInfoProvider = AsyncNotifierProvider<OrderNotifier, List<dynamic>>(
//   () => OrderNotifier(),
// );
