import 'package:flutter/material.dart';
import 'package:sanctuarai/views/pages/profile%20pages/change_password_page.dart';
import 'package:sanctuarai/views/pages/profile%20pages/delete_account_page.dart';
import 'package:sanctuarai/views/pages/profile%20pages/user_name.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Color(0xFF457b9d)),
      body: Column(
        children: [
          SizedBox(height: 20,),
          CircleAvatar(radius: 70,backgroundColor: Colors.grey,),
          SizedBox(height: 20,),
          UserName(),
          SizedBox(height: 20,),
          ListTile(
            title: Text(
              "Change Password",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            trailing: Icon(Icons.arrow_forward),
            onTap: () {
              Navigator.push(
                context,
                PageRouteBuilder(
                  pageBuilder:
                      (context, animation, secondaryAnimation) =>
                      ChangePasswordPage(),
                  transitionsBuilder: (context,
                      animation,
                      secondaryAnimation,
                      child,) {
                    final offsetAnimation = Tween<Offset>(
                      begin: Offset(1.0, 0.0),
                      end: Offset.zero,
                    ).animate(animation);
                    return SlideTransition(
                      position: offsetAnimation,
                      child: child,
                    );
                  },
                ),
              );
            },
          ),
          ListTile(
            title: Text(
              "Delete Account",
              style: TextStyle(
                color: Colors.red,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            trailing: Icon(Icons.arrow_forward),
            onTap: () {
              Navigator.push(context, PageRouteBuilder(
                pageBuilder:
                    (context, animation, secondaryAnimation) => DeleteAccount(),
                transitionsBuilder: (context,
                    animation,
                    secondaryAnimation,
                    child,) {
                  final offsetAnimation = Tween<Offset>(
                    begin: Offset(1.0, 0.0),
                    end: Offset.zero,
                  ).animate(animation);
                  return SlideTransition(
                    position: offsetAnimation,
                    child: child,
                  );
                },
              ),);
            },
          ),
        ],
      ),
    );
  }
}
