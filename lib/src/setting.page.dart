import 'package:ecommerce_mobile/components/app-bar.dart';
import 'package:ecommerce_mobile/riverpod/system-configuration.dart';
import 'package:ecommerce_mobile/src/app-route.dart';
import 'package:ecommerce_mobile/ui/setting-content.ui.dart';
import 'package:ecommerce_mobile/components/setting-header.dart';
import 'package:ecommerce_mobile/utils/secure-storage.dart';
import 'package:ecommerce_mobile/utils/top-toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class SettingPage extends ConsumerStatefulWidget {
  const SettingPage({super.key});

  @override
  ConsumerState<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends ConsumerState<SettingPage> {
  bool isLogin = false;

  @override
  void initState() {
    super.initState();
    checkLogin();
  }

  Future<void> checkLogin() async {
    final userFullData = await storage.read(key: "userFullData");
    setState(() {
      isLogin = userFullData != null;
    });
  }

  Future<void> handleLogout() async {
    await deleteLoginData();

    TopToast.show(context: context, icon: LucideIcons.circleCheckBig, title: "Log Out Successful", action: Icon(LucideIcons.x, fontWeight: FontWeight.bold,));      
    //   
    // Delay navigation by 2 seconds
    Future.delayed(const Duration(seconds: 1), () {
      Navigator.pushNamed(context, AppRoute.home);
    });
  }

  @override
  Widget build(BuildContext context) {
    final config = ref.watch(appColorProvider);

    // Common items
    final versionItem = SettingContent(
      title: const Text("Version"),
      description: const Text("2.2"),
      isShowDivider: true,
      lastIcon: Stack(
        children: [
          const Text("Update"),
          Positioned(
            top: 18,
            child: Container(
              width: 54,
              height: 1,
              decoration: const BoxDecoration(color: Colors.black),
            ),
          ),
        ],
      ),
    );

    // Items for non-logged-in users
    final noSettingItems = [
      const SettingHeader(),
      const Padding(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        child: Text("Account Settings", style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      SettingContent(
        title: const Text('Deliver to'),
        leading: const Icon(LucideIcons.truck),
        isShowDivider: true,
        content: "Myanmar",
        trailing: SizedBox(width: 20, height: 20, child: Image.asset("assets/images/myanmar.jpg")),
        lastIcon: const Icon(Icons.arrow_forward_ios, size: 15),
      ),
      SettingContent(
        title: const Text('Currency'),
        leading: const Icon(LucideIcons.dollarSign),
        isShowDivider: true,
        content: "MMK",
        lastIcon: const Icon(Icons.arrow_forward_ios, size: 15),
      ),
      SettingContent(
        title: const Text('Language'),
        leading: const Icon(Icons.language),
        isShowDivider: true,
        content: "English",
        lastIcon: const Icon(Icons.arrow_forward_ios, size: 15),
      ),
      SettingContent(
        title: const Text('Notification'),
        leading: const Icon(Icons.money),
        isShowDivider: true,
        lastIcon: const Icon(Icons.arrow_forward_ios, size: 15),
      ),
      versionItem,
      SettingContent(title: const Text('Terms & Conditions'), isShowDivider: true, lastIcon: const Icon(Icons.arrow_forward_ios, size: 15)),
      SettingContent(title: const Text('Privacy Policy'), isShowDivider: false, lastIcon: const Icon(Icons.arrow_forward_ios, size: 15)),
    ];

    // Items for logged-in users
    final settingItems = [
      SettingContent(
        title: const Text('Personal Details'),
        leading: const Icon(Icons.person_2_outlined),
        isShowDivider: true,
        lastIcon: const Icon(Icons.arrow_forward_ios, size: 15),
        routeName: AppRoute.personalProfile,
      ),
      SettingContent(
        title: const Text('Shipping Address'),
        leading: const Icon(Icons.location_on_outlined),
        isShowDivider: true,
        lastIcon: const Icon(Icons.arrow_forward_ios, size: 15),
      ),
      SettingContent(
        title: const Text('Deliver to'),
        leading: const Icon(LucideIcons.truck),
        isShowDivider: true,
        content: "Myanmar",
        trailing: SizedBox(width: 20, height: 20, child: Image.asset("assets/images/myanmar.jpg")),
        lastIcon: const Icon(Icons.arrow_forward_ios, size: 15),
      ),
      SettingContent(
        title: const Text('Currency'),
        leading: const Icon(LucideIcons.dollarSign),
        isShowDivider: true,
        content: "MMK",
        lastIcon: const Icon(Icons.arrow_forward_ios, size: 15),
      ),
      SettingContent(
        title: const Text('Language'),
        leading: const Icon(Icons.language),
        isShowDivider: true,
        content: "English",
        lastIcon: const Icon(Icons.arrow_forward_ios, size: 15),
      ),
      SettingContent(
        title: const Text('Notification'),
        leading: const Icon(Icons.money),
        isShowDivider: true,
        lastIcon: const Icon(Icons.arrow_forward_ios, size: 15),
      ),
      SettingContent(
        title: const Text('Change Password'),
        leading: const Icon(Icons.lock_outline_rounded),
        isShowDivider: true,
        lastIcon: const Icon(Icons.arrow_forward_ios, size: 15),
        routeName: AppRoute.otp,
      ),
      versionItem,
      SettingContent(title: const Text('Terms & Conditions'), isShowDivider: true, lastIcon: const Icon(Icons.arrow_forward_ios, size: 15)),
      SettingContent(title: const Text('Privacy Policy'), isShowDivider: false, lastIcon: const Icon(Icons.arrow_forward_ios, size: 15)),
      Padding(
        padding: const EdgeInsets.all(20),
        child: ShadButton(
          onPressed: handleLogout, // Use async logout handler
          width: double.infinity,
          backgroundColor: const Color.fromRGBO(55, 114, 174, 0.8),
          decoration: ShadDecoration(
            border: ShadBorder.all(radius: BorderRadius.circular(20)),
          ),
          child: const Text("Log out", style: TextStyle(fontWeight: FontWeight.bold)),
        ),
      ),
    ];

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
          itemCount: isLogin ? settingItems.length : noSettingItems.length,
          itemBuilder: (context, index) {
            return isLogin ? settingItems[index] : noSettingItems[index];
          },
        ),
      ),
    );
  }
}
