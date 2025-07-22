import 'package:flutter/material.dart';
import 'package:sanctuarai/views/Widgets/appbar_widget.dart';
import 'package:sanctuarai/views/Widgets/home%20widgets/most_interacted_widget.dart';
import 'package:sanctuarai/views/Widgets/home%20widgets/sliders_widget.dart';
import 'package:sanctuarai/views/Widgets/navbar_widget.dart';
import 'package:sanctuarai/views/pages/persons%20pages/create_person_page.dart';
import 'package:sanctuarai/views/pages/persons%20pages/persons_page.dart';
import 'package:sanctuarai/views/pages/profile%20pages/profile_page.dart';

import '../../controllers/auth_controller.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          backgroundColor: Color(0xFF4DCFED),
          floating: true,
          flexibleSpace: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(4),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return ProfilePage();
                          },
                        ),
                      );
                    },
                    child: Row(
                      children: [
                        CircleAvatar(radius: 35),
                        Text("Hey there", style: TextStyle(fontSize: 18)),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      IconButton(
                        onPressed: () async {
                          final error =
                              await AuthController.authController.logout();
                          if (error != null) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(error),
                                backgroundColor: Colors.red,
                              ),
                            );
                          }
                        },
                        icon: Icon(Icons.logout),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),

        SliverAppBar(
          floating: true,
          expandedHeight: 150,
          toolbarHeight: 150,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
          ),
          backgroundColor: Color(0xFF4DCFED),
          flexibleSpace: FlexibleSpaceBar(
            background: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Get Started",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.white,
                            radius: 30,
                            child: IconButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return CreatePersonPage();
                                    },
                                  ),
                                );
                              },
                              icon: Icon(Icons.add),
                            ),
                          ),
                          SizedBox(height: 8),
                          Text("Add someone"),
                        ],
                      ),
                      Column(
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.white,
                            radius: 30,
                            child: IconButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return PersonsPage();
                                    },
                                  ),
                                );
                              },
                              icon: Icon(Icons.person),
                            ),
                          ),
                          SizedBox(height: 8),
                          Text("People list"),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: SlidersWidget(),
          ),
        ),

        SliverToBoxAdapter(child: MostInteractedWidget(),),
        SliverFillRemaining()
      ],
    );
  }
}
