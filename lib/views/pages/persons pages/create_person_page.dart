import 'package:flutter/material.dart';
import 'package:sanctuarai/controllers/person_controller.dart';

class CreatePersonPage extends StatefulWidget {
  const CreatePersonPage({super.key});

  @override
  State<CreatePersonPage> createState() => _CreatePersonPageState();
}

class _CreatePersonPageState extends State<CreatePersonPage> {
  final nameController = TextEditingController();
  final introController = TextEditingController();
  String? menuItem;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
backgroundColor: Color(0xFFF1F6F9),
      appBar: AppBar(title: Text("New Person"),backgroundColor: Color(0xFFF1F6F9),),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.symmetric(vertical: 16, horizontal: 8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: Colors.white60,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 5,
                      spreadRadius: 5,
                      offset: Offset(0, 0),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: CircleAvatar(
                          radius: 75,
                          backgroundColor: Colors.grey,
                          child: Icon(
                            Icons.person,
                            size: 60,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      SizedBox(height: 24),
                      Row(
                        children: [
                          Expanded(
                            flex: 3,
                            child: TextField(
                              controller: nameController,
                              maxLength: 25,
                              decoration: InputDecoration(
                                labelStyle: TextStyle(
                                  fontWeight: FontWeight.w600,
                                ),
                                counterText: '',
                                border: UnderlineInputBorder(),
                                hintText: 'Name',
                              ),
                            ),
                          ),
                          SizedBox(width: 12),
                          Expanded(
                            flex: 2,
                            child: DropdownButtonFormField<String>(
                              isExpanded: true,
                              value: menuItem,
                              decoration: InputDecoration(
                                labelText: "Gender",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              items: [
                                DropdownMenuItem(
                                  value: 'male',
                                  child: Text("Male"),
                                ),
                                DropdownMenuItem(
                                  value: 'female',
                                  child: Text("Female"),
                                ),
                              ],
                              onChanged: (value) {
                                setState(() {
                                  menuItem = value;
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 24),
                      Text(
                        "Enter brief introduction:",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(height: 8),
                      TextField(
                        controller: introController,
                        maxLines: 4,
                        maxLength: 80,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          hintText: 'Who are they? A friend, coworker, etc.',
                          fillColor: Colors.grey.shade50,
                          filled: true,
                        ),
                      ),
                      SizedBox(height: 16),
                      Align(
                        alignment: Alignment.center,
                        child: ElevatedButton.icon(
                          onPressed: () async {
                            if(menuItem ==null){
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text("please fill all the information"),backgroundColor: Colors.red,),
                              );
                              return;
                            }
                            String? error = await PersonController
                                .personController.createPerson(
                                name: nameController.text,
                                gender: menuItem.toString(),
                                intro: introController.text);
                            if(error !=null){
                              ScaffoldMessenger.of(
                                context,
                              ).showSnackBar(
                                SnackBar(
                                  content: Text(error),
                                  backgroundColor: Colors.red,
                                ),
                              );
                            }else{
                              ScaffoldMessenger.of(
                                context,
                              ).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    "Person created successfully",
                                  ),
                                  backgroundColor: Colors.green,
                                ),
                              );
                              Navigator.pop(context);
                            }
                          },
                          icon: Icon(Icons.person_add, color: Colors.white,
                              size: 25),
                          label: Text(
                            "Add person",
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFF457b9d),
                            minimumSize: Size(double.infinity, 50),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
