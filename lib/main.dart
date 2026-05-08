import 'package:flutter/material.dart';
import 'theme/app_theme.dart';
import 'pages/home_page.dart';

void main() {
  runApp(const AiLazyHelperApp());
}

class AiLazyHelperApp extends StatelessWidget {
  const AiLazyHelperApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AI摆烂助手',
      theme: AppTheme.theme,
      home: const HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
