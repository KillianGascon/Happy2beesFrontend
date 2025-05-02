import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:happytobees/pages/HomePage.dart';
import 'package:happytobees/providers/auth_provider.dart';
import 'package:provider/provider.dart';

void main() async {
  await dotenv.load(); // Load environment variables
  runApp(
    ChangeNotifierProvider(
      create: (context) => AuthProvider(),
      child: MyApp(),
    ),
  );
}


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}