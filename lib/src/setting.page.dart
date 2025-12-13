import 'package:ecommerce_mobile/components/app-bar.dart';
import 'package:ecommerce_mobile/riverpod/system-configuration.dart';
import 'package:ecommerce_mobile/ui/setting-content.ui.dart';
import 'package:ecommerce_mobile/components/setting-header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SettingPage extends ConsumerStatefulWidget {
  const SettingPage({super.key});

  @override
  ConsumerState<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends ConsumerState<SettingPage> {
  final bool isLogin = false;
  final List<Widget> noSettingItems = [
    SettingHeader(),
    Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: Text("Account Settings", style: TextStyle(fontWeight: FontWeight.bold),),
    ),
    SettingContent(title: Text('Deliver to'), leading: Icon(Icons.delivery_dining_outlined) , isShowDivider: true, content: "Myanmar", trailing: SizedBox(width: 20, height:20, child: Image.asset("assets/images/myanmar.jpg")), lastIcon: Icon(Icons.arrow_forward_ios, size: 15,)),
    SettingContent(title: Text('Currency'), leading: Icon(Icons.money) , isShowDivider: true, content: "MMK", lastIcon: Icon(Icons.arrow_forward_ios, size: 15,)),
    SettingContent(title: Text('Language'), leading: Icon(Icons.language) , isShowDivider: true, content: "English", lastIcon: Icon(Icons.arrow_forward_ios, size: 15,)),// {"title": "Account Settings", "isShowDivider": false, "lastIcon": null},
    SettingContent(title: Text('Notification'), leading: Icon(Icons.money) , isShowDivider: true, lastIcon: Icon(Icons.arrow_forward_ios, size: 15,)),
    SettingContent(
      title: Text('Version'), 
      description: Text("2.2"), 
      isShowDivider: true, 
      lastIcon: Stack(
        children: [
          Text("Update"),
          Positioned(
            top: 18,
            child: Container(
              width: 54, 
              height: 1, 
              decoration: BoxDecoration(
                color: Colors.black
          ),))
        ],
    )),
    SettingContent(title: Text('Terms & Conditions'), isShowDivider: true, lastIcon: Icon(Icons.arrow_forward_ios, size: 15,)),// {"title": "Account Settings", "isShowDivider": false, "lastIcon": null},
    SettingContent(title: Text('Privacy Policy'), isShowDivider: false, lastIcon: Icon(Icons.arrow_forward_ios, size: 15,)),// {"title": "Account Settings", "isShowDivider": false, "lastIcon": null},
  ];

  final List<Widget> settingItems = [
    SettingContent(title: Text('Personal Details'), leading: Icon(Icons.person_2_outlined) , isShowDivider: true, lastIcon: Icon(Icons.arrow_forward_ios, size: 15,)),
    SettingContent(title: Text('Shipping Address'), leading: Icon(Icons.location_on_outlined) , isShowDivider: true, lastIcon: Icon(Icons.arrow_forward_ios, size: 15,)),
    SettingContent(title: Text('Devliver to'), leading: Icon(Icons.delivery_dining_outlined) , isShowDivider: true, content: "Myanmar", trailing: SizedBox(width: 20, height:20, child: Image.asset("assets/images/myanmar.jpg")), lastIcon: Icon(Icons.arrow_forward_ios, size: 15,)),
    SettingContent(title: Text('Currency'), leading: Icon(Icons.money) , isShowDivider: true, content: "MMK", lastIcon: Icon(Icons.arrow_forward_ios, size: 15,)),
    SettingContent(title: Text('Language'), leading: Icon(Icons.language) , isShowDivider: true, content: "English", lastIcon: Icon(Icons.arrow_forward_ios, size: 15,)),// {"title": "Account Settings", "isShowDivider": false, "lastIcon": null},
    SettingContent(title: Text('Notification'), leading: Icon(Icons.money) , isShowDivider: true, lastIcon: Icon(Icons.arrow_forward_ios, size: 15,)),
    SettingContent(title: Text('Change Password'), leading: Icon(Icons.lock_outline_rounded) , isShowDivider: true, lastIcon: Icon(Icons.arrow_forward_ios, size: 15,)),
    SettingContent(
      title: Text('Version'), 
      description: Text("2.2"), 
      isShowDivider: true, 
      lastIcon: Stack(
        children: [
          Text("Update"),
          Positioned(
            top: 18,
            child: Container(
              width: 54, 
              height: 1, 
              decoration: BoxDecoration(
                color: Colors.black
          ),))
        ],
    )),
    SettingContent(title: Text('Terms & Conditions'), isShowDivider: true, lastIcon: Icon(Icons.arrow_forward_ios, size: 15,)),// {"title": "Account Settings", "isShowDivider": false, "lastIcon": null},
    SettingContent(title: Text('Privacy Policy'), isShowDivider: false, lastIcon: Icon(Icons.arrow_forward_ios, size: 15,)),// {"title": "Account Settings", "isShowDivider": false, "lastIcon": null},
  ];

  @override
  Widget build(BuildContext context) {
    final config = ref.watch(appColorProvider);

    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(
          config: config,
          leading: InkWell(
            onTap: () => Navigator.pop(context),
            child: const Icon(Icons.arrow_back),
          ),
          title: "Settings",
        ),
        body: ListView.builder(
          itemCount: isLogin ? settingItems.length: noSettingItems.length,
          itemBuilder: (context, index) {
            return isLogin ?  settingItems[index] : noSettingItems[index];
          }
        ),
      ),
    );
  }
}
