/// Utility functions to check email and phone validin
bool isValidEmail(String email) {
  final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
  return emailRegex.hasMatch(email);
}

bool isValidPhone(String phone) {
  // Accepts numbers with optional +, spaces, dashes, and parentheses
  final phoneRegex = RegExp(r'^(\+)?\d{7,15}$');
  return phoneRegex.hasMatch(phone);
}
