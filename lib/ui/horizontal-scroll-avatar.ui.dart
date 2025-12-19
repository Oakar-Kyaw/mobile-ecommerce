import 'package:ecommerce_mobile/riverpod/system-configuration.dart';
import 'package:ecommerce_mobile/src/app-route.dart';
import 'package:ecommerce_mobile/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HorizontalScrollableBrand extends ConsumerWidget {
  final bool isCheckBorderRadius;
  final List<Map<String, dynamic>> datas;
  final String type;
  final void Function(int)? onTap;

  const HorizontalScrollableBrand({
    super.key,
    required this.type,
    required this.datas,
    this.onTap,
    this.isCheckBorderRadius = false, // default false
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final IAppColorAbstract config = ref.watch(appColorProvider);

    return SizedBox(
      height: 80, // enough space for image + title
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 25),
        itemCount: datas.length,
        separatorBuilder: (context, index) => const SizedBox(width: 10),
        itemBuilder: (context, index) {
          final data = datas[index];
          final String? photoUrl = data['photoUrl'];
          final Image image = (photoUrl != null && photoUrl.isNotEmpty)
                            ? Image.network(photoUrl, fit: BoxFit.cover)
                            : Image.asset("assets/images/default.jpg", fit: BoxFit.cover);
          final title = type == "brand" ? data['name'] : data["title"];

          return GestureDetector(
            onTap: () => Navigator.pushNamed(context, AppRoute.brandDetail),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 70,
                  height: 70,
                 // padding: const EdgeInsets.all(2), // space for border
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: isCheckBorderRadius
                        ? Border.all(color: config.textSecondary, width: 0.5)
                        : null,
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadiusGeometry.circular(100),
                    child: image,
                  )
                ),
                const SizedBox(height: 4),
                SizedBox(
                  width: 60, // limit width for long brand names
                  child: Text(
                    title ?? '',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 12),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
