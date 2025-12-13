import 'package:ecommerce_mobile/api/user-api.service.dart';
import 'package:ecommerce_mobile/riverpod/system-configuration.dart';
import 'package:ecommerce_mobile/src/app-route.dart';
import 'package:ecommerce_mobile/ui/social-button.ui.dart';
import 'package:ecommerce_mobile/utils/check-email-and-phone.dart';
import 'package:ecommerce_mobile/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

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
    final url = dotenv.env['AUTH_URL'] ?? "";
    if (!_formKey.currentState!.saveAndValidate()) return;

    Map<String, dynamic> body = {'password': password.text.trim()};
    if (isValidEmail(emailORPhone.text.trim())) {
      body['email'] = emailORPhone.text.trim();
    } else {
      body['phone'] = emailORPhone.text.trim();
    }

    print('body is : $body');
    loginUser(body).then((result){
      final success = result['success'] as bool;
      final message = result['message'] as String;
      final snackBar = SnackBar(
        content: Text(message),
        backgroundColor: success ? config.success : config.error,
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      if (success) {
        Navigator.pushReplacementNamed(context, AppRoute.home);
      }
    });
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
