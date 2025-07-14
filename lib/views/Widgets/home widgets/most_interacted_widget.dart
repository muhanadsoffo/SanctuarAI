import 'package:flutter/material.dart';
import 'package:sanctuarai/services/auth_service.dart';
import 'package:sanctuarai/services/person_service.dart';

class MostInteractedWidget extends StatefulWidget {
  const MostInteractedWidget({super.key});

  @override
  State<MostInteractedWidget> createState() => _MostInteractedWidgetState();
}

class _MostInteractedWidgetState extends State<MostInteractedWidget> {
  List<Map<String, dynamic>> topPersons = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  Future<void> getData() async {
    final snapshot = await personService.value.getPersonsWithMostEntries(
      uid: authService.value.currentUser!.uid,
    );
    setState(() {
       topPersons = snapshot.docs.map((doc) => doc.data()).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 10),
          Text(
            "People you interact with the most:",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          Container(

            height: 150,
            child: ListView.separated(
              separatorBuilder: (context, index) => SizedBox(width: 12),
              scrollDirection: Axis.horizontal,
              itemCount: topPersons.isEmpty ? 3 : topPersons.length,
              itemBuilder: (context, index) {
                final person = topPersons[index];
                return Container(
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: Color(0xFFabc7d9)),
                  height: 150,
                  width: 130,
                  child: Column(

                    children: [
                      SizedBox(height: 10,),
                      CircleAvatar(radius: 40, backgroundColor: Colors.grey),
                      SizedBox(height: 10,),
                      Text(person['name'] ?? null,style: TextStyle(fontSize: 20),)
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
