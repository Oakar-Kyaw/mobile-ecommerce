import 'package:ecommerce_mobile/components/app-bar.dart';
import 'package:ecommerce_mobile/riverpod/system-configuration.dart';
import 'package:ecommerce_mobile/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CartPage extends ConsumerWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final IAppColorAbstract config = ref.watch(appColorProvider);


    return Scaffold(
      appBar: CustomAppBar(
        config: config,
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: const Icon(Icons.arrow_back),
        ),
        title: "My Cart",
      ),
      body: Text("hello")
    );
  }
}
