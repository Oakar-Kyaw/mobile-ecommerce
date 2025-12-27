

class Images {
  String front;
  String back;
  String sideL;
  String sideR;

  Images({
    this.front = "",
    this.back = "",
    this.sideL = "",
    this.sideR = ""
  });

  factory Images.initial() {
    return Images(
      front: "",
       back: "",
       sideL: "",
       sideR: ""
    );
  }

  factory Images.fromJson(Map<String, dynamic> json){
    return Images(
       front: json['front'] ?? "",
       back: json["back"] ?? "",
       sideL: json["sideL"] ?? "",
       sideR: json["sideR"] ?? ""
    );
  }
}

class CategoryByBrandProduct {
  int id;
  String title;
  String description;
  String photoUrl;

  CategoryByBrandProduct({
    this.id = 0,
    this.title = "",
    this.description = "",
    this.photoUrl = "",
  });

  factory CategoryByBrandProduct.initial() {
    return CategoryByBrandProduct(
      id: 0,
      title: "",
      description: "",
      photoUrl: "",
    );
  }

  factory CategoryByBrandProduct.fromJson(Map<String, dynamic> json) {
    return CategoryByBrandProduct(
      id: json['id'] ?? 0,
      title: json['title'] ?? "",
      description: json['description'] ?? "",
      photoUrl: json['photoUrl'] ?? "",
    );
  }
}

class BrandByProduct {
  int id;
  String name;
  String imageUrl;
  int brandId;
  String email;

  BrandByProduct({
    this.id = 0,
    this.name = "",
    this.imageUrl = "",
    this.brandId = 0,
    this.email = "",
  });

  factory BrandByProduct.initial() {
    return BrandByProduct(
      id: 0,
      name: "",
      imageUrl: "",
      brandId: 0,
      email: "",
    );
  }

  factory BrandByProduct.fromJson(Map<String, dynamic> json) {
    return BrandByProduct(
      id: json['id'] ?? 0,
      name: json['name'] ?? "",
      imageUrl: json['imageUrl'] ?? "",
      brandId: json['brandId'] ?? 0,
      email: json['email'] ?? "",
    );
  }
}


class ProductSize {
   int id;
   String name;
   int price;
   ProductSize(
     {
      required this.id,
      required this.name,
      required this.price
     }
   );

  factory ProductSize.fromJson(Map<String, dynamic> json){
    return ProductSize(
      id: json["id"], 
      name: json["name"], 
      price: json["price"]
    );
  }
}


class ProductVariant {
   int id;
   int quantity;
   ProductSize productSize;

   ProductVariant(
     {
      required this.id,
      required this.quantity,
      required this.productSize
     }
   );

  factory ProductVariant.fromJson(Map<String, dynamic> json){
    
    return ProductVariant(
      id: json["id"], 
      quantity: json["quantity"], 
      productSize: ProductSize.fromJson(json["productSize"]) 
    );
  }
}

class ProductColor {
   String id;
   String name;
   String hex;
   Images images;
   List<ProductVariant> sizes;
   ProductColor(
     {
      required this.id,
      required this.name,
      required this.hex,
      required this.images,
      required this.sizes
     }
   );

  factory ProductColor.fromJson(Map<String, dynamic> json){
    return ProductColor(
      id: json["id"], 
      name: json["name"], 
      hex: json["hex"],
      images: Images.fromJson(json["images"]),
      sizes:  (json["sizes"] as List).map((e)=> ProductVariant.fromJson(e)).toList()
    );
  }
}

class Product {
  String id;
  String name;
  String code;
  String type;
  String weight;
  String mainImage;
  int    mainPrice;
  String description;
  BrandByProduct brand;
  CategoryByBrandProduct category;
  List<ProductColor> colors;

  Product({
    required this.id,
    this.name = "",
    this.code = "",
    this.type = "",
    this.weight = "",
    this.mainImage = "",
    this.description = "",
    this.mainPrice = 0,
    required this.brand,
    required this.category,
    required this.colors
  });

  factory Product.fromJson(Map<String, dynamic> json){
    print("json is ${json["brand"]}");
    return Product(
      id: json["id"],
      name: json["name"],
      code: json["code"],
      type: json["type"],
      weight: json["weight"],
      mainImage: json["mainImage"],
      description: json["description"],
      mainPrice: json["mainPrice"] ?? 0,
      colors: (json["colors"] as List? ?? []).map((e)=> ProductColor.fromJson(e)).toList(),
      brand: BrandByProduct.fromJson(json["brand"]),
      category: CategoryByBrandProduct.fromJson(json["category"])
    );
  }
}
