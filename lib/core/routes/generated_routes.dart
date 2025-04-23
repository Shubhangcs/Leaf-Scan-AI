import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:leaf_scan/features/authentication/cubit/login_cubit.dart';
import 'package:leaf_scan/features/authentication/cubit/register_cubit.dart';
import 'package:leaf_scan/features/authentication/pages/login_page.dart';
import 'package:leaf_scan/features/authentication/pages/register_page.dart';
import 'package:leaf_scan/features/chat/pages/chat_page.dart';
import 'package:leaf_scan/features/entry_screens/pages/entry_page.dart';
import 'package:leaf_scan/features/home/pages/home_page.dart';

class Routes {
  static Route? onGenerate(RouteSettings settings) {
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
        return MaterialPageRoute(
          builder: (context) => ChatPage(),
        );
      default:
        return MaterialPageRoute(
          builder: (context) => Scaffold(),
        );
    }
  }
}
