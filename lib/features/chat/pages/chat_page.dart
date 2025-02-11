import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:leaf_scan/core/common/widgets/custom_app_bar.dart';
import 'package:leaf_scan/core/common/widgets/custom_chat_text_field.dart';
import 'package:leaf_scan/core/themes/app_colors.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  late TextEditingController _chatController;
  List<Map<String, dynamic>> messages = [];

  @override
  void initState() {
    _chatController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _chatController.dispose();
    super.dispose();
  }

  void sendMessage() {
    if (_chatController.text.isNotEmpty) {
      setState(() {
        messages.add({"text": _chatController.text, "isUser": true});
        _chatController.clear();

        Future.delayed(Duration(seconds: 1), () {
          setState(() {
            messages.add({"text": "AI Response", "isUser": false});
          });
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar.build(),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(10),
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final message = messages[index];
                return Align(
                  alignment: message["isUser"]
                      ? Alignment.centerRight
                      : Alignment.centerLeft,
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: message["isUser"]
                          ? AppColors.greenColor
                          : AppColors.whiteColor,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      message["text"],
                      style: GoogleFonts.workSans(
                        color: message["isUser"]
                            ? AppColors.whiteColor
                            : AppColors.blackColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Container(
            color: AppColors.whiteColor,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: CustomChatTextField(
                suffixOnPressed: sendMessage,
                controller: _chatController,
                hintText: "Ask any Question...",
                icon: Icon(
                  Icons.gesture_outlined,
                  size: 30,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

