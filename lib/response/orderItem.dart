class OrderItem {
  final int productId;
  final int quantity;
  final double price;
  final int brandId;
  final String size;
  final String color;

  OrderItem({
    required this.productId,
    required this.quantity,
    required this.price,
    required this.brandId,
    required this.size,
    required this.color
  });

  factory OrderItem.fromJson(Map<String, dynamic> json) {
    return OrderItem(
      productId: json['productId'],
      quantity: json['quantity'],
      price: (json['price'] as num).toDouble(),
      brandId: json['brandId'],
      size: json["size"],
      color: json["color"]
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'productId': productId.toString(),
      'quantity': quantity,
      'price': price,
      "brandId": brandId,
      "size": size,
      "color": color
    };
  }
}
