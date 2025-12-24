import 'package:ecommerce_mobile/api/user-api.service.dart';
import 'package:ecommerce_mobile/components/app-bar.dart';
import 'package:ecommerce_mobile/riverpod/system-configuration.dart';
import 'package:ecommerce_mobile/src/app-route.dart';
import 'package:ecommerce_mobile/utils/constant.dart';
import 'package:ecommerce_mobile/utils/secure-storage.dart';
import 'package:ecommerce_mobile/utils/top-toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class ChangePasswordPage extends ConsumerStatefulWidget {
  final String title;
  const ChangePasswordPage({
    super.key,
    this.title = "Change Password",
  });

  @override
  ConsumerState<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends ConsumerState<ChangePasswordPage> {
  final _formKey = GlobalKey<ShadFormState>();
  late Future<String> emailFuture;
  String otp = "";
  String id = "";
  String errorPasswordMessage = "";
  String errorConfirmPasswordMessage = "";
  bool isSending = false;
  final password = TextEditingController();
  bool obscure = false;
  final newPassword = TextEditingController();
  bool newObscure = false;
  bool hasError = false;


  @override
  void initState() {
    super.initState();
    _init(); // 👈 CALL ONCE
  }

  Future<void> _init() async {
    final user = await readUserFullData();
    id = user["id"]?.toString() ?? "";
    setState(() {});
  }


  // Send OTP to email
  Future<void> handlePassword() async {
    if (!_formKey.currentState!.saveAndValidate()) return;
     if(!validatePassword(password.text.trim(), newPassword.text.trim())) {
      return;
     }
    final res = await changePassword(id,  newPassword.text.trim());
    if (res == null || res["success"] != true) {
      setState(() => hasError = true);
    }else {
      TopToast.show(context: context, icon: LucideIcons.circleCheckBig, title: "Updated Password Successfully", description: "Your account is ready to go!", action: Icon(LucideIcons.x, fontWeight: FontWeight.bold,));
     
      Future.delayed(const Duration(seconds: 1), () {
        Navigator.pushNamed(context, AppRoute.home);
      });
    }
  }
  
  bool validatePassword(String password, String confirmPassword) {
  // Reset errors first
  setState(() {
    hasError = false;
    errorPasswordMessage = "";
    errorConfirmPasswordMessage = "";
  });

  bool isValid = true;

  if (password.length < 6) {
    isValid = false;
    errorPasswordMessage = "Password must be at least 6 characters";
  }

  if (confirmPassword.length < 6) {
    isValid = false;
    errorConfirmPasswordMessage = "Password must be at least 6 characters";
  }

  if (password.trim() != confirmPassword.trim()) {
    isValid = false;
    errorPasswordMessage = "Passwords do not match";
    errorConfirmPasswordMessage = "Passwords do not match";
  }

  if (!isValid) {
    setState(() {
      hasError = true;
    });
  }

  return isValid;
}

  @override
  Widget build(BuildContext context) {
    final IAppColorAbstract config = ref.watch(appColorProvider);

    return Scaffold(
      appBar: CustomAppBar(
        config: config,
        leading: GestureDetector(
          child: const Icon(Icons.arrow_back),
          onTap: () => Navigator.pop(context),
        ),
        title: widget.title,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ShadForm(
          key: _formKey,
          child: Column(
            children: [
              SizedBox(height: 30,),
              Text("Gotcha!", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),),
              Text("Let create new password for your account"),
              SizedBox(height: 40,),
              ShadInputFormField(
                        id: 'password',
                        controller: password,
                        label: const Text('New Password'),
                        description: hasError ? Text(errorPasswordMessage, style: TextStyle(color: config.error),) : null,
                        decoration: ShadDecoration(
                          secondaryFocusedBorder: ShadBorder.none,
                          border: ShadBorder.all(
                            color: hasError ? config.error : config.lineColor
                          )
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
              const SizedBox(height: 20,),
              ShadInputFormField(
                        id: 'password',
                        controller: newPassword,
                        label: const Text('Confirm your new password'),
                        description: hasError ? Text(errorConfirmPasswordMessage, style: TextStyle(color: config.error),) : null,
                        decoration: ShadDecoration(
                          secondaryFocusedBorder: ShadBorder.none,
                          border: ShadBorder.all(
                            color: hasError ? config.error : config.lineColor
                          )
                        ),
                        placeholder: const Text('Enter your new password'),
                        obscureText: newObscure,
                        trailing: GestureDetector(
                          onTap: () => setState(() => newObscure = !newObscure),
                          child: Icon(
                            newObscure ? LucideIcons.eyeOff : LucideIcons.eye,
                          ),
                        ),
                        validator: (v) {
                          if (v.isEmpty) return 'Password is required';
                          return null;
                        },
              ),
            
            ],
          ),
        ),
      ),
       bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: ShadButton(
            onPressed: handlePassword,
            width: double.infinity,
            backgroundColor: config.clickColor,
            decoration: ShadDecoration(
              border: ShadBorder.all(radius: BorderRadius.circular(20)),
            ),
            child: const Text(
              "Submit",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }
}
