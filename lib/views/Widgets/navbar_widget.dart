import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:sanctuarai/views/pages/persons%20pages/create_person_page.dart';

class NavbarWidget extends StatefulWidget {
  const NavbarWidget({super.key});

  @override
  State<NavbarWidget> createState() => _NavbarWidgetState();
}

class _NavbarWidgetState extends State<NavbarWidget> {
  @override
  Widget build(BuildContext context) {
    return ConvexAppBar(
      style: TabStyle.fixedCircle,
      elevation: 2,
      cornerRadius: 12,
      backgroundColor: Color(0xFF457b9d),
      items: [TabItem(icon: Icons.add)],
      onTap: (index) {
        if (index == 0) {
          // Use a safe navigator call
          Navigator.of(
            context,
          ).push(MaterialPageRoute(builder: (context) => CreatePersonPage()));
        }
      },
    );
  }
}
