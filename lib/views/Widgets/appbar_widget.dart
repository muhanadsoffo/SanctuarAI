import 'package:flutter/material.dart';

class AppbarWidget extends StatelessWidget implements PreferredSizeWidget {
  const AppbarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Color(0xFF457b9d),
      title: Row(
        children: [

          CircleAvatar(
            radius: 25,
            backgroundImage: AssetImage('assets/images/me.jpeg'),
          ),
          SizedBox(width: 12,),
          Text("Muhannad")
        ],
      ),
    );
  }
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
