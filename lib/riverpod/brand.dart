
import 'package:ecommerce_mobile/api/brand-api.service.dart';
import 'package:ecommerce_mobile/response/brand.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final brandDetailProvider = FutureProvider.family<Brand?, int> ((ref, param) async{
    Map<String, dynamic>? response = await getBrandByIdApiData(param);

    if (response != null && response["success"] == true) {
      Map<String, dynamic> data = response["data"];
      print("response data: ${data}");
      return Brand.fromJson(data);
    }

    return null;
});