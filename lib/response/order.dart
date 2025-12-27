
import 'package:ecommerce_mobile/response/orderItem.dart';

class Order {
  final String userId;
  final List<OrderItem>? items;
  final String paymentType;
  final double? totalAmount;
  final double? subTotal;
  final double? shippingFee;
  final double? tax;
  final String? currency;
  final bool? existShippingAddress;
  final String? shippingAddressId;
  final String? paymentStatus;

  Order({
    required this.userId,
    this.items,
    required this.paymentType,
    this.totalAmount,
    this.subTotal,
    this.shippingFee,
    this.tax,
    this.currency,
    this.existShippingAddress,
    this.shippingAddressId,
    this.paymentStatus
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    print("json, $json");
    return Order(
      userId: json['userId'].toString(),
      // items: (json['items'] as List)
      //     .map((e) => OrderItem.fromJson(e))
      //     .toList(),
      totalAmount: (json['totalAmount'] as num?)?.toDouble(),
      subTotal: (json['subTotal'] as num?)?.toDouble(),
      shippingFee: (json['shippingFee'] as num?)?.toDouble(),
      tax: (json['tax'] as num?)?.toDouble(),
      currency: json['currency'],
      existShippingAddress: json['existShippingAddress'],
      paymentType: json['paymentType'],
      paymentStatus: json["paymentStatus"]
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'items': items?.map((e) => e.toJson()).toList(),
      'totalAmount': totalAmount,
      'subTotal': subTotal,
      'shippingFee': shippingFee,
      'tax': tax,
      'currency': currency,
      'existShippingAddress': existShippingAddress,
      'paymentType': paymentType,
      'shippingAddressId': shippingAddressId
    };
  }
}
