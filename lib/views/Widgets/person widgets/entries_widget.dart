import 'package:flutter/material.dart';
import 'package:sanctuarai/controllers/entry_controller.dart';
import 'package:sanctuarai/views/Widgets/person%20widgets/all_entries_widget.dart';

class EntriesWidget extends StatefulWidget {
  const EntriesWidget({super.key, required this.pid});

  final String pid;

  @override
  State<EntriesWidget> createState() => _EntriesWidgetState();
}

class _EntriesWidgetState extends State<EntriesWidget> {
  String? valueItem;
  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
         AllEntriesWidget(pid: widget.pid),
        Align(
          alignment: Alignment.bottomLeft,
          child: Container(
            height: 70,
            color: Colors.orangeAccent,
            padding: EdgeInsets.only(left: 10, bottom: 10, top: 10),
            width: double.infinity,
            child: Row(
              children: [
                Expanded(
                  flex: 5,
                  child: TextField(
                    maxLength: 200,
                    controller: controller,
                    decoration: InputDecoration(hintText: "Write an Entry"),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: DropdownButtonFormField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      labelText: 'feeling',
                    ),
                    value: valueItem,
                    isExpanded: true,
                    items: [
                      DropdownMenuItem(value: 'sad', child: Text('1 😢')),
                      DropdownMenuItem(value: 'angry', child: Text('2 😠')),
                      DropdownMenuItem(value: 'neutral', child: Text('3 😐')),
                      DropdownMenuItem(value: 'happy', child: Text('4 😊')),
                      DropdownMenuItem(value: 'surprised', child: Text('5 😲')),
                    ],
                    onChanged: (String? value) {
                      setState(() {
                        valueItem = value;
                      });
                    },
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: IconButton(
                    onPressed: () async {
                      if (valueItem == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text("please add a feeling"),
                            backgroundColor: Colors.red,
                          ),
                        );
                      }
                      final error = await EntryController().createEntry(
                        text: controller.text,
                        pid: widget.pid,
                        feeling: valueItem!.toString(),
                      );
                      if (error != null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(error),
                            backgroundColor: Colors.red,
                          ),
                        );
                      } else if (error == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text("Entry added successfully"),
                            backgroundColor: Colors.green,
                          ),
                        );
                        setState(() {
                          controller.clear();
                          valueItem = null;
                        });
                      }
                    },
                    icon: Icon(Icons.send),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
