import 'dart:convert';

import 'package:ecommerce_mobile/api/user-api.service.dart';
import 'package:ecommerce_mobile/response/user.dart';
import 'package:ecommerce_mobile/riverpod/system-configuration.dart';
import 'package:ecommerce_mobile/riverpod/user.dart';
import 'package:ecommerce_mobile/src/app-route.dart';
import 'package:ecommerce_mobile/ui/social-button.ui.dart';
import 'package:ecommerce_mobile/utils/check-email-and-phone.dart';
import 'package:ecommerce_mobile/utils/constant.dart';
import 'package:ecommerce_mobile/utils/secure-storage.dart';
import 'package:ecommerce_mobile/utils/top-toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final _formKey = GlobalKey<ShadFormState>();
  final emailORPhone = TextEditingController();
  final password = TextEditingController();
  bool obscure = false;
  bool isLoading = false;

  @override
  void dispose() {
    emailORPhone.dispose();
    password.dispose();
    super.dispose();
  }

 Future<void> _signIn(IAppColorAbstract config) async {
  final userNotifier = ref.read(userProvider.notifier);
  if (!_formKey.currentState!.saveAndValidate()) return;

  Map<String, dynamic> body = {'password': password.text.trim()};
  if (isValidEmail(emailORPhone.text.trim())) {
    body['email'] = emailORPhone.text.trim();
  } else {
    body['phone'] = emailORPhone.text.trim();
  }

  setState(() => isLoading = true);

  try {
    final loginResponse = await loginUser(body);
    print("Login Response: $loginResponse");

    if (loginResponse["success"]) {
      final token = loginResponse["data"]["token"];
      final userId = loginResponse["data"]["id"];
      print("userId: $userId");
      // Call user API after login
      final userResponse = await getUserData(userId, token: token);

      print("userResponse: $userResponse");
      
      if (userResponse != null && userResponse['success'] == true ) {
        User user = User.fromJson(userResponse["data"]);
        // Save the full user data in secure storage
        await storage.write(
          key: "userFullData",
          value: jsonEncode(userResponse['data']), // <- access with ['data']
        );
        userNotifier.save(user);
        print("User data saved in secure storage, ${userNotifier.get()?.firstName}");
      } else {
        print("Failed to get user data or success is false");
      }

      TopToast.show(
        context: context,
        title: "Login Successful",
        description: "Welcome back!",
      );
      Future.delayed(const Duration(seconds: 2), () {
        Navigator.pushNamedAndRemoveUntil(
          context,
          AppRoute.home,
          (route) => false, // 🔥 removes ALL previous routes
        );
      });
    } else {
      final snackBar = SnackBar(
        content: Text(loginResponse['message']),
        backgroundColor: config.error,
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  } catch (error) {
    print("Error during login: $error");
  } finally {
    setState(() => isLoading = false);
  }
}
 
  @override
  Widget build(BuildContext context) {
    final IAppColorAbstract config = ref.watch(appColorProvider);
    return Scaffold(
      resizeToAvoidBottomInset: false, // prevents keyboard from pushing content
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
                        'assets/images/megasmart.png',
                        fit: BoxFit.cover,
                        width: 79,
                        height: 57,
                      ),
                      const SizedBox(width: 12),
                      const Expanded(
                        child: Text(
                          "Sign into your account!",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  ShadInputFormField(
                    id: 'emailORPhone',
                    controller: emailORPhone,
                    label: const Text('Email or phone'),
                    decoration: ShadDecoration(
                      secondaryFocusedBorder: ShadBorder.none
                    ),
                    placeholder: const Text('Enter your email or phone number'),
                    validator: (v) {
                      if (v.isEmpty) return "Email or Phone is required";
                      if (!isValidEmail(v) && !isValidPhone(v)) {
                        return 'Enter valid email or phone';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  ShadInputFormField(
                    id: 'password',
                    controller: password,
                    label: const Text('Password'),
                    decoration: ShadDecoration(
                      secondaryFocusedBorder: ShadBorder.none
                    ),
                    placeholder: const Text('Enter your password'),
                    obscureText: obscure,
                    trailing: GestureDetector(
                      onTap: () => setState(() => obscure = !obscure),
                      child: Icon(
                        obscure ? LucideIcons.eyeOff : LucideIcons.eye,
                      ),
                    ),
                    validator: (v) {
                      if (v.isEmpty) return 'Password is required';
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ShadCheckboxFormField(
                        id: 'stay_sign_in',
                        initialValue: false,
                        inputLabel: const Text('Stay sign in'),
                        onChanged: (v) {},
                      ),
                      const Text("Forget Password?"),
                    ],
                  ),
                  // const Spacer(),
                  const SizedBox(height: 40),
                  ShadButton(
                    backgroundColor: config.clickColor,
                    decoration: ShadDecoration(
                      border: ShadBorder(radius: BorderRadius.circular(30.0)),
                    ),
                    padding: const EdgeInsets.all(10),
                    width: double.infinity,
                    height: 40,
                    child: const Text("Sign in"),
                    onPressed:() =>  _signIn(config),
                  ),
                  const SizedBox(height: 24),
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
                      SocialButton(asset: 'assets/images/google.png', config: config),
                      const SizedBox(width: 10),
                      SocialButton(asset: 'assets/images/facebook.png', config: config),
                      const SizedBox(width: 10),
                      SocialButton(asset: 'assets/images/apple.png', config: config),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("New to Mega Smart Cart? ", style: TextStyle(fontWeight: FontWeight.w600)),
                      GestureDetector(
                        onTap: () => Navigator.pushNamed(context, AppRoute.register),
                        child: Stack(
                          children: [
                            Text(
                              "Sign Up",
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
                          ],
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
}
