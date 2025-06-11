import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:sanctuarai/views/auth_layout.dart';
import 'package:sanctuarai/views/pages/auth%20pages/welcome_page.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();

}


class _MyAppState extends State<MyApp> {

  @override
  Widget build(BuildContext context) {


    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightBlueAccent)),
      home: AuthLayout(),
    );
  }
}
