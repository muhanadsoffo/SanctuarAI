import 'package:flutter/material.dart';
import 'package:sanctuarai/services/auth_service.dart';
import 'package:sanctuarai/services/person_service.dart';

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
          SizedBox(height: 10),
          Text(
            "People you interact with the most:",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          StreamBuilder(
            stream: personService.value.getPersonsWithMostEntries(
              uid: authService.value.currentUser!.uid,
            ),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return CircularProgressIndicator();
              }
              final topPersons = snapshot.data!.docs;
              if (topPersons.isEmpty) {
                return emptyList();
              }
              return Container(
                height: 200,
                child: ListView.separated(
                  separatorBuilder: (context, index) => SizedBox(width: 12),
                  scrollDirection: Axis.horizontal,
                  itemCount: topPersons.length,
                  itemBuilder: (context, index) {
                    final person = topPersons[index];
                    return Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),

                      ),
                      height: 160,
                      width: 145,
                      child: Card(
                         shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 4,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [

                            CircleAvatar(
                              radius: 50,
                              backgroundColor: Colors.grey,
                              backgroundImage: NetworkImage(person['personPicture']),
                            ),

                            Text(
                              person['name'] ?? null,
                              style: TextStyle(fontSize: 20),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget emptyList() {
    return Container(
      height: 150,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemBuilder: (_, index) {
          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Color(0xFFabc7d9),
            ),
            height: 150,
            width: 130,
            child: Column(
              children: [
                SizedBox(height: 10),
                CircleAvatar(radius: 40, backgroundColor: Colors.grey),
                SizedBox(height: 10),
                Text("Add a Person", style: TextStyle(fontSize: 20)),
              ],
            ),
          );
        },
        separatorBuilder: (_, _) => SizedBox(width: 12),
        itemCount: 3,
      ),
    );
  }
}
