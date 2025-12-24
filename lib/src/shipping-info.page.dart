import 'package:country_code_picker/country_code_picker.dart';
import 'package:csc_picker_plus/csc_picker_plus.dart';
import 'package:ecommerce_mobile/api/shipping-address-info.api.dart';
import 'package:ecommerce_mobile/response/shipping-data.dart';
import 'package:ecommerce_mobile/riverpod/system-configuration.dart';
import 'package:ecommerce_mobile/src/app-route.dart';
import 'package:ecommerce_mobile/ui/circle-component.ui.dart';
import 'package:ecommerce_mobile/utils/constant.dart';
import 'package:ecommerce_mobile/utils/country-code.dart';
import 'package:ecommerce_mobile/utils/phone-country-model.dart';
import 'package:ecommerce_mobile/utils/top-toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ecommerce_mobile/components/app-bar.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class ShippingInfoPage extends ConsumerStatefulWidget {
  const ShippingInfoPage({super.key});

  @override
  ConsumerState<ShippingInfoPage> createState() => _ShippingInfoPageState();
}

class _ShippingInfoPageState extends ConsumerState<ShippingInfoPage> {
  final _formKey = GlobalKey<ShadFormState>();
  TextEditingController name = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController addressTitle = TextEditingController();
  TextEditingController adress = TextEditingController();
  TextEditingController address1 = TextEditingController();
  TextEditingController address2 = TextEditingController();

  bool markDefault = false;
  bool existAddress2 = false;
  String _selectedCountry = "";
  String _selectedCity = "";
  CountryCode _selectedCountryCode = CountryCode(dialCode: "+95");
 // String? _selectedPhoneNumber;
  
