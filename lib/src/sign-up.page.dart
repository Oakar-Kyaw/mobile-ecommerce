import 'dart:async';
import 'package:ecommerce_mobile/api/user-api.service.dart';
import 'package:ecommerce_mobile/riverpod/system-configuration.dart';
import 'package:ecommerce_mobile/src/app-route.dart';
import 'package:ecommerce_mobile/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class SignUpPage extends ConsumerStatefulWidget {
  const SignUpPage({super.key});

  @override
  ConsumerState<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends ConsumerState<SignUpPage> {
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

  Future<void> _register(IAppColorAbstract config) async {
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
    register(body).then((result) {
      final success = result['success'] as bool;
      final message = result['message'] as String;
      final snackBar = SnackBar(
        content: Text(message),
        backgroundColor: success ? config.success : config.error,
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      if (success) {
        Navigator.pushReplacementNamed(context, AppRoute.login);
      }
    });
  }

Future _registerWithGoogle(BuildContext context, IAppColorAbstract config) async {
       userRegisterWithGoogleApi().then((result) {
        final success = result['success'] as bool;
        final message = result['message'] as String;
        final snackBar = SnackBar(
          content: Text(message),
          backgroundColor: success ? config.success : config.error,
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        if (success) {
          Navigator.pushReplacementNamed(context, AppRoute.login);
        }
      });
  }

  @override
  Widget build(BuildContext context) {
    final IAppColorAbstract config = ref.watch(appColorProvider);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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
                            fontSize: 16,
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
                    backgroundColor: config.primary,
                    decoration: ShadDecoration(
                      border: ShadBorder(radius: BorderRadius.circular(30.0)),
                    ),
                    padding: const EdgeInsets.all(10),
                    width: double.infinity,
                    height: 40,
                    child: Text("Create account"),
                    onPressed: () => _register(config),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(child: Divider(thickness: 1)),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text("Or", style: TextStyle(color: config.textSecondary)),
                      ),
                      Expanded(child: Divider(thickness: 1)),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () => _registerWithGoogle(context, config),
                        child: _buildSocialButton('assets/images/google.png', config),
                      ),
                      const SizedBox(width: 25),
                      _buildSocialButton('assets/images/facebook.png', config),
                      const SizedBox(width: 25),
                      _buildSocialButton('assets/images/apple.png', config),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Already have an account? ", style: TextStyle(fontWeight: FontWeight.w600),),
                       GestureDetector(
                          onTap: () => Navigator.pushNamed(context, AppRoute.login),
                          child: Stack(
                            children: [
                              Text(
                                "Sign In",
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Positioned(
                                bottom: 1, // move the underline lower
                                left: 0,
                                right: 0,
                                child: Container(
                                  height: 2, // thickness of underline
                                  color: config.textSecondary,
                                ),
                              ),
                            ]
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

  Widget _buildSocialButton(String asset, IAppColorAbstract config) {
    return Container(
      width: 60,
      height: 60,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(100)),
        border: Border.all(color: config.background),
      ),
      child: Image.asset(asset, fit: BoxFit.contain),
    );
  }
}
