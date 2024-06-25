// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:ro_chatter/Models/message_model.dart';
import 'package:ro_chatter/Models/user_chatModel.dart';

class ChatModel {
  final String chatID;
  final List<MessageModel> sender;
  final List<MessageModel> receiver;
  final UserChatModel receiverData;
  ChatModel({
    required this.chatID,
    required this.sender,
    required this.receiver,
    required this.receiverData,
  });

  ChatModel copyWith({
    String? chatID,
    List<MessageModel>? sender,
    List<MessageModel>? receiver,
    UserChatModel? receiverData,
  }) {
    return ChatModel(
      chatID: chatID ?? this.chatID,
      sender: sender ?? this.sender,
      receiver: receiver ?? this.receiver,
      receiverData: receiverData ?? this.receiverData,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'chatID': chatID,
      'sender': sender.map((x) => x.toMap()).toList(),
      'receiver': receiver.map((x) => x.toMap()).toList(),
      'receiverData': receiverData.toMap(),
    };
  }

  factory ChatModel.fromMap(Map<String, dynamic> map) {
    return ChatModel(
      chatID: map['chatID'] as String,
      sender: List<MessageModel>.from((map['sender'] as List<int>).map<MessageModel>((x) => MessageModel.fromMap(x as Map<String,dynamic>),),),
      receiver: List<MessageModel>.from((map['receiver'] as List<int>).map<MessageModel>((x) => MessageModel.fromMap(x as Map<String,dynamic>),),),
      receiverData: UserChatModel.fromMap(map['receiverData'] as Map<String,dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory ChatModel.fromJson(String source) => ChatModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ChatModel(chatID: $chatID, sender: $sender, receiver: $receiver, receiverData: $receiverData)';
  }

  @override
  bool operator ==(covariant ChatModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.chatID == chatID &&
      listEquals(other.sender, sender) &&
      listEquals(other.receiver, receiver) &&
      other.receiverData == receiverData;
  }

  @override
  int get hashCode {
    return chatID.hashCode ^
      sender.hashCode ^
      receiver.hashCode ^
      receiverData.hashCode;
  }
}
