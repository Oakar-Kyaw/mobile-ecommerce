import 'package:flutter/material.dart';
import 'package:ecommerce_mobile/utils/constant.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class PaymentMethodWidget extends StatelessWidget {
  final IAppColorAbstract config;
  final String selectedMethod;
  //final ValueChanged<String> onChanged;

  const PaymentMethodWidget({
    super.key,
    required this.config,
    required this.selectedMethod,
    //required this.onChanged,
  });

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
    return GestureDetector(
     // onTap: () => onChanged(value),
      child: Container(
        child: Row(
          children: [
            Radio<String>(
              value: value,
              activeColor: config.clickColor,
            ),
            if(frontIcon != null)
               Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: config.greyColor,
                    borderRadius: BorderRadius.circular(5)),
                  child:  Icon(frontIcon),
                  ),
            if(imageUrl != null) 
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    image: DecorationImage(image: AssetImage(imageUrl),
                    fit: BoxFit.cover))),
            if(imageUrl != null || frontIcon != null)
                SizedBox(width: 10,),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 5,),
                  Row(
                    crossAxisAlignment:  CrossAxisAlignment.start,
                    children: [
                     //visacard image isn't null
                     if(visaCardImageUrl != null)
                      Container(
                         width: 20,
                         height: 20,
                         decoration: BoxDecoration(
                          image: DecorationImage(image: AssetImage(visaCardImageUrl), fit: BoxFit.cover)
                         ),
                      ),

                      SizedBox(width: 5,),
                      //master card image isn't null
                      if(masterCardImageUrl != null)
                       Container(
                        margin: EdgeInsets.only( top: 2),
                         width: 20,
                         height: 20,
                         decoration: BoxDecoration(
                          image: DecorationImage(image: AssetImage(masterCardImageUrl), fit: BoxFit.cover)
                         ),
                      ),

                      SizedBox(width:5),
                      //jcb card image isn't null
                      if(jcbCardImageUrl != null)
                       Container(
                        margin: EdgeInsets.only(top:3),
                         width: 13,
                         height: 13,
                         decoration: BoxDecoration(
                          image: DecorationImage(image: AssetImage(jcbCardImageUrl), fit: BoxFit.cover)
                         ),
                      )
                    ],
                  )
                ],
              ),
            ),
            Align(
              alignment: AlignmentGeometry.topRight,
              child: Icon(Icons.arrow_right),
            )
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

          _paymentTile(
            value: "card",
            title: "Add a new card",
            subtitle: "Visa, MasterCard, JCB",
            frontIcon: LucideIcons.creditCard,
            visaCardImageUrl: "assets/images/visa.png",
            masterCardImageUrl: "assets/images/mastercard.png",
            jcbCardImageUrl: "assets/images/jcb.png",
            icon: Icons.credit_card,
          ),

          Divider(color: config.lineColor),

          _paymentTile(
            value: "card",
            title: "Wave Money",
            imageUrl: "assets/images/wavepay.png",
            subtitle: "Visa, MasterCard, JCB",
            icon: Icons.credit_card,
          ),

          Divider(color: config.lineColor),

          _paymentTile(
            value: "cod",
            title: "KBZ Pay",
            imageUrl: "assets/images/kpay.png",
            subtitle: "Pay when you receive your order",
            icon: Icons.money,
          ),

          Divider(color: config.lineColor),

          _paymentTile(
            value: "kbzpay",
            title: "Cash on Delivery",
            subtitle: "Fast and secure mobile payment",
            icon: Icons.account_balance_wallet,
          ),
        ],
      ),
    );
  }
}
