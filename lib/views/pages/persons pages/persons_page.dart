import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sanctuarai/services/auth_service.dart';
import 'package:sanctuarai/services/person_service.dart';
import 'package:sanctuarai/views/pages/persons%20pages/person_details.dart';

class PersonsPage extends StatefulWidget {
  const PersonsPage({super.key});

  @override
  State<PersonsPage> createState() => _PersonsPageState();
}

class _PersonsPageState extends State<PersonsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Color(0xFF457b9d)),
      body: FutureBuilder<QuerySnapshot<Map<String, dynamic>>>(
        future: personService.value.getAllPersons(
          authService.value.currentUser!.uid,
        ),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('there is an error ${snapshot.error}'));
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(
              child: Text("You have no one you LONELY BITCH"),
            );
          }
          final persons = snapshot.data!.docs;
          return GridView.builder(
            padding: const EdgeInsets.all(8.0),
            itemCount: persons.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 1,
              childAspectRatio: 1.6,

              mainAxisSpacing: 30,
            ),
            itemBuilder: (context, index) {
              final data = persons[index].data();
              return GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return PersonDetails();
                  },));
                },
                child: Container(

                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(color: Colors.white.withOpacity(0.6),borderRadius: BorderRadius.circular(8),boxShadow: [
                    BoxShadow(color: Colors.grey.withOpacity(0.9), blurRadius: 8,spreadRadius: 0.8)
                  ]),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,

                    children: [
                      Row(
                        children: [
                          CircleAvatar(backgroundColor: Colors.grey, radius: 60),
                          SizedBox(width: 30),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,

                              children: [
                                SizedBox(height: 7),
                                Text(
                                  'Name: ${data['name']}',
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 7),
                                Text(
                                  'Gender: ${data['gender']}',
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 7),

                              ],
                            ),
                          ),

                        ],
                      ),
                      SizedBox(height: 7,),
                      Text(
                        'Introduction:\n ${data['intro']}',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],

                  ),

                ),
              );
            },
          );
        },
      ),
    );
  }
}
