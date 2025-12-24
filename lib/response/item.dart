class Item {
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

  Item({
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

  factory Item.fromJson(Map<String, dynamic> json){
    return Item(
      id: json["id"], 
      name: json[ "name"], 
      size: json["size"], 
      color: json["color"], 
      currency: json["currency"], 
      brand: json["brand"], 
      price: json["price"], 
      imageUrl: json["imageUrl"], 
      quantity: json["quantity"], 
      isChecked: json["isChecked"]
    );
  }

  Map<String, dynamic> toJson(){
      return {
        "name": name, 
        "size": size, 
        "color": color, 
        "currency": currency, 
        "brand": brand, 
        "price": price, 
        "imageUrl": imageUrl, 
        "quantity": quantity, 
        "isChecked": isChecked
      };
  }
}
