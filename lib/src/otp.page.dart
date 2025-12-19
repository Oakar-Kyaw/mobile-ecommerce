import 'package:dio/dio.dart';
import 'package:ecommerce_mobile/api/email-api.service.dart';
import 'package:ecommerce_mobile/api/user-api.service.dart';
import 'package:ecommerce_mobile/components/app-bar.dart';
import 'package:ecommerce_mobile/riverpod/sign-up.dart';
import 'package:ecommerce_mobile/riverpod/system-configuration.dart';
import 'package:ecommerce_mobile/src/app-route.dart';
import 'package:ecommerce_mobile/utils/constant.dart';
import 'package:ecommerce_mobile/utils/secure-storage.dart';
import 'package:ecommerce_mobile/utils/top-toast.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:otp_input/otp_input.dart';

class OTPPage extends ConsumerStatefulWidget {
  final String title;
  const OTPPage({super.key, this.title = "Change Password"});

  @override
  ConsumerState<OTPPage> createState() => _OTPPageState();
}

class _OTPPageState extends ConsumerState<OTPPage> {
  String email = "";
  String inputOpt = "";
  bool hasError = false;
  bool isSending = false;
  Map<String,String>? signUpData ={} ;

  @override
  void initState() {
    super.initState();
    _init(); // 👈 CALL ONCE
    signUpData = ref.read(signUpDataProvider.notifier).get();
  }

  Future<void> _init() async {
    final user = await readUserFullData(); // existing user data
    final signUpData = ref.read(signUpDataProvider); // read sign-up draft

    // Use email from sign-up or existing user
    email = (widget.title == "Sign Up" && signUpData != null)
        ? signUpData["email"]
        : user?["email"] ?? "";
    
    print("signUpData $signUpData, sign up email ${email} ${widget.title} ${widget.title == "Sign Up"}");
    if (email.isNotEmpty) {
      await _sendEmail();
    }

    setState(() {});
  }


  Future<void> _sendEmail() async {
    print("Eamil is : $email");
    if (email.isEmpty) return;
    setState(() => isSending = true);
    await sendOtp(email, widget.title == "Sign Up" ? "signup" : widget.title);
    setState(() => isSending = false);
  }

  void _validateOtp() {
    setState(() => hasError = inputOpt.length != 6);
  }

  Future<void> _register() async {
    if(signUpData!.isEmpty) return ;

    final data = {
      ...?signUpData,
      "otp": inputOpt
    };
    print("data: $data");
    FormData formData = FormData.fromMap({
      ...data,
     });

    register(formData).then((result) {
      final success = result['success'] as bool;
     // final message = result['message'] as String;
      if (success) {
        TopToast.show(
          context: context,
          title: "Sign Up Successful",
          description: "Welcome to Our Platform!",
        );
        Future.delayed(const Duration(seconds: 2), () {
          Navigator.pushNamedAndRemoveUntil(
            context,
            AppRoute.login,
            (route) => false, 
          );
        });
      }
    });
  }

  Future<void> _verifyOtp() async {
    print("otp $inputOpt");
    _validateOtp();
    if (hasError) return;

    final res = await verifyOtp(email, widget.title == "Sign Up" ? "signup": widget.title, inputOpt);
    print("res is in otp $res");
    if (res == null || res["success"] != true) {
      setState(() => hasError = true);
    }else if(res["success"] = true && widget.title == "Sign Up"){
      print("calling to sign up api");
      _register();
    }else {
      Navigator.pushNamed(context, AppRoute.changePassword);
    }
  }


  @override
  Widget build(BuildContext context) {
    final config = ref.watch(appColorProvider);

    return Scaffold(
      appBar: CustomAppBar(
        config: config,
        leading: const BackButton(),
        title: widget.title,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            const SizedBox(height: 150),
            const Text(
              "OTP Verification",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                style: TextStyle(color: config.textPrimary),
                children: [
                  const TextSpan(text: "Enter the code sent to "),
                  TextSpan(
                    text: email,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),

            OtpInputField(
              otpInputFieldCount: 6,
              onOtpEntered: (otp) {
                print('Entered OTP: $otp');
                setState(() {
                  inputOpt = otp;
                });
              },
              fieldStyle: OtpFieldStyle.box,
              orientation: OtpFieldOrientation.horizontal,
              enabledBorderColor: hasError ? config.error : config.greyColor,
              focusedBorderColor: config.lineColor,
              obscureText: false,
              autoFocus: true,
              keyboardType: TextInputType.number,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
             // textStyle: context.theme.textTheme.labelLarge,
            ),

            const SizedBox(height: 30),
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                style: TextStyle(color: config.textPrimary),
                children: [
                  const TextSpan(text: "I didn't receive any code. "),
                  TextSpan(
                    onEnter: (event) => sendOtp(email, "change-password"),
                    text: "RESEND",
                    style: const TextStyle(fontWeight: FontWeight.bold),
                    recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          // Your click action
                          sendOtp(email, "change-password");
                        },
                    ),
                ],
              ),
            ),
            
            ],
        ),
      ),

      /// VERIFY BUTTON
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: ShadButton(
            onPressed: () =>  _verifyOtp(),
            width: double.infinity,
            backgroundColor: config.clickColor,
            decoration: ShadDecoration(
              border: ShadBorder.all(radius: BorderRadius.circular(20)),
            ),
            child: const Text(
              "Verify",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }
}
