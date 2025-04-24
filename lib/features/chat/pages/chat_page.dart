import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:leaf_scan/core/common/widgets/custom_app_bar.dart';
import 'package:leaf_scan/core/common/widgets/custom_chat_text_field.dart';
import 'package:leaf_scan/core/themes/app_colors.dart';
import 'package:leaf_scan/features/chat/services/chat_services.dart';
import 'package:leaf_scan/features/chat/models/message_model.dart';

class ChatPage extends StatefulWidget {
  final String userId;
  final String chatId;
  const ChatPage({
    super.key,
    required this.userId,
    required this.chatId,
  });

  @override
  State<ChatPage> createState() => _ChatPageState();
}

// class _ChatPageState extends State<ChatPage> {
//   late TextEditingController _chatController;
//   final ChatService _chatService = ChatService();
//   bool _isSending = false;

//   @override
//   void initState() {
//     _chatController = TextEditingController();
//     super.initState();
//   }

//   @override
//   void dispose() {
//     _chatController.dispose();
//     super.dispose();
//   }

//   void sendMessage() async {
//     final text = _chatController.text.trim();
//     if (text.isEmpty || _isSending) return;

//     setState(() => _isSending = true);
//     _chatController.clear();

//     // 1. Save user message
//     await _chatService.sendMessage(chatId: widget.chatId, message: text);

//     try {
//       // 2. Call AI API (it will handle storing response in Firestore)
//       final statusCode =
//           await _chatService.callLlamaAPI(prompt: text, chatId: widget.chatId);

//       // 3. If error, add a response to Firestore manually
//       if (statusCode != 200) {
//         await _chatService.sendBotMessage(
//           chatId: widget.chatId,
//           message: "AI could not respond. Try again later.",
//         );
//       }
//     } catch (e) {
//       await _chatService.sendBotMessage(
//         chatId: widget.chatId,
//         message: "Something went wrong!",
//       );
//     } finally {
//       setState(() => _isSending = false);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: CustomAppBar.build(),
//       body: Column(
//         children: [
//           Expanded(
//             child: StreamBuilder<List<MessageModel>>(
//               stream: _chatService.getMessages(widget.chatId),
//               builder: (context, snapshot) {
//                 if (snapshot.connectionState == ConnectionState.waiting) {
//                   return Center(child: CircularProgressIndicator());
//                 }

//                 final messages = snapshot.data ?? [];

//                 return ListView.builder(
//                   padding: EdgeInsets.all(10),
//                   itemCount: messages.length,
//                   itemBuilder: (context, index) {
//                     final msg = messages[index];
//                     return Align(
//                       alignment: msg.userType == "USER"
//                           ? Alignment.centerRight
//                           : Alignment.centerLeft,
//                       child: Container(
//                         margin: EdgeInsets.symmetric(vertical: 10),
//                         padding: EdgeInsets.all(12),
//                         decoration: BoxDecoration(
//                           color: msg.userType == "USER"
//                               ? AppColors.greenColor
//                               : Colors.grey.shade100,
//                           borderRadius: BorderRadius.circular(12),
//                         ),
//                         child: Text(
//                           msg.message,
//                           style: GoogleFonts.workSans(
//                             color: msg.userType == "USER"
//                                 ? AppColors.whiteColor
//                                 : AppColors.blackColor,
//                             fontSize: 16,
//                           ),
//                         ),
//                       ),
//                     );
//                   },
//                 );
//               },
//             ),
//           ),
//           if (_isSending)
//             Padding(
//               padding: const EdgeInsets.only(bottom: 10),
//               child: Text(
//                 "Thinking...",
//                 style: GoogleFonts.workSans(
//                   fontStyle: FontStyle.italic,
//                   color: Colors.grey,
//                 ),
//               ),
//             ),
//           Container(
//             color: AppColors.whiteColor,
//             child: Padding(
//               padding: const EdgeInsets.all(20),
//               child: CustomChatTextField(
//                 suffixOnPressed: _isSending ? null : sendMessage,
//                 controller: _chatController,
//                 hintText: "Ask any Question...",
//                 icon: Icon(Icons.gesture_outlined, size: 30),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

class _ChatPageState extends State<ChatPage> {
  late TextEditingController _chatController;
  late FocusNode _focusNode;
  final ChatService _chatService = ChatService();
  bool _isSending = false;
  

  @override
  void initState() {
    _chatController = TextEditingController();
    _focusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    _chatController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void sendMessage() async {
    final text = _chatController.text.trim();
    if (text.isEmpty || _isSending) return;

    setState(() => _isSending = true);
    _chatController.clear();
    _focusNode.unfocus();

    await _chatService.sendMessage(chatId: widget.chatId, message: text);

    try {
      final statusCode =
          await _chatService.callLlamaAPI(prompt: text, chatId: widget.chatId);

      if (statusCode != 200) {
        await _chatService.sendBotMessage(
          chatId: widget.chatId,
          message: "AI could not respond. Try again later.",
        );
      }
    } catch (e) {
      await _chatService.sendBotMessage(
        chatId: widget.chatId,
        message: "Something went wrong!",
      );
    } finally {
      setState(() => _isSending = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar.build(),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<List<MessageModel>>(
              stream: _chatService.getMessages(widget.chatId),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }

                final messages = snapshot.data ?? [];

                return ListView.builder(
                  padding: EdgeInsets.all(10),
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    final msg = messages[index];
                    return Align(
                      alignment: msg.userType == "USER"
                          ? Alignment.centerRight
                          : Alignment.centerLeft,
                      child: Container(
                        margin: EdgeInsets.symmetric(vertical: 10),
                        padding: EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: msg.userType == "USER"
                              ? AppColors.greenColor
                              : Colors.grey.shade100,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          msg.message,
                          style: GoogleFonts.workSans(
                            color: msg.userType == "USER"
                                ? AppColors.whiteColor
                                : AppColors.blackColor,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
          if (_isSending)
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Text(
                "Thinking...",
                style: GoogleFonts.workSans(
                  fontStyle: FontStyle.italic,
                  color: Colors.grey,
                ),
              ),
            ),
          Container(
            color: AppColors.whiteColor,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: CustomChatTextField(
                suffixOnPressed: _isSending ? null : sendMessage,
                controller: _chatController,
                focusNode: _focusNode,
                hintText: "Ask any Question...",
                icon: Icon(Icons.gesture_outlined, size: 30),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

