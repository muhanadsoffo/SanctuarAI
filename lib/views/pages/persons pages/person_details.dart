import 'package:flutter/material.dart';
import 'package:sanctuarai/services/person_service.dart';

class PersonDetails extends StatefulWidget {
  const PersonDetails({super.key, required this.pid});

  final String pid;

  @override
  State<PersonDetails> createState() => _PersonDetailsState();
}

class _PersonDetailsState extends State<PersonDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: FutureBuilder(
        future: personService.value.getPersonDetails(widget.pid),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('there is an error ${snapshot.error}'));
          }
          final person = snapshot.data!;
          return Column(children: [Center(child: Text(person['name']))]);
        },
      ),
    );
  }
}
