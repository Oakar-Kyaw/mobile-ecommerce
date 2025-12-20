class CartItem {
  final int id;
  final String name;
  final String brand;
  final String size;
  final String color;
  final String currency;
  final double price;
  final String imageUrl;
  int quantity;
  bool isChecked;

  CartItem({
    required this.id,
    required this.name,
    required this.size,
    required this.color,
    required this.currency,
    required this.brand,
    required this.price,
    required this.imageUrl,
    required this.quantity,
    required this.isChecked,
  });
}
