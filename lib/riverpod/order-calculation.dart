

import 'package:ecommerce_mobile/response/item.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class OrderCalculation {
  final double totalItem;
  final double subTotal;
  final double shippingFee;
  final double tax;
  final double total;

  OrderCalculation({
    this.totalItem = 0,
    this.subTotal = 0,
    this.shippingFee = 0,
    this.tax = 0,
    this.total = 0,
  });

  OrderCalculation copyWith({
    final double? totalItem,
    final double? subTotal,
    final double? shippingFee,
    final double? tax,
    final double? total,
  }) {
     return OrderCalculation(
         totalItem: totalItem ?? this.totalItem,
         subTotal: subTotal ?? this.subTotal,
         shippingFee: shippingFee ?? this.shippingFee,
         tax: tax ?? this.tax,
         total:  total ?? this.total,
     );
  }
}

class OrderItemType {
   final List<Item> items;
   final OrderCalculation calculation;
   const OrderItemType({
     required this.items,
     required this.calculation
   });

   OrderItemType copyWith({List<Item>? items, OrderCalculation? calculation}){
     return OrderItemType(items: items ?? this.items, calculation: calculation ?? this.calculation);
   }
}

class OrderItems extends Notifier<OrderItemType> {
  @override
  OrderItemType build() {
    return OrderItemType(items: [], calculation: OrderCalculation());
   // return state;
  }

  /// Add checked item only
  void addItem({required List<Item> itemList, double? shippingFee, double? tax}) {
    final newItems = itemList;
    print("new item $newItems");
    state = state.copyWith(items: newItems);
    final shipping = shippingFee ?? 0;
    final taxes = tax ?? 0 ;
    _calculate(shipping, taxes);
  }

  void _calculate(double? shippingFee, double? tax){
   //final totalItems = state.items.length.toDouble();
    final totalItems = state.items.fold<double>(0, (sum, item) => sum + item.quantity > 0 ? 1 : 0 );
    final subTotals = state.items.fold<double>(0, (sum, item) => sum + ( item.price * item.quantity));
    print("calculate $totalItems $subTotals");
    final total = subTotals + shippingFee!.toDouble() + tax!.toDouble();
    state = state.copyWith(
      calculation: state.calculation.copyWith(
        totalItem: totalItems,
        subTotal: subTotals ,
        shippingFee: shippingFee,
        tax: tax ,
        total: total,
      )
    );
  }

  void removeItem({required int productId}) {
    final newItems =
        state.items.where((e) => e.id != productId).toList();
    print(" remove ite s ${newItems.length}");
    state = state.copyWith(items: newItems);
    _calculate(5,5);
  }

  List<Item> getByItem() {
    return state.items;
  }

  OrderCalculation getByCalcuation() {
    return state.calculation;
  }

  void clear() {
    state = OrderItemType(items: [], calculation: OrderCalculation());
  }
}

final orderItemProvider = NotifierProvider<OrderItems, OrderItemType> ((){
   return OrderItems();
});