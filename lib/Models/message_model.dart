// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
//static enum messageStatus = [];
class MessageModel {
  String mID;
  String message;
  String senderID;
  String receiverID;
  DateTime timesent;
  bool hasbeenread;
  MessageModel({
    required this.mID,
    required this.message,
    required this.senderID,
    required this.receiverID,
    required this.timesent,
    required this.hasbeenread,
  });
  

  MessageModel copyWith({
    String? mID,
    String? message,
    String? senderID,
    String? receiverID,
    DateTime? timesent,
    bool? hasbeenread,
  }) {
    return MessageModel(
      mID: mID ?? this.mID,
      message: message ?? this.message,
      senderID: senderID ?? this.senderID,
      receiverID: receiverID ?? this.receiverID,
      timesent: timesent ?? this.timesent,
      hasbeenread: hasbeenread ?? this.hasbeenread,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'mID': mID,
      'message': message,
      'senderID': senderID,
      'receiverID': receiverID,
      'timesent': timesent.millisecondsSinceEpoch,
      'hasbeenread': hasbeenread,
    };
  }

  factory MessageModel.fromMap(Map<String, dynamic> map) {
    return MessageModel(
      mID: map['mID'] as String,
      message: map['message'] as String,
      senderID: map['senderID'] as String,
      receiverID: map['receiverID'] as String,
      timesent: DateTime.fromMillisecondsSinceEpoch(map['timesent'] as int),
      hasbeenread: map['hasbeenread'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory MessageModel.fromJson(String source) => MessageModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'MessageModel(mID: $mID, message: $message, senderID: $senderID, receiverID: $receiverID, timesent: $timesent, hasbeenread: $hasbeenread)';
  }

  @override
  bool operator ==(covariant MessageModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.mID == mID &&
      other.message == message &&
      other.senderID == senderID &&
      other.receiverID == receiverID &&
      other.timesent == timesent &&
      other.hasbeenread == hasbeenread;
  }

  @override
  int get hashCode {
    return mID.hashCode ^
      message.hashCode ^
      senderID.hashCode ^
      receiverID.hashCode ^
      timesent.hashCode ^
      hasbeenread.hashCode;
  }
}
