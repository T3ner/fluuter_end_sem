import 'package:flutter/material.dart';

class VerifierPage extends StatefulWidget{
  @override
  State<VerifierPage> createState() => _VerifierPageState();
}

class _VerifierPageState extends State<VerifierPage>{
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      home: DefaultTabController(length: 3, 
      child: Scaffold(
        appBar: AppBar(
          title: Text('News Checker'),
          backgroundColor: Colors.red,
          bottom: const TabBar(
            tabs: [
              Tab(icon: Icon(Icons.person, color: Colors.black87)),
              Tab(icon: Icon(Icons.home, color: Colors.black87)),
              Tab(icon: Icon(Icons.search, color: Colors.black87))
            ]),
        ),
        )
      ),
    );
  }
}