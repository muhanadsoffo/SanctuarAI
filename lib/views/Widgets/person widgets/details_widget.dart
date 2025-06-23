import 'package:flutter/material.dart';

class DetailsWidget extends StatelessWidget {
  final String gender;

  final String intro;

  const DetailsWidget({super.key, required this.gender, required this.intro});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Gender:',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          Text(gender, style: TextStyle(fontSize: 18)),
          SizedBox(height: 20),
          Text(
            "Introduction",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          Text(intro, style: TextStyle(fontSize: 18))
        ],
      ),
    );
  }
}
