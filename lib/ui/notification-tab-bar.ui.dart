import 'package:ecommerce_mobile/utils/constant.dart';
import 'package:flutter/material.dart';

class NotificationTabBar extends StatelessWidget {
  final IAppColorAbstract config;
  final TabController tabController;
  const NotificationTabBar({
     Key? key,
     required this.config,
     required this.tabController
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TabBar(
              isScrollable: true,
              tabAlignment: TabAlignment.start,
              overlayColor: WidgetStateColor.transparent,
              labelColor: config.primary,
              labelStyle: TextStyle(
              fontWeight: FontWeight.bold
              ),
              unselectedLabelStyle: TextStyle(
                  fontWeight: FontWeight.normal
              ),
              labelPadding: EdgeInsets.zero,
              indicatorColor: config.primary,
              indicatorPadding: EdgeInsetsGeometry.only(left: 12),
              dividerColor: config.lineColor,
              controller: tabController,
              //onTap: (value) => handleTabBar(value),
              tabs: [
             Padding(
               padding: const EdgeInsets.only(left: 25, right: 20),
               child: Tab(child: Text("All")),
             ),
             Padding(
               padding: const EdgeInsets.symmetric(horizontal: 20),
               child: Tab(child: Text("Unread")),
             ),
             Padding(
               padding: const EdgeInsets.symmetric(horizontal: 20),
               child: Tab(child: Text("Read")),
             ),
      ],
    );
  }
}