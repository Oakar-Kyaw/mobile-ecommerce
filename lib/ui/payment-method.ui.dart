import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:file_picker/file_picker.dart';
import 'package:ecommerce_mobile/utils/constant.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class PaymentMethod {
  final String key;
  final String title;
  final List<String>? numbers; // For KPay/WavePay
  final String description;
  File? image;

  PaymentMethod({
    required this.key,
    required this.title,
    this.numbers,
    required this.description,
    this.image,
  });
}

class PaymentMethodWidget extends ConsumerStatefulWidget {
  final IAppColorAbstract config;
  final String selectedMethod;

  const PaymentMethodWidget({
    super.key,
    required this.config,
    required this.selectedMethod,
  });

  @override
  ConsumerState<PaymentMethodWidget> createState() =>
      _PaymentMethodWidgetState();
}

class _PaymentMethodWidgetState extends ConsumerState<PaymentMethodWidget> {
  late String selectedMethod;

  final kpay = PaymentMethod(
    key: "kpay",
    title: "KPay",
    numbers: ["0932214234324", "0932214234325"],
    description: "Please upload your KPay screenshot",
  );

  final wavepay = PaymentMethod(
    key: "wavepay",
    title: "Wave Money",
    numbers: ["09771234567"],
    description: "Please upload your WavePay screenshot",
  );

  final cod = PaymentMethod(
    key: "cod",
    title: "Cash on Delivery",
    description: "Fast and secure mobile payment",
  );

  @override
  void initState() {
    super.initState();
    selectedMethod = widget.selectedMethod;
  }

