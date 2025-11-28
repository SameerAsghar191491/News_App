import 'package:flutter/material.dart';
import 'package:news_app/Screens/newsHeadlinesScreen.dart';
import 'package:news_app/State_Management/provider_helper.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => ProviderHelper(),
      child: MainApp(),
    ),
  );
    
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: newsHeadlinesScreen(),
    );
  }
}
