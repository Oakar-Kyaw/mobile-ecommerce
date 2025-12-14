import 'package:ecommerce_mobile/api/user-api.service.dart';
import 'package:ecommerce_mobile/components/app-bar.dart';
import 'package:ecommerce_mobile/riverpod/system-configuration.dart';
import 'package:ecommerce_mobile/src/app-route.dart';
import 'package:ecommerce_mobile/ui/notification-content.ui.dart';
import 'package:ecommerce_mobile/ui/notification-tab-bar.ui.dart';
import 'package:ecommerce_mobile/ui/social-button.ui.dart';
import 'package:ecommerce_mobile/utils/check-email-and-phone.dart';
import 'package:ecommerce_mobile/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class NotificationPage extends ConsumerStatefulWidget {
  const NotificationPage({super.key});

  @override
  ConsumerState<NotificationPage> createState() =>
      _NotificationPageState();
}

class _NotificationPageState
    extends ConsumerState<NotificationPage>
    with SingleTickerProviderStateMixin {

  late TabController tabController;
  final List<Map<String, dynamic>> allNoti = [
      {
        "title": "Your order is pending",
        "time": "Wednesday 10 PM, 2024",
        "imageUrl": "assets/images/chris.jpg",
        "isUnread": true,
      },
      {
        "title": "Order shipped successfully",
        "time": "Tuesday 3:45 PM, 2024",
        "imageUrl": "assets/images/chris.jpg",
        "isUnread": false,
      },
      {
        "title": "Payment received",
        "time": "Monday 9:12 AM, 2024",
        "imageUrl": "assets/images/chris.jpg",
        "isUnread": true,
      },
      {
        "title": "Your order was delivered",
        "time": "Sunday 6:30 PM, 2024",
        "imageUrl": "assets/images/chris.jpg",
        "isUnread": false,
      },
      {
        "title": "New promotion available",
        "time": "Saturday 11:00 AM, 2024",
        "imageUrl": "assets/images/chris.jpg",
        "isUnread": true,
      },
    ];

  final List<Map<String, dynamic>> unreadNoti = [
    {
      "title": "Your order is pending",
      "time": "Wednesday 10 PM, 2024",
      "imageUrl": "assets/images/chris.jpg",
      "isUnread": true,
    },
    {
      "title": "Payment received",
      "time": "Monday 9:12 AM, 2024",
      "imageUrl": "assets/images/chris.jpg",
      "isUnread": true,
    },
    {
      "title": "New promotion available",
      "time": "Saturday 11:00 AM, 2024",
      "imageUrl": "assets/images/chris.jpg",
      "isUnread": true,
    },
    {
      "title": "Order confirmation received",
      "time": "Friday 2:30 PM, 2024",
      "imageUrl": "assets/images/chris.jpg",
      "isUnread": true,
    },
    {
      "title": "Price dropped on item you viewed",
      "time": "Thursday 8:15 AM, 2024",
      "imageUrl": "assets/images/chris.jpg",
      "isUnread": true,
    },
  ];

  final List<Map<String, dynamic>> readNoti = [
    {
      "title": "Order shipped successfully",
      "time": "Tuesday 3:45 PM, 2024",
      "imageUrl": "assets/images/chris.jpg",
      "isUnread": false,
    },
    {
      "title": "Your order was delivered",
      "time": "Sunday 6:30 PM, 2024",
      "imageUrl": "assets/images/chris.jpg",
      "isUnread": false,
    },
    {
      "title": "Refund processed successfully",
      "time": "Friday 4:00 PM, 2024",
      "imageUrl": "assets/images/chris.jpg",
      "isUnread": false,
    },
    {
      "title": "Password changed successfully",
      "time": "Thursday 1:10 PM, 2024",
      "imageUrl": "assets/images/chris.jpg",
      "isUnread": false,
    },
    {
      "title": "Welcome to our store!",
      "time": "Monday 8:00 AM, 2024",
      "imageUrl": "assets/images/chris.jpg",
      "isUnread": false,
    },
  ];


  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
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
        title: "Notification",
        lastIcon: ShadButton(
          padding: EdgeInsets.symmetric(horizontal: 8),
          backgroundColor: config.greyColor,
          decoration: ShadDecoration(
            border: ShadBorder.all(
              radius: BorderRadius.circular(20)
            )
          ),
          child: Text("Mark all as undread", style: TextStyle(color: config.primary, fontSize: 12),),
        ),
      ),
      body: Column(
        children: [
          NotificationTabBar(
            config: config,
            tabController: tabController,
          ),
          Expanded(
            child: TabBarView(
              controller: tabController,
              children: [
                NotificationContent(config: config, notiList: allNoti),
                NotificationContent(config: config, notiList: unreadNoti),
                NotificationContent(config: config, notiList: readNoti)
              ],
            ),
          ),
        ],
      ),
    );
  }
}
