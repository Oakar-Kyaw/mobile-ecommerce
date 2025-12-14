import 'package:ecommerce_mobile/utils/constant.dart';
import 'package:flutter/material.dart';

class ProductTabBar extends StatelessWidget {
  final IAppColorAbstract config;
  final String tabValue;
  final int reviewLength;
  final TabController tabController;
  final Function handleTabBar;
  const ProductTabBar({
     Key? key,
     required this.config,
     required this.tabValue,
     required this.reviewLength,
     required this.tabController,
     required this.handleTabBar
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TabBar(
              isScrollable: true,
              tabAlignment: TabAlignment.start,
              labelColor: config.primary,
              overlayColor: WidgetStateColor.transparent,
              labelStyle: TextStyle(
              fontWeight: FontWeight.bold
              ),
              unselectedLabelStyle: TextStyle(
                  fontWeight: FontWeight.normal
              ),
              labelPadding: EdgeInsets.zero,
              indicatorColor: config.primary,
              indicatorPadding: tabValue == "reviews" ? EdgeInsetsGeometry.only(left: 20): EdgeInsetsGeometry.zero,
              dividerColor: config.lineColor,
              controller: tabController,
              onTap: (value) => handleTabBar(value),
              onFocusChange: (value, index) => handleTabBar(value),
              tabs: [
              Tab(
                child: Text('Description')
              ),
              Tab(
                child: Padding(
                    padding: EdgeInsets.only(left: 20),
                    child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text('Reviews'),
                      const SizedBox(width: 5),
                      Container(
                        padding: EdgeInsets.symmetric(vertical: 1, horizontal: 8),
                        decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: config.textSecondary
                      ),
                        child: Text("$reviewLength", style: TextStyle(color: config.background),)
                      )
                      ],
                      ),
                    ),
              ),
      ],
    );
  }
}