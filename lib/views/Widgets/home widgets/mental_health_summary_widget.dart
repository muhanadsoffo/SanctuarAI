import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sanctuarai/controllers/openai_controller.dart';

import '../../../controllers/user_controller.dart';
import '../../../services/auth_service.dart';

class MentalHealthSummaryWidget extends StatefulWidget {
  const MentalHealthSummaryWidget({super.key});

  @override
  State<MentalHealthSummaryWidget> createState() =>
      _MentalHealthSummaryWidgetState();
}

class _MentalHealthSummaryWidgetState extends State<MentalHealthSummaryWidget> {
  String? _summary;
  bool _loading = false;
  String? _error;



  @override
  void initState() {
    super.initState();
    fetchSummary();
  }

  Future<void> fetchSummary() async {
    final uid = authService.value.currentUser!.uid;
    final userDoc =
    await FirebaseFirestore.instance.collection('users').doc(uid).get();
    setState(() {
      _summary = userDoc.data()?['aiSummary']?['summary'];
    });
  }

  Future<void> generateNewSummary() async {
    setState(() {
      _loading = true;
      _error = null;
    });

    final uid = authService.value.currentUser!.uid;
    final result = await OpenaiController().mentalSummary(uid: uid);

    if (mounted) {
      setState(() {
        _loading = false;
        if (result != null && result != "No updates since last report.") {
          _error = result;
        } else {
          fetchSummary(); // refresh from Firestore
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "Summary for all the interactions:",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            height: 250,
            width: double.infinity,
            child: Card(
              color: Color(0xFFc6fcf7),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: _loading
                    ? Center(child: CircularProgressIndicator())
                    : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        child: Text(
                          _summary ?? "There is no analysis yet!",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 12),
                    if (_error != null)
                      Text(
                        _error!,
                        style: TextStyle(color: Colors.red),
                      ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: ElevatedButton.icon(
                        onPressed: generateNewSummary,
                        icon: Icon(Icons.auto_graph),
                        label: Text("Generate Summary"),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFFf9f9fa),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