  void _submit() async {
    if (_formKey.currentState?.validate() ?? false) {
      final shippingData = ShippingAddressInfo(
        name: name.text.trim(), 
        country: _selectedCountry, 
        city: _selectedCity, 
        phone: "$_selectedCountryCode ${phone.text.trim()}", 
        email: email.text.trim(), 
        address: address1.text.trim(),
        address2: address2.text.trim(),
        addressTitle: addressTitle.text.trim(),
        markDefault: markDefault 
        );

      debugPrint("Shipping Info: ${shippingData.toJson()}");
      final shippingAddress = await shippingAddressInfoApi(shippingData);
      if(shippingAddress["success"]){
         TopToast.show(context: context, title: "Shipping Info is created successfully");
         Future.delayed(const Duration(milliseconds: 300),() =>Navigator.pop(context, true));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final config = ref.watch(appColorProvider);

    return Scaffold(
      appBar: CustomAppBar(
        config: config,
        title: "Shipping Info",
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: const Icon(Icons.arrow_back),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: ShadForm(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildDivider(config),
                _buildSectionHeader(config, "1", "Recipients Information"),
                _buildInputField(
                  id:  "name", 
                  title: "Name and Surname*", 
                  validator: (v) {
                    if (v.length < 2) {
                      return "Name must be at least 2 word.";
                    }
                    return null;
                  },
                  controller: name
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: EdgeInsetsGeometry.symmetric(horizontal:  20, vertical: 10),
                  child: CSCPickerPlus(
                    showCities: false,
                      // countryStateLanguage: CountryStateLanguage.englishOrNative,
                      onCountryChanged: (value) {
                          if (value == null) return;

                          setState(() {
                            // Remove emoji + extra spaces
                            final countryName =
                                value.replaceAll(RegExp(r'[^\x00-\x7F]'), '').trim();

                            _selectedCountry = countryName;

                            debugPrint("Country: $_selectedCountry");
                          });
                        },
                      onStateChanged: (value) {
                        setState(() {
                          _selectedCity = value ?? '';
                        });
                      },
                    ),
                ),
                const SizedBox(height: 10),
                _buildSelectRowForPhone(
                  firstId: "phonecode", 
                  firstPlaceholder: "", 
                  firstOption: phoneCountries, 
                  firstSelectValue: _selectedCountryCode, 
                  firstDivideNum: 2,
                  firstFn: (value) => setState(() {
                    _selectedCountryCode = value ;
                  }),
                  secondDivideNum: 2
                ),
                const SizedBox(height: 10),
                _buildInputField(
                  id: "email", 
                  title: "E-mail Address*", 
                  validator: (v) {
                    if (v.isEmpty) return 'Email is required.';
                    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
                    if (!emailRegex.hasMatch(v)) return 'Enter a valid email address.';
                    return null;
                  }, 
                description: "This address will be used to send you order and bill details.",
                controller: email
                ),
                 _buildSectionHeader(config, "2", "Shipping Address"),
                const SizedBox(height: 10),
                _buildInputField(
                  id: "addressTitle", 
                  title: "Address Title (Optional)",
                  validator:(v) {
                    return null;
                  }, 
                description: "For estimating if the place is opened or closed on the weekends.",
                controller: addressTitle
                ),
                const SizedBox(height: 10),
                _buildInputField(
                  id: "addressStreet",
                  title:  "Address*, Street and apartment name etc ..", 
                  validator: (v) {
                  if (v.length < 2) {
                    return "Address Street must be at least 2 word.";
                  }
                  return null;
                }, 
                controller: address1,
                widget: Icon(LucideIcons.mapPin)),
                const SizedBox(height: 10),
                if(!existAddress2)
                  _buildOptionalWidget( config.readColor, GestureDetector(onTap: () => setState(() {
                    existAddress2 = true;
                  }),child: Icon(Icons.add, size: 18,)), "Street Address 2 (Optional)"),
                if(existAddress2)
                  _buildInputField(
                    id: "addressStreet",
                    title:  "Address*, Street and apartment name etc ..", 
                    validator: (v) {
                    if (v.length < 2) {
                      return "Address Street must be at least 2 word.";
                    }
                    return null;
                }, 
                controller: address2,
                widget: Icon(LucideIcons.mapPin)),
                const SizedBox(height: 10),
                _buildOptionalWidget( 
                  config.primary, 
                  ShadCheckbox(value: markDefault, onChanged: (value) => setState(() {
                    markDefault = value ;
                  }),), 
                  "Set as default shipping address"),
                const SizedBox(height: 10),
                _buildSaveButton(config),
                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDivider(IAppColorAbstract config) {
    return Divider(
      thickness: 8,
      color: config.lineColor,
    );
  }

  Widget _buildSectionHeader(IAppColorAbstract config, String number, String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        children: [
          CircleWidget(
            colorData: config.primary,
            widgetData: Text(number),
            height: 30,
            width: 30,
          ),
          const SizedBox(width: 10),
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInputField({
  required String id,
  required String title,
  required TextEditingController controller,
  required String? Function(String v) validator,
  String? description,
  Widget? widget
}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
      child: ShadInputFormField(
        id: id,
        controller: controller,
        padding: EdgeInsets.all(15),
        placeholder: Text(title),
        description: description != null ? Text(description) : null,
        decoration: const ShadDecoration(secondaryFocusedBorder: ShadBorder.none),
        validator: validator,
        trailing: widget,
      ),
    );
  }

  Widget _buildSelectRowForPhone({
    required String firstId, 
    required String firstPlaceholder, 
    required firstSelectValue, 
    required Function firstFn, 
    required List<PhoneCountry> firstOption, 
    required double firstDivideNum, 
    required double secondDivideNum,
    }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final firstFieldWidth = (constraints.maxWidth - 10) / 3;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(
                        color: const Color.fromARGB(255, 218, 219, 221)
                      )
                    ),
                    child: CountryCodePicker(
                      padding: EdgeInsetsGeometry.all(7),
                      onChanged: (v) => setState(() {
                        print("counst code $v");
                        _selectedCountryCode = v ;
                      }),
                      hideCloseIcon: true,
                      hideHeaderText: true,
                      initialSelection: 'MM',
                      //favorite: ['+95','MM'],
                      alignLeft: false,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: ShadInputFormField(
                      id: 'phone_number',
                      controller: phone,
                      keyboardType: TextInputType.number,
                      decoration: ShadDecoration(
                        secondaryFocusedBorder: ShadBorder.none
                      ),
                      padding: EdgeInsets.all(15),
                      placeholder: Text("Phone Number*"),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 10,),
              Text("For shipping related questions only.", style: TextStyle(color: const Color.fromRGBO(134, 142, 150, 1)),)
            ],
          );
        },
      ),
    );
  }

  // Widget _buildSelectField({
  //   required double width,
  //   required String id,
  //   required String placeholder,
  //   required String? value,
  //   required List<String> options,
  //   required ValueChanged<String?> onChanged,
  // }) {
  //   return SizedBox(
  //     width: width,
  //     child: ShadSelectFormField<String>(
  //       id: id,
  //       minWidth: width,
  //       padding: const EdgeInsets.all(15),
  //       placeholder: Text('$placeholder'),
  //       selectedOptionBuilder: (_, value) => Text(value),
  //       options: options
  //           .map((option) => ShadOption(
  //                 value: option,
  //                 child: Text(option),
  //               ))
  //           .toList(),
  //       validator: (v) => (v == null || v.isEmpty) 
  //           ? 'Please select a ${placeholder.replaceAll('*', '').toLowerCase()}'
  //           : null,
  //       decoration: const ShadDecoration(
  //         secondaryFocusedBorder: ShadBorder.none,
  //       ),
  //       onChanged: onChanged,
  //     ),
  //   );
  // }

  Widget _buildSaveButton(IAppColorAbstract config) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: ShadButton(
        width: double.infinity,
        backgroundColor: config.clickColor,
        decoration: ShadDecoration(
          border: ShadBorder.all(
            radius: BorderRadius.circular(20),
          ),
        ),
        onPressed: _submit,
        child: const Text(
          "Save",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget _buildOptionalWidget(Color color, Widget widget, String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          widget,
          SizedBox(width: 5),
          Text(title, style: TextStyle(fontSize: 16,color: color),)
        ],
      ),
  );
}

}