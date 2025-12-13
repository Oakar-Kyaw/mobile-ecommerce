import 'package:ecommerce_mobile/components/app-bar.dart';
import 'package:ecommerce_mobile/riverpod/system-configuration.dart';
import 'package:ecommerce_mobile/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:intl/intl.dart';

class ChatPage extends ConsumerStatefulWidget {
  const ChatPage({super.key});

  @override
  ConsumerState<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends ConsumerState<ChatPage> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final Set<String> shownDates = {};

  final List<Map<String, dynamic>> _messages = [
    {
      "from": 1,
      "message": "Hello",
      "status": "read" ,
      "to": 3,
      "date": "2024-02-19T00:05:30Z"
    },
    {
      "from": 3,
      "message": "Tell me please. What can I help you?",
      "status": "read",
      "to": 1,
      "date": "2024-02-19T01:15:30Z"
    },
    {
      "from": 1,
      "message": "https://i.pinimg.com/1200x/96/5d/73/965d736b0612ba8d0e7145a487df1cc7.jpg",
      "status": "read" ,
      "to": 3,
      "date": "2024-02-20T10:00:30Z"
    },
    {
      "from": 1,
      "message": "Instock?",
      "status": "read" ,
      "to": 3,
      "date": "2024-02-20T10:05:30Z"
    },
    {
      "from": 3,
      "message": "Let me check",
      "status": "delivered",
      "to": 1,
      "date": "2024-02-20T11:00:30Z"
    },
    {
      "from": 3,
      "message": "Still Instock",
      "status": "sent",
      "to": 1,
      "date": "2024-02-20T11:00:30Z"
    },
  ];

  void _addMessage(String text, int from, int to) {
    setState(() {
      _messages.add({
        "from": from,
        "message": text,
        "to": to,
        "read": false,
        "date": DateTime.now().toIso8601String(),
      });
    });
    _scrollToBottom();
  }

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        0,
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOut,
      );
    }
  }

  String _formatDate(String isoDate) {
    final date = DateTime.parse(isoDate).toLocal();
    // Short month name, day, weekday abbreviation, yeaar
    final formatted = DateFormat("MMM d (EEE), y").format(date);
    return formatted; // example = Dec 11 (Mon), 2024 
  }

  String _formatTime(String isoDate) {
    final date = DateTime.parse(isoDate).toLocal();
    return DateFormat('HH:mm').format(date); // 14:23:05
  }

  Widget _buildMessage(Map<String, dynamic> message, IAppColorAbstract config, {bool showDate = false}) {
    final bool isMe = message["from"] == 3;
    final bool isImage = message["message"].toString().startsWith("http");
    final messageDate = _formatDate(message["date"]);
    var sameDate = false;

    showDate && !shownDates.contains(messageDate) ? shownDates.add(messageDate) : sameDate = true;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (showDate && !sameDate)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Center(
              child: Text(
                messageDate,
                style: TextStyle(color: config.textSecondary, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        Align(
          alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
            margin: const EdgeInsets.symmetric(vertical: 4),
            constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.7),
            decoration: BoxDecoration(
              color: isMe ? config.chatMessageColor : config.greyColor,
              borderRadius: BorderRadius.circular(12),
            ),
            child: isImage
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(message["message"], fit: BoxFit.cover),
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        message["message"],
                        style: TextStyle(color: isMe ? config.background : config.textPrimary),
                      ),
                      Row(
                        mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
                        children: [
                          Text(
                            _formatTime(message["date"]), // Always show time
                            style: TextStyle(color: isMe ? config.background : config.textPrimary, fontSize: 12),
                          ),
                          const SizedBox(width: 5),
                          if (isMe)
                            message["status"] == "read"
                                ? Icon(Icons.done_all, size: 14, color: config.readColor)
                                : message["status"] == "delivered" 
                                ? Icon(Icons.done_all, size: 14, color: config.background)
                                : Icon(Icons.done, size: 14, color: config.background),
                        ],
                      )
                    ],
                  ),
          ),
        ),
      ],
    );
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
        title: "Agent Chat",
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.all(20),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                //final message = _messages[_messages.length - 1 - index];
                final message = _messages[index];
                final formattedDate = _formatDate(message["date"]);
                bool showDate = false;
                print("date format is $formattedDate and $message");
                // Always show for the first message
                  final msgDate = DateTime.parse(message["date"]).toLocal();
                  final today = DateTime.now().toLocal();

                  if (msgDate.day != today.day ||
                      msgDate.month != today.month ||
                      msgDate.year != today.year) {
                       showDate = true;
                       print("shownDate is: ${shownDates}");
                        // Show date only once per day
                      //  if (!shownDates.contains(formattedDate)) {
                      //     showDate = true;
                      //     shownDates.add(formattedDate);
                      //   }
                  }
                return _buildMessage(message, config, showDate: showDate);
              },
            ),
          ),

          // Bottom input bar
          Container(
            padding: const EdgeInsets.only(top: 10, bottom: 25, left: 20, right: 20),
            decoration: BoxDecoration(border: Border.all(color: config.greyColor)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(Icons.add),
                const SizedBox(width: 10),
                Expanded(
                  child: ShadInput(
                    controller: _messageController,
                    decoration: ShadDecoration(
                      secondaryFocusedBorder: ShadBorder.all(color: config.background),
                    ),
                    placeholder: Text("Write Something"),
                    trailing: Icon(Icons.emoji_emotions_outlined),
                  ),
                ),
                const SizedBox(width: 10),
                GestureDetector(
                  onTap: () {
                    if (_messageController.text.isEmpty) return;
                    _addMessage(_messageController.text, 1, 3);
                    _messageController.clear();
                  },
                  child: Icon(Icons.send_sharp),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
