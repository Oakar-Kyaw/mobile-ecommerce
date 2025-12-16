import 'package:ecommerce_mobile/riverpod/system-configuration.dart';
import 'package:ecommerce_mobile/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ShippingCard extends ConsumerWidget {
  final String name;
  final String phone;
  final String email;
  final String address;
  const ShippingCard({
    super.key, 
    required this.name,
    required this.phone,
    required this.email,
    required this.address
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final IAppColorAbstract config = ref.watch(appColorProvider);
    return Container(
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: config.greyColor,
        borderRadius: BorderRadius.circular(10)
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(name, style: TextStyle(fontWeight: FontWeight.bold),),
          SizedBox(height: 15,),
          Text(email, style: TextStyle(fontWeight: FontWeight.bold),),
          SizedBox(height: 5,),
          Text(phone, style: TextStyle(fontWeight: FontWeight.bold),),
          SizedBox(height: 15,),
          Text(address, overflow: TextOverflow.clip, style: TextStyle(fontWeight: FontWeight.bold),),
          SizedBox(height: 15,),
        ],
      ),
    );
  }
}