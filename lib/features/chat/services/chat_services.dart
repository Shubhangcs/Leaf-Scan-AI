import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hive/hive.dart';
import 'package:leaf_scan/features/chat/models/message_model.dart';
import 'package:leaf_scan/init.main.dart';
import 'package:http/http.dart' as http;

// class ChatService {
//   final FirebaseFirestore firebaseFirestore =
//       serviceLocator<FirebaseFirestore>();

//   final String currentUserId = serviceLocator<Box<String>>().get("user_id")!;

//   Future<void> sendMessage({
//     required String chatId,
//     required String message,
//   }) async {
//     final messageModel = MessageModel(
//       message: message,
//       timestamp: Timestamp.now(),
//       userId: currentUserId,
//       userType: "USER",
//     );

//     await firebaseFirestore
//         .collection("chats")
//         .doc(currentUserId)
//         .collection("chat")
//         .doc(chatId)
//         .collection("messages")
//         .add(messageModel.toJson());
//   }

//   Future<DocumentReference> addBotThinkingMessage({
//     required String chatId,
//     required MessageModel messageModel,
//   }) async {
//     return await firebaseFirestore
//         .collection("chats")
//         .doc(currentUserId)
//         .collection("chat")
//         .doc(chatId)
//         .collection("messages")
//         .add(messageModel.toJson());
//   }

//   Future<int> callLlamaAPI({
//     required String prompt,
//     required String chatId,
//   }) async {
//     final response = await http.post(
//       Uri.parse("http://192.168.217.128:8080/chat"),
//       headers: {"Content-Type": "application/json"},
//       body: jsonEncode({
//         "user_id": currentUserId,
//         "chat_id": chatId,
//         "question": prompt,
//       }),
//     );
//     return response.statusCode;
//   }

//   Stream<List<MessageModel>> getMessages(String chatId) {
//     return firebaseFirestore
//         .collection("chats")
//         .doc(currentUserId)
//         .collection("chat")
//         .doc(chatId)
//         .collection("messages")
//         .orderBy("timestamp", descending: false)
//         .snapshots()
//         .map((snapshot) => snapshot.docs
//             .map((doc) => MessageModel.fromJson(doc.data()))
//             .toList());
//   }
// }

class ChatService {
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  final String currentUserId = serviceLocator<Box<String>>().get("user_id")!;

  Stream<List<MessageModel>> getMessages(String chatId) {
    return firebaseFirestore
        .collection("chats")
        .doc(currentUserId)
        .collection("chat")
        .doc(chatId)
        .collection("messages")
        .orderBy("timestamp")
        .snapshots()
        .map((snap) =>
            snap.docs.map((doc) => MessageModel.fromJson(doc.data())).toList());
  }

  Future<void> sendMessage({
    required String chatId,
    required String message,
  }) async {
    final messageModel = MessageModel(
      message: message,
      timestamp: Timestamp.now(),
      userId: currentUserId,
      userType: "USER",
    );

    await firebaseFirestore
        .collection("chats")
        .doc(currentUserId)
        .collection("chat")
        .doc(chatId)
        .collection("messages")
        .add(messageModel.toJson());
  }

  Future<void> sendBotMessage({
    required String chatId,
    required String message,
  }) async {
    final botMessage = MessageModel(
      message: message,
      timestamp: Timestamp.now(),
      userId: "bot",
      userType: "BOT",
    );

    await firebaseFirestore
        .collection("chats")
        .doc(currentUserId)
        .collection("chat")
        .doc(chatId)
        .collection("messages")
        .add(botMessage.toJson());
  }

  Future<int> callLlamaAPI(
      {required String prompt, required String chatId}) async {
    final response = await http.post(
      Uri.parse("http://192.168.217.128:8080/chat"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "user_id": currentUserId,
        "chat_id": chatId,
        "question": prompt,
      }),
    );
    return response.statusCode;
  }
}
