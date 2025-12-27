
class SubCategory {
  final int id;
  final String title;
  final String? description;

  SubCategory({
    required this.id,
    required this.title,
    this.description = "",
  });

  factory SubCategory.fromJson(Map<String, dynamic> json) {
    return SubCategory(
      id: json['id'],
      title: json['title'],
      description: json['description'] ?? ""
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
    };
  }
}


class Category {
  final int id;
  final String title;
  final String? description;
  final List<SubCategory>? subCategory;
  final String? photoUrl;

  Category({
    required this.id,
    required this.title,
    this.description = "",
    this.subCategory,
    this.photoUrl = "",
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'],
      title: json['title'],
      description: json['description'] ?? "" ,
      subCategory:  (json['subCategories'] as List?)
            ?.map((e) => SubCategory.fromJson(e))
            .toList() 
        ?? [],
      photoUrl: json['photoUrl'] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'photoUrl': photoUrl,
    };
  }
}
