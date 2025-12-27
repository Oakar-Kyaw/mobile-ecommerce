class ShippingInfo {
  final String name;
  final String phone;
  final String city;
  final String address;
  final String email;

  ShippingInfo({
    required this.name,
    required this.phone,
    required this.city,
    required this.address,
    required this.email,
  });

  factory ShippingInfo.fromJson(Map<String, dynamic> json) {
    return ShippingInfo(
      name: json["name"] ?? "",
      phone: json["phone"] ?? "",
      city: json["city"] ?? "",
      address: json["address"] ?? "",
      email: json["email"] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "phone": phone,
      "city": city,
      "address": address,
      "email": email,
    };
  }
}

class CartItem {
  final String productId;
  final int brandId;
  final String brandName;
  final String name;
  final String size;
  final String color;
  final double price;
  final String imageUrl;
  int quantity;

  CartItem({
    required this.productId,
    required this.brandId,
    required this.name,
    required this.size,
    required this.color,
    required this.price,
    required this.imageUrl,
    required this.quantity,
    this.brandName = ""
  });

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      productId: json["productId"]?.toString() ?? "",
      brandId: json["brandId"] ?? 0,
      name: json["name"] ?? "",
      size: json["size"] ?? "",
      color: json["color"] ?? "",
      price: (json["price"] as num?)?.toDouble() ?? 0,
      imageUrl: json["image"] ?? "",
      quantity: json["quantity"] ?? 0,
      brandName: json['brandName'] ?? ""
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "productId": productId,
      "brandId": brandId,
      "name": name,
      "size": size,
      "color": color,
      "price": price,
      "image": imageUrl,
      "quantity": quantity,
    };
  }
}

class OrderDetail {
  final String id;
  final String email;
  final ShippingInfo shippingInfo;
  final String status;
  final String currency;
  final int totalAmount;
  final int subTotal;
  final int shippingFee;
  final int tax;
  final String paymentMethod;
  final List<CartItem> cartItems;
  final DateTime? createdAt;
  final DateTime? estimatedDeliveryDate;
  final DateTime? deliveryDate;

  OrderDetail({
    required this.id,
    required this.email,
    required this.shippingInfo,
    required this.paymentMethod,
    required this.cartItems,
    required this.status,
    this.estimatedDeliveryDate,
    this.deliveryDate,
    this.createdAt,
    this.currency = "MMK",
    this.totalAmount = 0,
    this.subTotal = 0,
    this.shippingFee = 0,
    this.tax = 0,
  });

  factory OrderDetail.fromJson(Map<String, dynamic> json) {
    final shippingJson = json["shippingLocationId"] ?? {};
   // print("orderDetail Date: ${json["estimatedDeliveryDate"]}");
    return OrderDetail(
      id: json["_id"]?.toString() ?? "",
      email: shippingJson["email"] ?? "",
      shippingInfo: ShippingInfo.fromJson(shippingJson),
      createdAt: DateTime.parse(json["createdAt"]).toLocal(),
      status: json["status"],
      paymentMethod: json["paymentType"] ?? "",
      currency: json["currency"] ?? "MMK",
      totalAmount: json["totalAmount"] ?? 0,
      subTotal: json["subTotal"] ?? 0,
      shippingFee: json["shippingFee"] ?? 0,
      tax: json["tax"] ?? 0,
      cartItems: (json["items"] as List? ?? [])
          .map((e) => CartItem.fromJson(e))
          .toList(),
      estimatedDeliveryDate: DateTime.parse(json["estimatedDeliveryDate"]).toLocal(),
      // deliveryDate:  json["deliveryDate"] != null
      //     ? DateTime.parse(json["deliveryDate"]).toLocal()
      //     : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "_id": id,
      "email": email,
      "currency": currency,
      "totalAmount": totalAmount,
      "subTotal": subTotal,
      "shippingFee": shippingFee,
      "tax": tax,
      "paymentType": paymentMethod,
      "shippingInfo": shippingInfo.toJson(),
      "items": cartItems.map((e) => e.toJson()).toList(),
    };
  }
}
