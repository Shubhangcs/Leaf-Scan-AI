import 'package:flutter/material.dart';
import 'package:leaf_scan/core/routes/generated_routes.dart';
import 'package:leaf_scan/core/themes/app_theme.dart';
import 'package:leaf_scan/init.main.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependencies();
  runApp(const LeafScan());
}

class LeafScan extends StatelessWidget {
  const LeafScan({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Leaf Scan",
      theme: AppTheme.applicationTheme,
      darkTheme: AppTheme.applicationTheme,
      onGenerateRoute: Routes.onGenerate,
      initialRoute: "/login",
    );
  }
}
