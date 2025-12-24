class ShippingAddressInfo {
  final String? id;
  final String name;
  final String country;
  final String city;
  final String phone;
  final String email;
  final String address;
  bool markDefault;
  final String? address2;
  final String? addressTitle;
  final String? latitude;
  final String? longitude;
  final String? ward;
  ShippingAddressInfo({
    this.id,
    required this.name,
    required this.country,
    required this.city,
    required this.phone,
    required this.email,
    required this.address,
    required this.markDefault,
    this.address2,
    this.latitude,
    this.longitude,
    this.addressTitle,
    this.ward
  });

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "country": country,
      "city": city,
      "phone": phone,
      "email": email,
      "address": address,
      "markDefault": markDefault,
      "addressTitle": addressTitle ?? "",
      "address2": address2 ?? "",
      "latitude": latitude ?? "",
      "longitude": longitude ?? "",
      "ward": ward ?? ""
    };
  }

  ShippingAddressInfo copyWith({
    String? id,
    bool? markDefault,
    String? name,
    String? email,
    String? address,
    String? phone,
    String? addressTitle,
    String? address2,
    String? latitude,
    String? longitude,
    String? country,
    String? city,
    String? ward
  }) {
    return ShippingAddressInfo(
      id: id ?? this.id,
      markDefault: markDefault ?? false,
      name: name ?? this.name,
      email: email ?? this.email,
      address: address ?? this.address,
      phone: phone ?? this.phone,
      addressTitle: addressTitle ?? this.addressTitle,
      address2: address2 ?? this.address2,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      country: country ?? this.country,
      city: city ?? this.city,
      ward: ward ?? this.ward
    );
  }
  factory ShippingAddressInfo.fromJson(Map<String, dynamic> json) {
    return ShippingAddressInfo(
      id: json["_id"]?.toString(),
      name: json["name"] ?? "",
      country: json["country"] ?? "",
      city: json["city"] ?? "",
      phone: json["phone"] ?? "",
      email: json["email"] ?? "",
      address: json["address"] ?? "",
      markDefault: json["markDefault"] ?? false,
      addressTitle: json["addressTitle"],
      address2: json["address2"],
      latitude: json["latitude"]?.toString(),
      longitude: json["longitude"]?.toString(),
      ward: json["ward"],
    );
  }

}