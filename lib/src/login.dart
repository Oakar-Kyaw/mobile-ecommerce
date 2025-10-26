import 'package:ecommerce_mobile/api/api_service.dart';
import 'package:ecommerce_mobile/src/app-route.dart';
import 'package:ecommerce_mobile/utils/check-email-and-phone.dart';
import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
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

  Future<void> _signIn() async {
    Navigator.pushReplacementNamed(context, AppRoute.home);
    // final url = dotenv.env['BACKEND_URL'] ?? "";
    // if (!_formKey.currentState!.saveAndValidate()) return;

    // Map<String, dynamic> body = {'password': password.text.trim()};
    // if (isValidEmail(emailORPhone.text.trim())) {
    //   body['email'] = emailORPhone.text.trim();
    // } else {
    //   body['phone'] = emailORPhone.text.trim();
    // }

    // print('body is : $body');
    // Map<String, dynamic> responseData = await ApiService().post(url, body);
    // debugPrint('response is: ${responseData['data']}');
    // if (responseData['success']) {
    //   Navigator.pushReplacementNamed(context, AppRoute.home);
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false, // prevents keyboard from pushing content
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
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
                    backgroundColor: const Color(0xFF222222),
                    decoration: ShadDecoration(
                      border: ShadBorder(radius: BorderRadius.circular(30.0)),
                    ),
                    padding: const EdgeInsets.all(10),
                    width: double.infinity,
                    height: 40,
                    child: const Text("Sign in"),
                    onPressed: _signIn,
                  ),
                  const SizedBox(height: 24),
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
                      _buildSocialButton('assets/images/google.png'),
                      const SizedBox(width: 10),
                      _buildSocialButton('assets/images/facebook.png'),
                      const SizedBox(width: 10),
                      _buildSocialButton('assets/images/apple.png'),
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
                                color: Colors.black,
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
