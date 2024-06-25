import 'package:flutter/material.dart';
import 'package:ro_chatter/Models/chat_model.dart';

class chatListWidget extends StatelessWidget {
  const chatListWidget({super.key, required this.chatData});
  final ChatModel chatData;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: ListTile(
        title: Text(chatData.receiverData.userName),
        subtitle: Text(chatData.receiver[0].message),
      ),
    );
  }
}
