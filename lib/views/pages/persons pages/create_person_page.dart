import 'package:flutter/material.dart';

class CreatePersonPage extends StatefulWidget {
  const CreatePersonPage({super.key});

  @override
  State<CreatePersonPage> createState() => _CreatePersonPageState();
}

class _CreatePersonPageState extends State<CreatePersonPage> {
  String? menuItem;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [

            CircleAvatar(radius: 75, backgroundColor: Colors.grey),
            SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  flex: 3,
                  child: TextField(
                    decoration: InputDecoration(
                      border:UnderlineInputBorder(),
                      hintText: 'Enter their name',
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  flex: 2,
                  child: DropdownButton<String>(
                    hint: Text("Select gender"),
                    isExpanded: true,
                    value: menuItem,
                    items: [
                      DropdownMenuItem(value: 'male', child: Text("Male")),
                      DropdownMenuItem(value: 'female', child: Text("Female")),
                    ],
                    onChanged: (value) {
                      setState(() {
                        menuItem = value;
                      });
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            TextField(
              maxLines: 3,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                hintText:
                    'Enter a brief introduction about them, for example: they are a close friend, a cousin or a coworker',
              ),
            ),
            SizedBox(height: 20),


          ],
        ),
      ),
    );
  }
}
