import 'package:flutter/material.dart';
import 'package:sanctuarai/services/auth_service.dart';
import 'package:sanctuarai/services/user_service.dart';

class BioWidget extends StatefulWidget {
  const BioWidget({super.key});

  @override
  State<BioWidget> createState() => _BioWidgetState();
}

class _BioWidgetState extends State<BioWidget> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(future: userService.value.getUserdata(authService.value.currentUser!.uid), builder: (context, snapshot) {
      if(snapshot.connectionState == ConnectionState.waiting){
        return CircularProgressIndicator();
      } if (snapshot.hasError) {
        return Text("Error loading bio");
      }

      if (!snapshot.hasData || !snapshot.data!.exists) {
        return Text("User data not found");
      }
      final data = snapshot.data!.data() as Map<String,dynamic>;
      final bio = data['bio'] ?? " no bio yet";
      return Padding(
        padding: const EdgeInsets.only(left: 12.0,right: 12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(children: [
              Text(
                "Bio",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
              ),
              IconButton(onPressed: () {
                
              }, icon: Icon(Icons.edit))
            ],),
            
            Container(
              height : 150,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.white10,
              ),
              child: Text(bio),
            ),
          ],
        ),
      );
    },);


  }
}