  Widget _paymentTile({
    String? imageUrl,
    String? visaCardImageUrl,
    String? masterCardImageUrl,
    String? jcbCardImageUrl,
    IconData? frontIcon,
    required String value,
    required String title,
    required String subtitle,
    required IconData icon,
  }) {
    return Row(
      children: [
        Radio<String>(
          value: value,
          groupValue: selectedMethod,
          onChanged: (val) {
            if (val != null) {
              setState(() {
                selectedMethod = val;
              });
            }
          },
          activeColor: widget.config.clickColor,
        ),
        if (frontIcon != null)
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
                color: widget.config.greyColor,
                borderRadius: BorderRadius.circular(5)),
            child: Icon(frontIcon),
          ),
        if (imageUrl != null)
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                image: DecorationImage(
                    image: AssetImage(imageUrl), fit: BoxFit.cover)),
          ),
        if (imageUrl != null || frontIcon != null) const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title,
                  style: const TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 5),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (visaCardImageUrl != null)
                    Container(
                      width: 20,
                      height: 20,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage(visaCardImageUrl),
                              fit: BoxFit.cover)),
                    ),
                  const SizedBox(width: 5),
                  if (masterCardImageUrl != null)
                    Container(
                      margin: const EdgeInsets.only(top: 2),
                      width: 20,
                      height: 20,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage(masterCardImageUrl),
                              fit: BoxFit.cover)),
                    ),
                  const SizedBox(width: 5),
                  if (jcbCardImageUrl != null)
                    Container(
                      margin: const EdgeInsets.only(top: 3),
                      width: 13,
                      height: 13,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage(jcbCardImageUrl),
                              fit: BoxFit.cover)),
                    ),
                ],
              ),
            ],
          ),
        ),
        const Icon(Icons.arrow_right),
      ],
    );
  }

  void _handleBottomModalSheet(BuildContext context, PaymentMethod method) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, modalSetState) {
            if (method.key == "card") {
              return _card(context);
            } else {
              return _paymentMethodBottomSheet(method, modalSetState);
            }
          },
        );
      },
    );
  }

  Widget _card(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.only(
          left: 20,
          right: 20,
          top: 20,
          bottom: MediaQuery.of(context).viewInsets.bottom + 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Add a new card",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const Icon(LucideIcons.x, size: 30),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Icon(LucideIcons.shieldCheck,
                  color: widget.config.success, size: 10),
              const SizedBox(width: 3),
              Text("Your data is secure and encrypted",
                  style: TextStyle(fontSize: 10, color: widget.config.success))
            ],
          ),
          const SizedBox(height: 20),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 30, width: 30, child: Image.asset("assets/images/visa.png")),
              SizedBox(height: 30, width: 30, child: Image.asset("assets/images/mastercard.png")),
              Container(
                margin: const EdgeInsets.only(top: 2),
                decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/images/jcb.png"), fit: BoxFit.cover),
                ),
                height: 20,
                width: 20,
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            children: const [
              ShadCheckbox(value: true),
              SizedBox(width: 10),
              Text("Remember this card")
            ],
          ),
          const SizedBox(height: 20),
          Container(
            decoration: BoxDecoration(
              color: const Color.fromRGBO(246, 252, 250, 1),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Secure checkout",
                  style: TextStyle(
                      color: widget.config.success,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(LucideIcons.shieldCheck,
                        color: widget.config.success, size: 16),
                    const SizedBox(width: 5),
                    Expanded(
                        child: Text(
                            "Your financial and personal information is SSL-encrypted",
                            overflow: TextOverflow.clip,
                            style: TextStyle(color: widget.config.success)))
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(LucideIcons.lock,
                        color: widget.config.success, size: 16),
                    const SizedBox(width: 5),
                    Expanded(
                        child: Text(
                            "Every payment is processed securely and protected by PCI DSS standards",
                            overflow: TextOverflow.clip,
                            style: TextStyle(color: widget.config.success)))
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(LucideIcons.creditCard,
                        color: widget.config.success, size: 16),
                    const SizedBox(width: 5),
                    Expanded(
                        child: Text(
                            "We will not disclose or sell your personal information",
                            overflow: TextOverflow.clip,
                            style: TextStyle(color: widget.config.success)))
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _paymentMethodBottomSheet(
      PaymentMethod method, void Function(void Function()) modalSetState) {
    return SingleChildScrollView(
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Text(method.title,
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            const SizedBox(height: 20),

            if (method.numbers != null)
              ...method.numbers!.map((number) => Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: RichText(
                      text: TextSpan(
                        style: TextStyle(color: widget.config.textPrimary),
                        children: [
                          TextSpan(text: "${method.title} Number: "),
                          TextSpan(
                              text: number,
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                  )),

            const SizedBox(height: 20),
            Text(method.description,
                style: const TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),

            if (method.image != null)
              SizedBox(
                width: double.infinity,
                height: 400,
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.file(
                          method.image!,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Positioned(
                      top: 8,
                      right: 8,
                      child: GestureDetector(
                        onTap: () {
                          modalSetState(() {
                            method.image = null;
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.black54,
                            shape: BoxShape.circle,
                          ),
                          padding: const EdgeInsets.all(6),
                          child: const Icon(
                            Icons.close,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            if (method.image != null) const SizedBox(height: 20),

            ShadButton(
              onPressed: () async {
                final result = await FilePicker.platform.pickFiles(
                  type: FileType.image,
                );

                if (result != null && result.files.single.path != null) {
                  modalSetState(() {
                    method.image = File(result.files.single.path!);
                  });
                }
              },
              width: double.infinity,
              backgroundColor: widget.config.clickColor,
              decoration: ShadDecoration(
                border: ShadBorder.all(radius: BorderRadius.circular(20)),
              ),
              child: Text(
                method.image != null ? "Save" : "Upload",
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Payment Method",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          GestureDetector(
            onTap: () =>
                _handleBottomModalSheet(context, PaymentMethod(key: 'card', title: 'Add a new card', numbers: null, description: 'Visa, MasterCard, JCB')),
            child: _paymentTile(
              value: "card",
              title: "Add a new card",
              subtitle: "Visa, MasterCard, JCB",
              frontIcon: LucideIcons.creditCard,
              visaCardImageUrl: "assets/images/visa.png",
              masterCardImageUrl: "assets/images/mastercard.png",
              jcbCardImageUrl: "assets/images/jcb.png",
              icon: Icons.credit_card,
            ),
          ),
          Divider(color: widget.config.lineColor),
          GestureDetector(
            onTap: () => _handleBottomModalSheet(context, kpay),
            child: _paymentTile(
              value: "kpay",
              title: "KBZ Pay",
              imageUrl: "assets/images/kpay.png",
              subtitle: "Pay when you receive your order",
              icon: Icons.money,
            ),
          ),
          Divider(color: widget.config.lineColor),
          GestureDetector(
            onTap: () => _handleBottomModalSheet(context, wavepay),
            child: _paymentTile(
              value: "wavepay",
              title: "Wave Money",
              imageUrl: "assets/images/wavepay.png",
              subtitle: "Visa, MasterCard, JCB",
              icon: Icons.credit_card,
            ),
          ),
          Divider(color: widget.config.lineColor),
          GestureDetector(
            onTap: () => _handleBottomModalSheet(context, cod),
            child: _paymentTile(
              value: "cod",
              title: "Cash on Delivery",
              subtitle: "Fast and secure mobile payment",
              icon: Icons.account_balance_wallet,
            ),
          ),
        ],
      ),
    );
  }
}
