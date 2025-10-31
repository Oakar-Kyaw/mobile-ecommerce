import 'package:ecommerce_mobile/riverpod/system-configuration.dart';
import 'package:ecommerce_mobile/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SettingContent extends ConsumerWidget {
  final Widget title;
  final Color? backgroundColor;
  final Widget? description;
  final Widget? leading;
  final String?  content;
  final Widget? trailing;
  final Widget?  lastIcon;
  final bool isShowDivider;
  const SettingContent({super.key, required this.title, this.backgroundColor, this.description, this.leading, this.content, this.trailing, this.lastIcon, this.isShowDivider = true});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final IAppColorAbstract config = ref.watch(appColorProvider);
    return Center(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        color: backgroundColor,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
                 Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        // crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [ 
                                  if(leading != null) leading!,
                                  if(leading != null) SizedBox(width: 5),
                                  title
                                ],
                              ),
                              if(description !=null) description!
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment:  CrossAxisAlignment.center,
                            children: [
                              if(trailing != null)  trailing!,
                              SizedBox(width: 5),
                              if(content != null) Text(content!),
                              SizedBox(width: 5),
                              if(lastIcon != null) lastIcon!
                            ],
                          ),
                        ],
              ),
              const SizedBox(height: 10),
              if(isShowDivider) const Divider(
                 thickness: 1,
                 color: Colors.grey,
              ),
          ],
        ),
      ),
    );
  }
}