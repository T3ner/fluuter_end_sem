import 'package:flutter/material.dart';
import 'package:flutter_end_sem/Pages/home_page.dart';
import 'package:flutter_end_sem/Pages/verifier.dart';

class ProfilePage extends StatefulWidget {
  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  int _currentIndex = 0;
  final List<Widget> _pages = [
    const Center(child: Text("Profile Content")), 
    HomePage(),
    VerifierPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
    );
  }
}