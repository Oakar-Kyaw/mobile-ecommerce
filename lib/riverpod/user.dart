import 'package:ecommerce_mobile/response/user.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserNotifier extends Notifier<User?> {
  @override
  User? build() {
    // Initial state is null (no user logged in)
    return null;
  }

  // Save or update user
  void save(User user) {
    state = user;
  }

  // Clear user (optional)
  void clear() {
    state = null;
  }

  // Get current user
  User? get() {
    return state;
  }
}

// Provider
final userProvider = NotifierProvider<UserNotifier, User?>(
  () => UserNotifier(),
);
