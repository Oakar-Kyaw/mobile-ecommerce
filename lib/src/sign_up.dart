import 'package:ecommerce_mobile/api/api_service.dart';
import 'package:ecommerce_mobile/src/app_route.dart';
import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_web_auth_2/flutter_web_auth_2.dart';
import 'package:ecommerce_mobile/src/app_route.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<ShadFormState>();
  final firstName = TextEditingController();
  final lastName = TextEditingController();
  final email = TextEditingController();
  final phone = TextEditingController();
  final password = TextEditingController();
  bool obscure = true;
  bool isLoading = false;

  @override
  void dispose() {
    firstName.dispose();
    lastName.dispose();
    email.dispose();
    phone.dispose();
    password.dispose();
    super.dispose();
  }

  bool _isValidEmail(String value) {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value);
  }

  bool _isValidPhone(String value) {
    return RegExp(r'^\+?[\d\s-]{8,15}$').hasMatch(value);
  }

  Future<void> _register() async {
    if (!_formKey.currentState!.saveAndValidate()) {
      return;
    }

    Map<String, dynamic> body = {
      'firstName': firstName.text.trim(),
      'lastName': lastName.text.trim(),
      'email': email.text.trim(),
      'phone': phone.text.trim(),
      'password': password.text.trim(),
      'role': 'CUSTOMER',
    };
    Map<String, dynamic> responseData = await ApiService().post(
      "http://192.168.1.6:5001",
      body,
    );
    debugPrint('response is: ${responseData['data']}');
  }

  //   Future<void> _registerWithGoogle(BuildContext context) async {
  //   //const url = 'https://megabackend.ddns.net/api/v1/users/register/google';
  //   const url = 'http://192.168.1.3:5001/api/v1/users/register/google';
  //   try {
  //     final result = await FlutterWebAuth2.authenticate(
  //       url: url,
  //       callbackUrlScheme: "myapp"
  //     );

  //     if (!context.mounted) return;

  //     print('✅ OAuth result URL: $result');
  //     Navigator.pushNamed(context, AppRoute.register);
  //   } catch (e) {
  //     if (context.mounted) {
  //       ScaffoldMessenger.of(context)
  //           .showSnackBar(SnackBar(content: Text('❌ Google Sign-in failed: $e')));
  //     }
  //   }
  // }

  Future<void> _registerWithGoogle(BuildContext context) async {
    try {
      const url = 'https://megabackend.ddns.net/api/v1/users/register/google';
      // const url = 'http://192.168.1.3:5001/api/v1/users/register/google';
      final result = await FlutterWebAuth2.authenticate(
        url: url,
        callbackUrlScheme: "myapp",
      );

      print('✅ OAuth result URL: $result');

      final uri = Uri.parse(result);
      final success = uri.queryParameters['success'] == 'true';
      final email = uri.queryParameters['email'];
      final token = uri.queryParameters['token'];
      final error = uri.queryParameters['error'];

      if (!context.mounted) return;

      if (success && token != null) {
        // Save token to secure storage
        // await secureStorage.write(key: 'auth_token', value: token);

        // Navigate to home
        Navigator.pushNamedAndRemoveUntil(
          context,
          AppRoute.home,
          (route) => false,
        );

        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Welcome! Logged in as $email')));
      } else {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(error ?? 'Registration failed')));
      }
    } catch (e) {
      print('❌ Authentication cancelled: $e');
    } catch (e) {
      print('❌ Error: $e');
      if (context.mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Authentication failed')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: ShadForm(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Image.asset(
                        'assets/images/logo.png',
                        fit: BoxFit.cover,
                        width: 79,
                        height: 57,
                      ),
                      const SizedBox(width: 12),
                      const Expanded(
                        child: Text(
                          "Create an account!",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: ShadInputFormField(
                          id: 'first_name',
                          controller: firstName,
                          label: const Text('First Name'),
                          placeholder: const Text('First name'),
                          validator: (v) {
                            if (v.length < 2) {
                              return 'Required (min 2 chars)';
                            }
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: ShadInputFormField(
                          id: 'last_name',
                          controller: lastName,
                          label: const Text('Last Name'),
                          placeholder: const Text('Last name'),
                          validator: (v) {
                            if (v.length < 2) {
                              return 'Required (min 2 chars)';
                            }
                            return null;
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: ShadInputFormField(
                          id: 'email',
                          controller: email,
                          label: const Text('Email'),
                          placeholder: const Text('Your email'),
                          keyboardType: TextInputType.emailAddress,
                          validator: (v) {
                            if (v.isEmpty) return 'Email is required';
                            if (!_isValidEmail(v)) {
                              return 'Invalid email';
                            }
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: ShadInputFormField(
                          id: 'phone',
                          controller: phone,
                          label: const Text('Phone'),
                          placeholder: const Text('Your phone'),
                          keyboardType: TextInputType.phone,
                          validator: (v) {
                            if (v.isEmpty) return 'Phone is required';
                            if (!_isValidPhone(v)) {
                              return 'Invalid phone';
                            }
                            return null;
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  ShadInputFormField(
                    id: 'password',
                    controller: password,
                    label: const Text('Password'),
                    placeholder: const Text('Enter your password'),
                    obscureText: obscure,
                    trailing: GestureDetector(
                      onTap: () => setState(() => obscure = !obscure),
                      child: Icon(
                        obscure ? LucideIcons.eyeOff : LucideIcons.eye,
                      ),
                    ),
                    validator: (v) {
                      if (v.length < 6) {
                        return 'Password must be at least 6 characters';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 40),
                  ShadButton(
                    backgroundColor: const Color(0xFF222222),
                    decoration: ShadDecoration(
                      border: ShadBorder(radius: BorderRadius.circular(30.0)),
                    ),
                    padding: const EdgeInsets.all(10),
                    width: double.infinity,
                    height: 40,
                    child: Text("Create account"),
                    onPressed: _register,
                  ),
                  const SizedBox(height: 20),
                  const Row(
                    children: [
                      Expanded(child: Divider(thickness: 1)),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text("Or", style: TextStyle(color: Colors.grey)),
                      ),
                      Expanded(child: Divider(thickness: 1)),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () => _registerWithGoogle(context),
                        child: _buildSocialButton('assets/images/google.png'),
                      ),
                      const SizedBox(width: 10),
                      _buildSocialButton('assets/images/facebook.png'),
                      const SizedBox(width: 10),
                      _buildSocialButton('assets/images/apple.png'),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Already have an account? "),
                      GestureDetector(
                        onTap: () =>
                            Navigator.pushNamed(context, AppRoute.login),
                        child: const Text(
                          "Sign In",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            decoration: TextDecoration.underline,
                            decorationThickness: 2,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSocialButton(String asset) {
    return Container(
      width: 60,
      height: 60,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(100)),
        border: Border.all(color: const Color(0xFFdbd5d7)),
      ),
      child: Image.asset(asset, fit: BoxFit.contain),
    );
  }
}
