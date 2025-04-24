import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:leaf_scan/core/args/chat_page_args.dart';
import 'package:leaf_scan/core/common/widgets/custom_snack_bar.dart';
import 'package:leaf_scan/init.main.dart';
import 'package:lottie/lottie.dart';
import 'package:http/http.dart' as http;

class UploadPage extends StatefulWidget {
  final File image;
  const UploadPage({super.key, required this.image});

  @override
  State<UploadPage> createState() => _UploadPageState();
}

class _UploadPageState extends State<UploadPage> {
  @override
  void initState() {
    _uploadImage();
    super.initState();
  }

  Future<void> _uploadImage() async {
    final uri = Uri.parse("http://192.168.217.128:9000/detect");
    final request = http.MultipartRequest("POST", uri);

    try {
      final userId = serviceLocator<Box<String>>().get("user_id")!;
      request.fields['user_id'] = userId;

      request.files.add(await http.MultipartFile.fromPath(
        'image',
        widget.image.path,
      ));

      final response = await request.send();
      final responseData = await response.stream.bytesToString();
      final Map<String, dynamic> jsonMap = json.decode(responseData);

      if (response.statusCode == 200) {
        navigateToChat(userId, jsonMap["chat_id"]);
      } else {
        print(responseData);
        ScaffoldMessenger.of(context).showSnackBar(
          CustomSnackBar(message: "Detection Failed").build(context),
        );
        Navigator.pop(context);
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        CustomSnackBar(message: "Detection Failed").build(context),
      );
      Navigator.pop(context);
    }
  }

  void navigateToChat(String userId, chatId) {
    Navigator.pushReplacementNamed(
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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            LottieBuilder.asset(
              "assets/Animation - 1739076505565.json",
              width: 200,
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "Scanning...",
              style: Theme.of(context).textTheme.titleMedium,
            )
          ],
        ),
      ),
    );
  }
}
