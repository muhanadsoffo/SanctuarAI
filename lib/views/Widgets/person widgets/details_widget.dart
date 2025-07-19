import 'package:flutter/material.dart';
import 'package:sanctuarai/controllers/openai_controller.dart';
import 'package:sanctuarai/services/person_service.dart';

class DetailsWidget extends StatefulWidget {


  final dynamic person;

  const DetailsWidget({super.key,required this.person});


  @override

  State<DetailsWidget> createState() => _DetailsWidgetState();

}

class _DetailsWidgetState extends State<DetailsWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Gender:',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          Text(widget.person['gender'], style: TextStyle(fontSize: 18)),
          SizedBox(height: 20),
          Text(
            "Introduction",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          Text(widget.person['intro'], style: TextStyle(fontSize: 18)),
          SizedBox(height: 20),
          Divider(height: 1),
          Text(
            "Get more info about this person, send all Entries to the AI!",
            style: TextStyle(fontSize: 20),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () async{
              final String? error;
              if(widget.person['aiResponse.summary'] == null || widget.person['aiResponse.summary'].toString().trim().isEmpty){
                error = await OpenaiController().sendForFirstTime(pid: widget.person['pid']);
                if(error != null){
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(
                    SnackBar(
                      content: Text(error),
                      backgroundColor: Colors.red,
                    ),
                  );
                  setState(() {

                  });
                }

              }else if(widget.person['aiResponse.summary'] != null){
                error = await OpenaiController().followUp(pid: widget.person['pid']);
                if(error != null){
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(
                    SnackBar(
                      content: Text(error),
                      backgroundColor: Colors.red,
                    ),
                  );
                  setState(() {

                  });
                }
              }
            },
            style: ElevatedButton.styleFrom(
              minimumSize: Size(double.infinity, 60),
            ),
            child: Text("Get an analysis"),
          ),
          SizedBox(height: 20),
          Text("AI response:",style: TextStyle(fontSize: 20)),
          Text(widget.person['aiResponse.advice'],style: TextStyle(fontSize: 20),),

        ],
      ),
    );
  }
}
