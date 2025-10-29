import 'package:ecommerce_mobile/riverpod/system-configuration.dart';
import 'package:ecommerce_mobile/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CustomerBottomNavigationBar extends ConsumerWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;
  final Color activeColor;
  final Color inactiveColor;

  const CustomerBottomNavigationBar({
    Key? key,
    this.currentIndex = 0,
    required this.onTap,
    this.activeColor = Colors.blue,
    this.inactiveColor = Colors.grey,
  }) : super(key: key);

  Widget _buildNavItem({
    required config,
    required IconData icon,
    required String label,
    required int index,
  }) {
    final isSelected = currentIndex == index;
    print(
      'isSelected: $isSelected for index: $index (currentIndex: $currentIndex)',
    );
    return GestureDetector(
      onTap: () => onTap(index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 6),
            decoration: BoxDecoration(
              color: isSelected ? config.textPrimary : Colors.transparent,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(
              icon,
              color: isSelected ? config.background : config.textSecondary,
              size: 24,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: isSelected ? config.textPrimary : config.textSecondary,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final IAppColorAbstract config = ref.watch(appColorProvider);
    return Container(
      decoration: BoxDecoration(
        color: config.background,
        boxShadow: [
          BoxShadow(
            color: config.shadowColor,
            spreadRadius: 1,
            blurRadius: 10,
            offset: const Offset(0, -3),
          ),
        ],
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavItem(config: config, icon: Icons.home, label: 'Home', index: 0),
              _buildNavItem(config: config, icon: Icons.history, label: 'Orders', index: 1),
              _buildNavItem(config: config, icon: Icons.search, label: 'Search', index: 2),
              _buildNavItem(
                config: config,
                icon: Icons.favorite_border,
                label: 'Favorites',
                index: 3,
              ),
              _buildNavItem(config: config, icon: Icons.settings, label: 'Setting', index: 4),
            ],
          ),
        ),
      ),
    );
  }
}
