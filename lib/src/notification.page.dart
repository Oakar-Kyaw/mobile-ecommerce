import 'package:ecommerce_mobile/api/user-api.service.dart';
import 'package:ecommerce_mobile/components/app-bar.dart';
import 'package:ecommerce_mobile/riverpod/system-configuration.dart';
import 'package:ecommerce_mobile/src/app-route.dart';
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
              children: const [
                Center(child: Text("All Notifications")),
                Center(child: Text("Unread Notifications")),
                Center(child: Text("Read Notifications")),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
