import 'package:flutter/material.dart';
import 'package:sanctuarai/controllers/openai_controller.dart';
import 'package:sanctuarai/services/person_service.dart';

class DetailsWidget extends StatefulWidget {
  final dynamic person;

  const DetailsWidget({super.key, required this.person});

  @override
  State<DetailsWidget> createState() => _DetailsWidgetState();
}

class _DetailsWidgetState extends State<DetailsWidget> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Gender:',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        widget.person['gender'],
                        style: TextStyle(fontSize: 18),
                      ),
                      SizedBox(height: 20),
                      Text(
                        "Introduction",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        widget.person['intro'],
                        style: TextStyle(fontSize: 18),
                      ),
                      SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ),

            Container(
              padding: EdgeInsets.all(12),
              margin: EdgeInsets.symmetric(vertical: 16),
              decoration: BoxDecoration(
                color: Colors.deepPurple.shade50,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Icon(Icons.psychology_alt, color: Colors.deepPurple),
                  SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      "Generate personalized advice by analyzing your entries with this person.",
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            Container(
              width: double.infinity,
              height: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                gradient: LinearGradient(
                  colors: [Colors.deepPurple, Colors.indigo],
                ),
              ),
              child: MaterialButton(
                onPressed: () async {
                  final String? error;
                  if (widget.person['aiResponse.summary'] == null ||
                      widget.person['aiResponse.summary']
                          .toString()
                          .trim()
                          .isEmpty) {
                    error = await OpenaiController().sendForFirstTime(
                      pid: widget.person['pid'],
                    );
                    if (error != null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(error),
                          backgroundColor: Colors.red,
                        ),
                      );
                      setState(() {});
                    }
                  } else if (widget.person['aiResponse.summary'] != null) {
                    error = await OpenaiController().followUp(
                      pid: widget.person['pid'],
                    );
                    if (error != null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(error),
                          backgroundColor: Colors.red,
                        ),
                      );
                      setState(() {});
                    }
                  }
                },

                child: Text(
                  "Get an analysis!",
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
            ),
            SizedBox(height: 20),

            Text("AI response:", style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Container(
              width: double.infinity,

              child: Card(

                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.person['aiResponse.advice'] ??
                            "",
                        style: TextStyle(
                          fontSize: 20,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
