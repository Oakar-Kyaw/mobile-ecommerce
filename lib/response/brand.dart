class Brand {
  final int id;
  final String name;
  final String code;
  final String? phone;
  final String? email;
  final String? address;
  final String? description;
  final String? feedback;
  final String? info;
  final String? photoUrl;

  Brand({
    required this.id,
    required this.name,
    required this.code,
    this.phone,
    this.email,
    this.address,
    this.description,
    this.feedback,
    this.info,
    this.photoUrl,
  });

  factory Brand.fromJson(Map<String, dynamic> json) {
    return Brand(
      id: json['id'],
      name: json['name'],
      code: json['code'],
      phone: json['phone'],
      email: json['email'],
      address: json['address'],
      description: json['description'],
      feedback: json['feedback'],
      info: json['info'],
      photoUrl: json['photoUrl'],
    );
  }
}
