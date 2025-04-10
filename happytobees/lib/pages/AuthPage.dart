import 'package:flutter/material.dart';
import '../widgets/auth/LoginWidget.dart';
import '../widgets/auth/SignupWidget.dart';

class AuthPage extends StatefulWidget {
  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        onPageChanged: (int page) {
          setState(() {
            _currentPage = page;
          });
        },
        children: [
          LoginWidget(
            pageController: _pageController,
            onPageChanged: (page) => setState(() => _currentPage = page),
          ),
          SignUpWidget(
            pageController: _pageController,
            onPageChanged: (page) => setState(() => _currentPage = page), currentPage: _currentPage,
          ),
        ],
      ),
    );
  }
}