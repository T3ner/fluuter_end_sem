import 'package:flutter/material.dart';
import 'package:flutter_end_sem/Pages/home_page.dart';
import 'package:flutter_end_sem/Pages/profile.dart';
import 'package:flutter_end_sem/dbConn.dart';
import 'package:flutter_end_sem/Pages/signup_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'firebase_options.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      title: 'Flutter Demo',
        theme:  ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: ProfilePage()
    );
  }
}