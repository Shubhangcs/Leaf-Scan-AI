import 'package:cloud_firestore/cloud_firestore.dart';

class MessageModel {
  final String message;
  final Timestamp timestamp;
  final String userId;
  final String userType;

  MessageModel({
    required this.message,
    required this.timestamp,
    required this.userId,
    required this.userType,
  });

  Map<String, dynamic> toJson() => {
    "message": message,
    "timestamp": timestamp,
    "user_id": userId,
    "user_type": userType,
  };

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      message: json["message"],
      timestamp: json["timestamp"],
      userId: json["user_id"],
      userType: json["user_type"],
    );
  }
}
