import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:leaf_scan/core/args/chat_page_args.dart';
import 'package:leaf_scan/core/common/widgets/custom_app_bar.dart';
import 'package:leaf_scan/core/themes/app_colors.dart';
import 'package:leaf_scan/features/chat/widgets/history_loading_widget.dart';
import 'package:leaf_scan/init.main.dart';
import 'package:hive/hive.dart';

class ChatHistoryPage extends StatelessWidget {
  ChatHistoryPage({super.key});

  final FirebaseFirestore firestore = serviceLocator<FirebaseFirestore>();
  final String userId = serviceLocator<Box<String>>().get("user_id")!;

  Stream<List<Map<String, dynamic>>> _getChatListStream() {
    return firestore
        .collection("chats")
        .doc(userId)
        .collection("chat")
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        return {
          "chatId": doc.id,
          "name": doc.data()['name'] ?? "Unknown",
        };
      }).toList();
    });
  }

  void _openChatPage(BuildContext context, String chatId, String name) {
    Navigator.pushNamed(
      context,
      "/chat",
      arguments: ChatPageArgs(
        userId: userId,
        chatId: chatId,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar.build(),
      body: StreamBuilder<List<Map<String, dynamic>>>(
        stream: _getChatListStream(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return HistoryLoadingWidget();
          }

          final chats = snapshot.data ?? [];

          if (chats.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.no_cell_rounded,
                    size: 60,
                    color: AppColors.greenColor,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "No chats found",
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    "You can try again",
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                          color: AppColors.darkGreyColor,
                        ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.refresh,
                      size: 40,
                      color: AppColors.greenColor,
                    ),
                  ),
                ],
              ),
            );
          }

          return ListView.builder(
            itemCount: chats.length,
            itemBuilder: (context, index) {
              final chat = chats[index];
              return ListTile(
                leading: Icon(
                  Icons.history_rounded,
                  size: 30,
                  color: AppColors.greenColor,
                ),
                title: Text(chat['name'],
                    style: Theme.of(context).textTheme.titleMedium),
                subtitle: Text(
                  "Chat ID: ${chat['chatId']}",
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                        color: AppColors.darkGreyColor,
                      ),
                ),
                onTap: () =>
                    _openChatPage(context, chat['chatId'], chat['name']),
              );
            },
          );
        },
      ),
    );
  }
}
