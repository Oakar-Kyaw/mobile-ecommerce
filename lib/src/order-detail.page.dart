import 'package:ecommerce_mobile/api/order.api.dart';
import 'package:ecommerce_mobile/response/orderDetail.dart';
import 'package:ecommerce_mobile/riverpod/system-configuration.dart';
import 'package:ecommerce_mobile/ui/order-history-content.ui.dart';
import 'package:ecommerce_mobile/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

final orderDetailProvider = FutureProvider.family.autoDispose<OrderDetail, String>((ref, orderId) async {
  final orderDetail = await getOrderByIdApi(orderId);

  if (orderDetail == null) {
    throw Exception("Order detail not found");
  }

  return orderDetail;
});

class OrderDetailPage extends ConsumerWidget {
  final String? id;

  const OrderDetailPage({
    super.key,
    this.id,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final IAppColorAbstract config = ref.watch(appColorProvider);
    // 🔐 Guard against null id
    if (id == null || id!.isEmpty) {
      return const Scaffold(
        body: Center(child: Text("Invalid order ID")),
      );
    }

    final orderDetailAsync = ref.watch(orderDetailProvider(id!));
    
    return Scaffold(
      body: orderDetailAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => Center(child: Text("Error: $error")),
        data: (orderItem) => OrderContentUI(
          id: orderItem.id,
          email: orderItem.email,
          shippingInfo: orderItem.shippingInfo,
          paymentMethod: orderItem.paymentMethod,
          totalAmount: orderItem.totalAmount.toDouble(),
          subTotal: orderItem.subTotal.toDouble(),
          shippingFee: orderItem.shippingFee.toDouble(),
          tax: orderItem.tax.toDouble(),
          currency: orderItem.currency,
          cartItems: orderItem.cartItems,
          createdAt: DateFormat('dd MMM yyyy').format(orderItem.createdAt!),
          message: Container(
            padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
              color: orderItem.status == "PENDING"
                          ? config.lightBlue
                        : config.lightGreen,
            ),
            child: orderItem.deliveryDate != null ?  
              Row(
                //crossAxisAlignment: CrossAxisAlignment.start,
                children:  [
                  Icon(LucideIcons.truck, fontWeight: FontWeight.bold,),
                  SizedBox(width: 20,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                       RichText(
                        text: TextSpan(
                          children: [
                             TextSpan(text:  "Your order's  ", style: TextStyle(color: config.textPrimary)),
                             TextSpan(text: orderItem.status, style: TextStyle(fontWeight: FontWeight.bold, 
                              color: config.delivered
                                )),
                             ]
                        )
                        ),
                        SizedBox(height: 10,),
                        RichText(
                        text: TextSpan(
                          children: [
                             TextSpan(text:  "Delivered Time:   ", style: TextStyle(color: config.textPrimary)),
                             TextSpan(text: DateFormat('dd MMM yyyy').format(orderItem.deliveryDate!), 
                              style: TextStyle(fontWeight: FontWeight.bold,
                              color: config.delivered
                                )),
                             ]
                        )
                        ),
                      ],
                  )
                ],
              )
            : Row(
                //crossAxisAlignment: CrossAxisAlignment.start,
                children:  [
                  Icon(LucideIcons.truck, fontWeight: FontWeight.bold,),
                  SizedBox(width: 20,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                       RichText(
                        text: TextSpan(
                          children: [
                             TextSpan(text:  "Your order's  ", style: TextStyle(color: config.textPrimary)),
                             TextSpan(text: orderItem.status, style: TextStyle(fontWeight: FontWeight.bold, 
                              color: orderItem.status == "PENDING"
                                ? config.pending
                                : orderItem.status == "PAID"
                                ? config.paid
                                : orderItem.status == "CONFIRMED"
                                ? config.confirmed
                                : orderItem.status == "FAILED"
                                ? config.failed
                                : config.shipped
                                )),
                             ]
                        )
                        ),
                        SizedBox(height: 10,),
                        RichText(
                        text: TextSpan(
                          children: [
                             TextSpan(text:  "Estimated Arrival Time:   ", style: TextStyle(color: config.textPrimary)),
                             TextSpan(text: DateFormat('dd MMM yyyy').format(orderItem.estimatedDeliveryDate!), 
                              style: TextStyle(fontWeight: FontWeight.bold,
                              color: orderItem.status == "PENDING"
                                ? config.pending
                                : orderItem.status == "PAID"
                                ? config.paid
                                : orderItem.status == "CONFIRMED"
                                ? config.confirmed
                                : orderItem.status == "FAILED"
                                ? config.failed
                                : config.shipped
                                )),
                             ]
                        )
                        ),
                      ],
                  )
                ],
              ),
          )
        ),
      ),
    );
  }
}
