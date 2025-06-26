import 'package:flutter/material.dart';
import 'package:sanctuarai/controllers/auth_controller.dart';
import 'package:sanctuarai/services/auth_service.dart';
import 'package:sanctuarai/views/pages/persons%20pages/persons_page.dart';
import 'package:sanctuarai/views/pages/profile%20pages/profile_page.dart';

class AppbarWidget extends StatelessWidget  {
  const AppbarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          flexibleSpace: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(4),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      CircleAvatar(radius: 35),
                      Text("Hey there", style: TextStyle(fontSize: 18)),
                    ],
                  ),
                  Row(
                    children: [
                      IconButton(onPressed: () {}, icon: Icon(Icons.logout)),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),

        SliverAppBar(
          expandedHeight: 250,
          flexibleSpace: FlexibleSpaceBar(
            background: Row(
              children: [IconButton(onPressed: () {}, icon: Icon(Icons.add))],
            ),
          ),
        ),
      ],
    );
  }


}
