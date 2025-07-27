import 'package:flutter/material.dart';

class MentalHealthSummaryWidget extends StatefulWidget {
  const MentalHealthSummaryWidget({super.key});

  @override
  State<MentalHealthSummaryWidget> createState() =>
      _MentalHealthSummaryWidgetState();
}

class _MentalHealthSummaryWidgetState extends State<MentalHealthSummaryWidget> {
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
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Text(
                      "There is no analyse yet!",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
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
