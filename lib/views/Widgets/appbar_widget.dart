import 'package:flutter/material.dart';
import 'package:sanctuarai/controllers/auth_controller.dart';
import 'package:sanctuarai/services/auth_service.dart';
import 'package:sanctuarai/views/pages/profile_page.dart';

class AppbarWidget extends StatelessWidget implements PreferredSizeWidget {
  const AppbarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Color(0xFF457b9d),
      actions: [
        IconButton(onPressed: () async{
          final error = await AuthController.authController.logout();
          if(error != null){

            ScaffoldMessenger.of(
              context,
            ).showSnackBar(
              SnackBar(content: Text(error),backgroundColor: Colors.red,),
            );
          }

        }, icon: Icon(Icons.logout,color: Colors.white,))
      ],
      title: GestureDetector(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return ProfilePage();
          },));
        },
        child: Row(
          children: [

            CircleAvatar(
              radius: 25,
              backgroundImage: AssetImage('assets/images/me.jpeg'),
            ),
            SizedBox(width: 12,),
            Text("Muhannad")
          ],
        ),
      ),
    );
  }
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
