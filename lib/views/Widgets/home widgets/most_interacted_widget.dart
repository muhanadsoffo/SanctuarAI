import 'package:flutter/material.dart';

class MostInteractedWidget extends StatefulWidget {
  const MostInteractedWidget({super.key});

  @override
  State<MostInteractedWidget> createState() => _MostInteractedWidgetState();
}

class _MostInteractedWidgetState extends State<MostInteractedWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 10,),
          Text(
            "People you interact with the most:",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
