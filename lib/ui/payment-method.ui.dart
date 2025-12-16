//import 'package:credit_card_form/credit_card_form.dart';
import 'dart:convert';

import 'package:credit_card_flag_detector/credit_card_flag_detector.dart';
import 'package:ecommerce_mobile/ui/bottom-model-component.ui.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce_mobile/utils/constant.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
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
    return Row(
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
            onTap: () {
              _handleBottomModalSheet(context);
            },
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

  _handleBottomModalSheet(BuildContext context){
    final _cardForm = GlobalKey<FormState>();
   // CardDataInputController  _cardController = CardDataInputController();
     showModalBottomSheet(
      context: context, 
      isScrollControlled: true, 
      builder: (BuildContext context){
      return Container(
        height: 650,
        decoration: BoxDecoration(
          color: config.background,
          borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20))
        ),
        child: SingleChildScrollView(
          padding: EdgeInsets.only(
            left: 20,
            right: 20,
            top: 20,
            bottom: MediaQuery.of(context).viewInsets.bottom + 20,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //new card header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("Add a new card", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                  Icon(LucideIcons.x, size: 30,)
                ],
              ),
              SizedBox(height: 20,),
              //security 
              Row(
                children: [
                  Icon(LucideIcons.shieldCheck, color: config.success, size: 10,),
                  SizedBox(width: 3,),
                  Text("Your data is secure and encrypted", style: TextStyle(fontSize: 10,color: config.success),)
                ],
              ),
              SizedBox(height: 20,),
              //card photo
              Row(
                crossAxisAlignment: CrossAxisAlignment.start ,
                children: [
                   SizedBox(
                    height: 30,
                    width: 30,
                    child: Image.asset("assets/images/visa.png")),
                  SizedBox(
                    height: 30,
                    width: 30,
                    child: Image.asset("assets/images/mastercard.png")),
                  Container(
                    margin: EdgeInsets.only(top: 2),
                    decoration: BoxDecoration(
                      image: DecorationImage(image: AssetImage("assets/images/jcb.png"))
                    ),
                    height: 20,
                    width: 20
                  )
                ],
              ),
              SizedBox(height: 20,),
              //card form
              // CreditCardForm(
              //     formKey: _cardForm,
              //     cardNumber: "4055180253703876",
              //     expiryDate: "02/32",
              //     cardHolderName: "Oakar Kyaw",
              //     cvvCode: "329",
              //     onCreditCardModelChange: (CreditCardModel val) => print("valis ${val.cardNumber}"),
              //      // Callback for anytime credit card brand is changed
              //      cardNumberValidator: (val) =>print("check is") ,
              //   ),
              // CreditCardWidget(
              //     cardNumber: "4055180253703876",
              //     expiryDate: "02/32",
              //     cardHolderName: "Oakar Kyaw",
              //     cvvCode: "329",
              //     showBackView: false, //true when you want to show cvv(back) view
              //     onCreditCardWidgetChange: (CreditCardBrand brand) {}, // Callback for anytime credit card brand is changed
              //   ),
              // ShadForm(
              //   key: _cardForm,
              //   child: Column(
              //     children: [
              //       ShadInputFormField(
              //         decoration: ShadDecoration(
              //           secondaryFocusedBorder: ShadBorder.none
              //         ),
              //         placeholder: Text("Card Number"),
              //         onChanged: (value) {
              //             var vl = CreditCardFlagDetector.getCardType(value);
              //             //print(vl.contains(CreditCardFlag.visa.));
              //             print(vl);
              //         },
              //       ),
              //       SizedBox(height: 10,),
              //       ShadInputFormField(
              //         decoration: ShadDecoration(
              //           secondaryFocusedBorder: ShadBorder.none
              //         ),
              //         placeholder: Text("Cardholder Name"),
              //       ),
              //       SizedBox(height: 10,),
              //       Row(
              //         children: [
              //           Expanded(
              //             child: ShadInputFormField(
              //               decoration: ShadDecoration(
              //               secondaryFocusedBorder: ShadBorder.none
              //             ),
              //               placeholder: Text("Expires in MM/YY*"),
              //             ),
              //           ),
              //           SizedBox(width: 10,),
              //         Expanded(
              //         child: ShadInputFormField(
              //           decoration: ShadDecoration(
              //             secondaryFocusedBorder: ShadBorder.none
              //           ),
              //           placeholder: Text("CVV/CSC*"),
              //         ),
              //       ),
              //         ],
              //       )
              //     ],
              //   )
              // ),
              // // CreditCardForm(
              //     //enableScanner: true,
              //     theme: CreditCardLightTheme(
                    
              //     ),
              //     controller: _cardController,
              //     onChanged: (CardData data) {
              //         print(data.cardNumber);
              //         print(data.cardHolderName);
              //         print(data.expiredDate);
              //         print(data.expiredMonth);
              //         print(data.expiredYear);
              //         print(data.cardType);
              //         print(data.cvc);
              //     },
              // ),

              SizedBox(height: 20,),

              Row(
                children: [
                  ShadCheckbox(value: true),
                  SizedBox(width: 10,),
                  Text("Remember this card")
                ],
              ),

              SizedBox(height: 20,),

              Container(
                decoration: BoxDecoration(
                  color: Color.fromRGBO(246, 252, 250, 1),
                ),
                padding:  EdgeInsets.symmetric(horizontal: 15, vertical: 25),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Secure checkout", style: TextStyle(color: config.success, fontSize: 16, fontWeight: FontWeight.bold),),
                    SizedBox(height: 20,),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(LucideIcons.shieldCheck, color: config.success, size: 16,),
                        SizedBox(width: 5,),
                        Expanded(child: Text("Your financial and personal information is SSL-encrypted", overflow: TextOverflow.clip, style: TextStyle(color: config.success),))
                      ],
                    ),
                    SizedBox(height: 20,),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(LucideIcons.lock, color: config.success, size: 16,),
                        SizedBox(width: 5,),
                        Expanded(child: Text("Every payment is processed securely and protected by PCI DSS standards", overflow: TextOverflow.clip, style: TextStyle(color: config.success),))
                      ],
                    ),
                    SizedBox(height: 20,),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(LucideIcons.creditCard, color: config.success, size: 16,),
                        SizedBox(width: 5,),
                        Expanded(child: Text("We will not disclose or sell your personal information", overflow: TextOverflow.clip, style: TextStyle(color: config.success),))
                      ],
                    ),
                  ],
                ),
              )
          ],
          ),
        ),
      );
     });
  }
}
