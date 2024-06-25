// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class UserChatModel {
  String uID;
  String userName;
  UserChatModel({
    required this.uID,
    required this.userName,
  });
  

  UserChatModel copyWith({
    String? uID,
    String? userName,
  }) {
    return UserChatModel(
      uID: uID ?? this.uID,
      userName: userName ?? this.userName,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uID': uID,
      'userName': userName,
    };
  }

  factory UserChatModel.fromMap(Map<String, dynamic> map) {
    return UserChatModel(
      uID: map['uID'] as String,
      userName: map['userName'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserChatModel.fromJson(String source) => UserChatModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'UserChatModel(uID: $uID, userName: $userName)';

  @override
  bool operator ==(covariant UserChatModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.uID == uID &&
      other.userName == userName;
  }

  @override
  int get hashCode => uID.hashCode ^ userName.hashCode;
}
