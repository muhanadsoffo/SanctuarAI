import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sanctuarai/services/auth_service.dart';
import 'package:sanctuarai/services/entries_service.dart';
import 'package:sanctuarai/views/pages/profile%20pages/profile_page.dart';

class AllEntriesWidget extends StatefulWidget {
  final String pid;

  const AllEntriesWidget({super.key, required this.pid});

  @override
  State<AllEntriesWidget> createState() => _AllEntriesWidgetState();
}

class _AllEntriesWidgetState extends State<AllEntriesWidget> {

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
      stream: entryService.value.getAllEntries(
        uid: authService.value.currentUser!.uid,
        pid: widget.pid,
      ),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(child: Text("No Entries yet"));
        }
        final entries = snapshot.data!.docs;
        return Padding(
          padding: const EdgeInsets.only(bottom: 80),
          child: ListView.builder(
            itemCount: entries.length,
            padding: EdgeInsets.all(10),
            reverse: true,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              final data = entries[index].data();
              DateTime date = (data['date'] as Timestamp).toDate();
              String formattedDate = "${date.month}/${date.day}/${date.year}";
              return InkWell(radius: 50,
                onLongPress: ()  {
                  showDialog(context: context, builder: (context) {
                    return AlertDialog(title: Text("Delete this Entry?"),
                      actions: [
                        TextButton(onPressed: () => Navigator.pop(context),
                            child: Text("Cancel")),
                        ElevatedButton(onPressed: () async{
                          await entryService.value.deleteEntry(
                              uid: authService.value.currentUser!.uid,
                              pid: widget.pid,
                              eid: data['eid']);
                          Navigator.pop(context);
                        }, child: Text("Delete"))
                      ],);
                  },);


                },
                child: Container(

                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.yellowAccent,
                  ),
                  padding: EdgeInsets.all(12),
                  margin: EdgeInsets.all(4),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [Text(data['text'], style: TextStyle(
                        fontSize: 20)),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(data['feeling']),
                          Text(formattedDate),
                        ],
                      )
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
