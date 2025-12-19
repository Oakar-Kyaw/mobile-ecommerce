import 'dart:convert';
import 'dart:io';

import 'package:ecommerce_mobile/api/user-api.service.dart';
import 'package:ecommerce_mobile/components/app-bar.dart';
import 'package:ecommerce_mobile/riverpod/system-configuration.dart';
import 'package:ecommerce_mobile/utils/constant.dart';
import 'package:ecommerce_mobile/utils/secure-storage.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:dio/dio.dart';

class PersonDetail extends ConsumerStatefulWidget {
  const PersonDetail({super.key});

  @override
  ConsumerState<PersonDetail> createState() => _PersonDetailState();
}

class _PersonDetailState extends ConsumerState<PersonDetail> {
  File? selectedImage;
  Map<String, dynamic>? userData;
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  String? photoUrl;

  bool _loading = false;

  @override
  void initState() {
    super.initState();
    readUserData();
  }

  readUserData() async {
  final Map<String, dynamic>? data = await readUserFullData();

  if (data == null) return;
  print("data: $data");
  setState(() {
    _firstNameController.text = data['firstName']?.toString() ?? "";
    _lastNameController.text  = data['lastName']?.toString() ?? "";
    _emailController.text     = data['email']?.toString() ?? "";
    _phoneController.text     = data['phone']?.toString() ?? "";
    _addressController.text   = data['address']?.toString() ?? "";

    photoUrl = data['photoUrl']?.toString();
  });
}

  Future<void> pickImage() async {
    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.image, // ✅ IMPORTANT
      );

      if (result != null && result.files.single.path != null) {
        setState(() {
          selectedImage = File(result.files.single.path!);
        });
      }
    } catch (e) {
      print("Error picking file: $e");
    }
  }

  handleSubmit() async{
  final userFullData = await storage.read(key: "userFullData");
  try {
    final data = {
      "firstName": _firstNameController.text.trim(),
      "lastName": _lastNameController.text.trim(),
      "email": _emailController.text.trim(),
      "phone": _phoneController.text.trim(),
      "role": "CUSTOMER",
      "address": _addressController.text.trim(),
    };
    final userFullData = await readUserFullData();
    final id = userFullData["id"];
    FormData formData = FormData.fromMap({
      ...data,
      if(selectedImage !=null) 
        "photoUrl": await MultipartFile.fromFile(selectedImage!.path, filename: selectedImage!.path.split("/").last)
    });
    final response = await updateUserData(id, formData);

    if (response?["success"] == true) {
      await storage.write(key: "userFullData", value: jsonEncode(response!["data"]));
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Profile updated successfully")),
      );
    } else {
      throw Exception(response?["message"]);
    }
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Update failed: $e")),
    );
  } finally {
    setState(() => _loading = false);
  }
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final IAppColorAbstract config = ref.watch(appColorProvider);

    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(
        config: config,
        leading: GestureDetector(
          child: const Icon(Icons.arrow_back),
          onTap: () => Navigator.pop(context),
        ),
        title: "Personal Details"
      ),
        body: Padding(
                padding: const EdgeInsets.all(20),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: () => pickImage(),
                        child: CircleAvatar(
                          radius: 30,
                          backgroundColor: Colors.grey.shade300,
                          backgroundImage:
                              selectedImage != null ? FileImage(selectedImage!) : (photoUrl != null && photoUrl!.isNotEmpty) ? NetworkImage(photoUrl!): null,
                          child: selectedImage == null && (photoUrl == null || photoUrl!.isEmpty)
                              ? const Icon(Icons.person, size: 50)
                              : null,
                        ),
                      ),
                      const SizedBox(height: 20),
                      ShadInputFormField(
                        decoration: ShadDecoration(
                          secondaryFocusedBorder: ShadBorder.none,
                        ),
                        label: const Text("First Name", style: TextStyle(fontWeight: FontWeight.bold),),
                        controller: _firstNameController,
                      ),
                      const SizedBox(height: 20),
                      ShadInputFormField(
                        decoration: ShadDecoration(
                          secondaryFocusedBorder: ShadBorder.none,
                        ),
                        label: const Text("Last Name", style: TextStyle(fontWeight: FontWeight.bold)),
                        controller: _lastNameController,
                      ),
                      const SizedBox(height: 20),
                      ShadInputFormField(
                        decoration: ShadDecoration(
                          secondaryFocusedBorder: ShadBorder.none,
                        ),
                        label: const Text("Email", style: TextStyle(fontWeight: FontWeight.bold)),
                        controller: _emailController,
                      ),
                      const SizedBox(height: 20),
                      ShadInputFormField(
                        decoration: ShadDecoration(
                          secondaryFocusedBorder: ShadBorder.none,
                        ),
                        label: const Text("Phone", style: TextStyle(fontWeight: FontWeight.bold)),
                        controller: _phoneController,
                      ),
                      const SizedBox(height: 20),
                      ShadInputFormField(
                        decoration: ShadDecoration(
                          secondaryFocusedBorder: ShadBorder.none,
                        ),
                        label: const Text("Address", style: TextStyle(fontWeight: FontWeight.bold)),
                        controller: _addressController,
                      ),
                      const SizedBox(height: 20,),
                      ShadButton(
                        onPressed: () => handleSubmit(),
                        width: double.infinity,
                        backgroundColor: config.clickColor,
                        decoration: ShadDecoration(
                          border: ShadBorder.all(
                            radius: BorderRadius.circular(20)
                          )
                        ),
                        child: Text("Save", style: TextStyle(fontWeight: FontWeight.bold)),
                      )
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
