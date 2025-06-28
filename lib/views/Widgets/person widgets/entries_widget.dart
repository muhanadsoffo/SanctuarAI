import 'package:flutter/material.dart';

class EntriesWidget extends StatelessWidget {
  const EntriesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Align(
          alignment: Alignment.bottomLeft,
          child: Container(
            height: 70,
            color: Colors.white12,
            padding: EdgeInsets.only(left: 10, bottom: 10, top: 10),
            width: double.infinity,
            child: Row(
              children: [
                Expanded(
                  flex: 3,
                  child: TextField(
                    decoration: InputDecoration(hintText: "Write an Entry"),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: IconButton(onPressed: () {}, icon: Icon(Icons.send)),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
