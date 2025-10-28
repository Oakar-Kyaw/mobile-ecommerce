import 'package:ecommerce_mobile/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class Filter extends StatefulWidget {
  const Filter({super.key});

  @override
  State<Filter> createState() => _FilterState();
}

class _FilterState extends State<Filter> {
  @override
  Widget build(BuildContext context) {
    final colorScheme = ShadTheme.of(context).colorScheme;

    return Container(
      margin: EdgeInsets.only(right: 5),
      decoration: BoxDecoration(color: colorScheme.background),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Left: item count
          const Row(
            children: [
              Text("512,344+", style: TextStyle(fontWeight: FontWeight.bold)),
              SizedBox(width: 4),
              Text("items"),
            ],
          ),

          // Right: Sort & Filter buttons
              Row(
                children: [
                  Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                      decoration: BoxDecoration(
                        color: LightModeColors.background, // background color
                        borderRadius: BorderRadius.circular(5), // optional rounded corners
                        boxShadow: [
                          BoxShadow(
                            color: LightModeColors.textSecondary, 
                            blurRadius: 6, // how soft the shadow looks
                           offset: const Offset(1, 2), // move shadow down a bit
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Sort",
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                          ),
                          const SizedBox(width: 4,),
                          Icon(LucideIcons.arrowDownUp, size: 14,)
                        ],
                      ),
                    ),
                  
                  const SizedBox(width: 10),
                  Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                      decoration: BoxDecoration(
                        color: LightModeColors.background, // background color
                        borderRadius: BorderRadius.circular(5), // optional rounded corners
                        boxShadow: [
                          BoxShadow(
                            color: LightModeColors.textSecondary, // shadow color
                           // spreadRadius: 0.2, // how far it spreads
                            blurRadius: 6, // how soft the shadow looks
                           offset: const Offset(1, 2), // move shadow down a bit
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Filter",
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                          ),
                          const SizedBox(width: 4,),
                          Icon(Icons.filter_list_alt, size: 14,)
                        ],
                      ),
                    ),
                ],
              )

            ],
          ),
    );
  }
}
