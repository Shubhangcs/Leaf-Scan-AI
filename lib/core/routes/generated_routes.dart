import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:leaf_scan/core/args/chat_page_args.dart';
import 'package:leaf_scan/core/args/upload_page_args.dart';
import 'package:leaf_scan/features/authentication/cubit/login_cubit.dart';
import 'package:leaf_scan/features/authentication/cubit/register_cubit.dart';
import 'package:leaf_scan/features/authentication/pages/login_page.dart';
import 'package:leaf_scan/features/authentication/pages/register_page.dart';
import 'package:leaf_scan/features/chat/pages/chat_page.dart';
import 'package:leaf_scan/features/chat/pages/history_page.dart';
import 'package:leaf_scan/features/entry_screens/pages/entry_page.dart';
import 'package:leaf_scan/features/home/pages/home_page.dart';
import 'package:leaf_scan/features/home/pages/uploading_page.dart';

class Routes {
  static Route? onGenerate(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case "/entry":
        return MaterialPageRoute(
          builder: (context) => EntryPage(),
        );
      case "/login":
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => LoginCubit(),
            child: LoginPage(),
          ),
        );
      case "/register":
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => RegisterCubit(),
            child: RegisterPage(),
          ),
        );
      case "/home":
        return MaterialPageRoute(
          builder: (context) => HomePage(),
        );
      case "/chat":
        if (args is ChatPageArgs) {
          return MaterialPageRoute(
            builder: (context) => ChatPage(
              userId: args.userId,
              chatId: args.chatId,
            ),
          );
        }
      case "/chat_history_page":
        return MaterialPageRoute(
          builder: (context) => ChatHistoryPage(),
        );
      case "/upload_page":
        if (args is UploadPageArgs) {
          return MaterialPageRoute(
            builder: (context) => UploadPage(
              image: args.image,
            ),
          );
        }
      default:
        return MaterialPageRoute(
          builder: (context) => Scaffold(),
        );
    }
    return null;
  }
}
