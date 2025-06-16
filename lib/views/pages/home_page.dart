import 'package:flutter/material.dart';
import 'package:sanctuarai/views/Widgets/navbar_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text("Hey there", style: TextStyle(fontSize: 30)),


      ],
    );

  }
}
