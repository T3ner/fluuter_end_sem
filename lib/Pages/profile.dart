import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget{
  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage>{
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