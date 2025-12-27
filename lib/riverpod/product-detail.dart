import 'package:ecommerce_mobile/api/product.api.dart';
import 'package:ecommerce_mobile/response/product.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProductDetailState {
  final String mainImage;
  final List<String> images;
  final String colorName;
  final int price;
  final int quantity;
  final List<ProductVariant> sizes;

  ProductDetailState({
    required this.mainImage,
    required this.images,
    required this.price,
    this.colorName = "",
    this.quantity = 0,
    required this.sizes
  });

  factory ProductDetailState.initial() {
    return ProductDetailState(
      mainImage: '',
      images: [],
      colorName: "",
      price: 0,
      quantity: 0,
      sizes: []
    );
  }

  ProductDetailState copyWith({
    String? mainImage,
    List<String>? images,
    int? quantity,
    int? price,
    String? colorName,
    List<ProductVariant>? sizes
  }) {
    return ProductDetailState(
      mainImage: mainImage ?? this.mainImage,
      images: images ?? this.images,
      price: price ?? this.price,
      sizes: sizes ?? this.sizes,
      colorName: colorName ?? this.colorName,
      quantity: quantity ?? this.quantity
    );
  }
}

class ProductDetailRiverpod extends Notifier<ProductDetailState> {

  @override
  ProductDetailState build() {
    return ProductDetailState.initial();
  }

  
  void saveData(String mainImage, Images images, int price, List<ProductVariant> sizes, int? quantity, String? colorName) {
     final List<String> formatImages = [
      images.front,
      images.back,
      images.sideL,
      images.sideR,
    ].where((e) => e.isNotEmpty).toList();

    state = state.copyWith(
      mainImage: mainImage,
      images: formatImages,
      price: price,
      sizes: sizes,
      quantity: quantity ?? 0,
      colorName: colorName ?? ""
    );
  }

  void savePrice(int price){
    state = state.copyWith(
      price: price
    );
  }

  void changeMainImage(String mainImage){
    state = state.copyWith(
      mainImage: mainImage
    );
  }
}



final productDetailStateProvider =
    NotifierProvider<ProductDetailRiverpod, ProductDetailState>(
  () => ProductDetailRiverpod(),
);

final productByIdProvider = FutureProvider.family.autoDispose<Product, String>((ref, id) async{
  final productApi = ProductApi();
  final apiResponse = await productApi.getProductByIdApiData(id);
  ref.read(productDetailStateProvider.notifier).saveData(apiResponse.mainImage, apiResponse.colors[0].images, apiResponse.colors[0].sizes[0].productSize.price, apiResponse.colors[0].sizes, apiResponse.colors[0].sizes[0].quantity, apiResponse.colors[0].name);

  return apiResponse;
});