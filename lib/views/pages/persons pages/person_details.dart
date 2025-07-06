import 'package:flutter/material.dart';
import 'package:sanctuarai/services/person_service.dart';
import 'package:sanctuarai/views/Widgets/person%20widgets/details_widget.dart';
import 'package:sanctuarai/views/Widgets/person%20widgets/entries_widget.dart';

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
    return DefaultTabController(
      length: 2,
      child: Scaffold(
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
                  backgroundColor: Color(0xFF65BBC8),

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
                    titlePadding: EdgeInsets.symmetric(
                      horizontal: 4,
                      vertical: 4,
                    ),
                    title: Text(
                      person['name'],
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    centerTitle: true,
                  ),
                  pinned: true,
                  floating: true,
                ),

                SliverAppBar(
                  automaticallyImplyLeading: false,

                  backgroundColor: Color(0xFF65BBC8),
                  pinned: true,
                  toolbarHeight: 5,
                  bottom: PreferredSize(
                    preferredSize: Size.fromHeight(31),
                    child: Container(
                      height: 36,
                      child: const TabBar(
                        tabs: [
                          Tab(
                            child: Text(
                              "Details",
                              style: TextStyle(fontSize: 18),
                            ),
                          ),
                          Tab(
                            child: Text(
                              "Entries",
                              style: TextStyle(fontSize: 18),
                            ),
                          ),
                        ],
                        labelColor: Colors.black,
                        unselectedLabelColor: Colors.white,
                        indicatorColor: Colors.white,
                      ),
                    ),
                  ),
                ),
                SliverFillRemaining(
                  child: TabBarView(
                    children: [
                      DetailsWidget(
                        gender: person['gender'],
                        intro: person['intro'],
                      ),
                      EntriesWidget(pid: person['pid']),
                    ],
                  ),

                ),
              ],

            );
          },
        ),
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
