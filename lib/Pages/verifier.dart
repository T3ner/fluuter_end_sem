import 'package:flutter/material.dart';
import 'package:flutter_end_sem/Pages/home_page.dart';
import 'package:flutter_end_sem/Pages/profile.dart';

class VerifierPage extends StatefulWidget {
  @override
  State<VerifierPage> createState() => _VerifierPageState();
}

class _VerifierPageState extends State<VerifierPage> {
  int _currentIndex = 2; 

  final List<Widget> _pages = [
    ProfilePage(), 
    HomePage(),    
    const Center(child: Text("Search / Verify Logic Here")), 
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
    );
  }
}