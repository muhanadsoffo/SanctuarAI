import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sanctuarai/services/auth_service.dart';
import 'package:sanctuarai/services/person_service.dart';
import 'package:sanctuarai/views/Widgets/person%20widgets/flip_container_widget.dart';
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
        backgroundColor: Color(0xFFF1F6F9),
      appBar: AppBar(backgroundColor: Color(0xFFF1F6F9)),
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
              return FlipContainerWidget(data: data,);
            },
          );
        },
      ),
    );
  }
}
