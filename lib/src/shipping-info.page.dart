import 'package:country_code_picker/country_code_picker.dart';
import 'package:ecommerce_mobile/riverpod/system-configuration.dart';
import 'package:ecommerce_mobile/ui/circle-component.ui.dart';
import 'package:ecommerce_mobile/utils/constant.dart';
import 'package:ecommerce_mobile/utils/country-code.dart';
import 'package:ecommerce_mobile/utils/phone-country-model.dart';
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

  String? _selectedCountry;
  String? _selectedCity;
  String? _selectedCountryCode;
  String? _selectedPhoneNumber;

  late double _codePadding = 15 ;

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
                _buildInputField(id:  "name", title: "Name and Surname*", validator: (v) {
                  if (v.length < 2) {
                    return "Name must be at least 2 word.";
                  }
                  return null;
                }),
                const SizedBox(height: 10),
                _buildSelectRow(
                  firstId: "country", 
                  firstPlaceholder: "Country*", 
                  firstOption: ["Myanmar"], 
                  firstSelectValue: _selectedCountry, 
                  firstDivideNum: 2,
                  firstFn: (value) => setState(() {
                    _selectedCountry = value ;
                  }),
                  secondId: "city", 
                  secondPlaceholder: "City*", 
                  secondOption: ["Yangon", "Mandalay"], 
                  secondSelectValue: _selectedCity, 
                  secondDivideNum: 2,
                  secondFn: (value) => setState(() {
                    _selectedCity = value ;
                  }),
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
                _buildInputField(id: "email", title: "E-mail Address*", validator: (v) {
                  if (v.isEmpty) return 'Email is required.';
                  final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
                  if (!emailRegex.hasMatch(v)) return 'Enter a valid email address.';
                  return null;
                }, description: "This address will be used to send you order and bill details."),
                 _buildSectionHeader(config, "2", "Shipping Address"),
                const SizedBox(height: 10),
                _buildInputField(id: "addressTitle", title: "Address Title (Optional)",validator:(v) {
                  return null;
                }, description: "For estimating if the place is opened or closed on the weekends."),
                const SizedBox(height: 10),
                _buildInputField(id: "addressStreet",title:  "Address*, Street and apartment name etc ..", validator: (v) {
                  if (v.length < 2) {
                    return "Address Street must be at least 2 word.";
                  }
                  return null;
                }, widget: Icon(LucideIcons.mapPin)),
                const SizedBox(height: 10),
                _buildOptionalWidget( config.readColor, Icon(Icons.add, size: 18,), "Street Address 2 (Optional)"),
                const SizedBox(height: 10),
                _buildOptionalWidget( config.primary, ShadCheckbox(value: false), "Set as default shipping address"),
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
  required String? Function(String v) validator,
  String? description,
  Widget? widget
}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
      child: ShadInputFormField(
        id: id,
        padding: EdgeInsets.all(15),
        placeholder: Text(title),
        description: description != null ? Text(description) : null,
        decoration: const ShadDecoration(secondaryFocusedBorder: ShadBorder.none),
        validator: validator,
        trailing: widget,
      ),
    );
  }

  Widget _buildSelectRow({
    required String firstId, 
    required String firstPlaceholder, 
    required firstSelectValue, 
    required Function firstFn, 
    required List<String> firstOption, 
    required double firstDivideNum, 
    required double secondDivideNum,
    bool? inputField,
    String? secondId, 
    String? secondPlaceholder, 
    String? secondSelectValue, 
    Function? secondFn, 
    List<String>? secondOption
    }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final firstFieldWidth = (constraints.maxWidth - 10) / firstDivideNum;
          final secondFieldWidth =  (constraints.maxWidth - 10) / secondDivideNum ;
          return Row(
            children: [
              _buildSelectField(
                width: firstFieldWidth,
                id: firstId,
                placeholder: firstPlaceholder,
                value: firstSelectValue,
                options: firstOption,
                onChanged: (value) => firstFn(value),
              ),
              const SizedBox(width: 10),
              //second select field
              if(secondId != null && secondPlaceholder != null && secondOption != null && secondFn != null)
                _buildSelectField(
                  width: secondFieldWidth,
                  id: secondId,
                  placeholder: secondPlaceholder,
                  value: secondSelectValue,
                  options: secondOption,
                  onChanged: (value) => secondFn(value),
                ),
            ],
          );
        },
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
                  // ShadSelectFormField<PhoneCountry>(
                  //   id: 'phone_country',
                  //   padding: EdgeInsets.all(_codePadding),
                  //   placeholder: const Text("Code"),
                  //   minWidth: firstFieldWidth,
                  //   selectedOptionBuilder: (context, value) {
                  //     return Row(
                  //       children: [
                  //         Text(
                  //           value.flag, // 🇲🇲 +95
                  //           style: const TextStyle(fontSize: 20),
                  //         ),
                  //         const SizedBox(width: 5,),
                  //         Text(value.code, style: TextStyle(fontWeight: FontWeight.bold),)
                  //       ],
                  //     );
                  //   },

                  //   options: phoneCountries.map((country) {
                  //     return ShadOption(
                  //       value: country,
                  //       child: Text(
                  //         country.display, // 🇲🇲 Myanmar (+95)
                  //        // style: const TextStyle(fontSize: 14),
                  //       ),
                  //     );
                  //   }).toList(),

                  //   validator: (v) => v == null ? "Select country code" : null,

                  //   onChanged: (value) {
                  //     setState(() {
                  //       _codePadding = 11;
                  //     });
                  //   },

                  //   decoration: const ShadDecoration(
                  //     secondaryFocusedBorder: ShadBorder.none,
                  //   ),
                  // ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(
                        color: const Color.fromARGB(255, 218, 219, 221)
                      )
                    ),
                    child: CountryCodePicker(
                      padding: EdgeInsetsGeometry.all(7),
                      onChanged: print,
                      hideCloseIcon: true,
                      hideHeaderText: true,
                      // searchDecoration: InputDecoration(
                      //   icon: Icon(Icons.search)
                      // ),
                      // Initial selection and favorite can be one of code ('IT') OR dial_code('+39')
                      initialSelection: 'MM',
                      favorite: ['+95','MM'],
                      // optional. Shows only country name and flag
                      // showCountryOnly: false,
                      // // optional. Shows only country name and flag when popup is closed.
                      // showOnlyCountryWhenClosed: false,
                      // optional. aligns the flag and the Text left
                      alignLeft: false,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: ShadInputFormField(
                      id: 'phone_number',
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

  Widget _buildSelectField({
    required double width,
    required String id,
    required String placeholder,
    required String? value,
    required List<String> options,
    required ValueChanged<String?> onChanged,
  }) {
    return SizedBox(
      width: width,
      child: ShadSelectFormField<String>(
        id: id,
        minWidth: width,
        padding: const EdgeInsets.all(15),
        placeholder: Text('$placeholder'),
        selectedOptionBuilder: (_, value) => Text(value),
        options: options
            .map((option) => ShadOption(
                  value: option,
                  child: Text(option),
                ))
            .toList(),
        validator: (v) => (v == null || v.isEmpty) 
            ? 'Please select a ${placeholder.replaceAll('*', '').toLowerCase()}'
            : null,
        decoration: const ShadDecoration(
          secondaryFocusedBorder: ShadBorder.none,
        ),
        onChanged: onChanged,
      ),
    );
  }

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

  void _submit() {
    if (_formKey.currentState?.validate() ?? false) {
      final shippingData = {
        "country": _selectedCountry,
        "city": _selectedCity,
      };

      debugPrint("Shipping Info: $shippingData");
    }
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