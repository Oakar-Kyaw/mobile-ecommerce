import 'package:ecommerce_mobile/response/shipping-data.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ecommerce_mobile/api/shipping-address-info.api.dart';

class ShippingInfoNotifier extends AsyncNotifier<List<dynamic>> {
  @override
  Future<List<dynamic>> build() async {
    return await _fetchShipping();
  }

  Future<List<dynamic>> _fetchShipping() async {
    final response = await getShippingAddressInfoApi();
    if (response["success"]) {
      return response["data"] as List<dynamic>;
    }
    return [];
  }

  // Manual refresh method
  Future<void> refresh() async {
    state = const AsyncValue.loading();
    final data = await _fetchShipping();
    state = AsyncValue.data(data);
  }
}

// Riverpod provider
final shippingInfoProvider = AsyncNotifierProvider<ShippingInfoNotifier, List<dynamic>>(
  () => ShippingInfoNotifier(),
);

class ActualShippingInfoNotifier extends Notifier<ShippingAddressInfo?> {
  @override
  ShippingAddressInfo? build() {
    // Initial state is null (no user logged in)
    return null;
  }

  // Save or update user
  void save(ShippingAddressInfo shippingInfo) {
    state = shippingInfo;
  }

  // Clear user (optional)
  void clear() {
    state = null;
  }

  // Get current user
  ShippingAddressInfo? get() {
    return state;
  }
}

// Provider
final actualShippingAddressInfoProvider = NotifierProvider<ActualShippingInfoNotifier, ShippingAddressInfo?>(
  () => ActualShippingInfoNotifier(),
);

