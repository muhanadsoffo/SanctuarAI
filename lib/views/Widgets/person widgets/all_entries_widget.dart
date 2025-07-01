import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sanctuarai/services/auth_service.dart';
import 'package:sanctuarai/services/entries_service.dart';

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
      stream: entryService.value.getAllEntries(uid: authService.value.currentUser!.uid, pid: widget.pid),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(child: Text("No Entries yet"));
        }
        final entries = snapshot.data!.docs;
        return ListView.builder(
          itemCount: entries.length,
          padding: EdgeInsets.all(10),
          reverse: true,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            final data = entries[index].data();
            return ListTile(shape:OutlineInputBorder(borderRadius: BorderRadius.circular(10)),title: Text(data['text']),subtitle: Text(data['feeling']),);
          },
        );
      },
    );
  }
}
