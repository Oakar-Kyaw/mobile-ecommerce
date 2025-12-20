

import 'package:flutter_riverpod/flutter_riverpod.dart';

class CheckOutOrderNotifier extends Notifier<Map<String, dynamic>> {
  @override
  Map<String, dynamic> build() {
    return {
      "totalItem": 0.0,
      "subTotal": 0.0,
      "shippingFee": 0.0,
      "tax": 0.0,
      "total": 0.0,
    };
  }

  void save(Map<String, dynamic> value){
    state = value ;
  }

  void add(String name, double value) {
    state = {
      ...state,
      name: value,
    };
  }
  
  double getByName(String name) {
    return state[name] ?? 0.0;
  }

  Map<String, dynamic> get() {
    return state;
  }

  void clear() {
    state = {
      "totalItem": 0.0,
      "subTotal": 0.0,
      "shippingFee": 0.0,
      "tax": 0.0,
      "total": 0.0,
    };
  }
}

final checkOutOrderCalculationDataProvider = NotifierProvider<CheckOutOrderNotifier, Map<String,dynamic>> ((){
   return CheckOutOrderNotifier();
});