import 'package:flutter/material.dart';
import 'package:sanctuarai/services/person_service.dart';

class PersonDetails extends StatefulWidget {
  const PersonDetails({super.key, required this.pid});

  final String pid;

  @override
  State<PersonDetails> createState() => _PersonDetailsState();
}

class _PersonDetailsState extends State<PersonDetails> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF457b9d),
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
          return CustomScrollView(
            slivers: [
              SliverAppBar(
                expandedHeight: 200,
                backgroundColor: Color(0xFF457b9d),
                flexibleSpace: FlexibleSpaceBar(

                  background: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: CircleAvatar(
                        backgroundColor: Colors.grey,
                        radius: 70,
                      ),
                    ),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    buildButton("Details", 0),
                    buildButton("Entries", 1),
                  ],
                ),
              ),
              SliverFillRemaining(
                hasScrollBody: true,
                child:  Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(30),
                    ),
                  ),
                  child: IndexedStack(index: selectedIndex,children: [],),
                ),

              )
            ],
          );
        },
      ),
    );
  }

  Widget buildButton(String label, int index) {
    final bool isSelected = selectedIndex == index;
    return TextButton(
      onPressed: () {
        setState(() => selectedIndex = index);
      },
      style: TextButton.styleFrom(
        backgroundColor: isSelected ? Colors.white : Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        foregroundColor: isSelected ? Colors.green.shade700 : Colors.white,
        elevation: 0,
      ),
      child: Text(
        label,
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
    );
  }
}
