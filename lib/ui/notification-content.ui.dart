import 'package:ecommerce_mobile/utils/constant.dart';
import 'package:flutter/material.dart';

class NotificationContent extends StatelessWidget {
  final IAppColorAbstract config;
  final List<Map<String, dynamic>> notiList;
  const NotificationContent({
     Key? key,
     required this.config,
     required this.notiList
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
   return ListView.separated(
                  itemBuilder: (BuildContext context, index){
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                         if(notiList[index]["isUnread"])
                          Container(
                            width: 6,
                            height: 6,
                            decoration: BoxDecoration(
                              color: config.redColor,
                              shape: BoxShape.circle
                            ),
                          ),
                          if(notiList[index]["isUnread"])
                            const SizedBox(width: 5),
                          Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(image: AssetImage("${notiList[index]["imageUrl"]}"), fit: BoxFit.cover) 
                            )
                          ),
                          const SizedBox(width: 20),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("${notiList[index]["title"]}", style: TextStyle( overflow: TextOverflow.clip,fontWeight: notiList[index]["isUnread"] ? FontWeight.bold : FontWeight.normal)),
                                SizedBox(height: 5),
                                Text("${notiList[index]["time"]}", style: TextStyle(color: config.textSecondary))
                              ],
                            ),
                          )

                        ],
                      ),
                    );
                }, 
                separatorBuilder: (BuildContext context, int index) => Divider(color: config.lineColor, thickness: 1),
                itemCount: notiList.length
    );
                
  }
}