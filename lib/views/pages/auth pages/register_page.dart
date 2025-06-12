import 'package:flutter/material.dart';
import 'package:sanctuarai/controllers/auth_controller.dart';
import 'package:sanctuarai/views/pages/auth%20pages/login_page.dart';
import 'package:sanctuarai/views/pages/home_page.dart';
import 'package:sanctuarai/views/widget_tree.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passController = TextEditingController();
  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: Color(0xFF457b9d),
        appBar: AppBar(backgroundColor: Color(0xFF457b9d)),

        body: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: IntrinsicHeight(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 50),
                      Padding(
                        padding: const EdgeInsets.only(left: 15.0),
                        child: Container(
                          height: 150,
                          child: Text(
                            "REGISTER",
                            style: TextStyle(
                              fontSize: 60,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(65),
                            ),
                            color: Colors.white,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  SizedBox(height: 25),
                                  Text(
                                    "Create an Account",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 30,
                                    ),
                                  ),
                                  SizedBox(height: 30),
                                  TextField(
                                    controller: nameController,
                                    decoration: InputDecoration(

                                      prefixIcon: Icon(Icons.person),
                                      hintText: "Enter your full name",
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(14),
                                      ),
                                    ),
                                    style: TextStyle(height: 2),
                                  ),
                                  SizedBox(height: 30),
                                  TextField(
                                    controller: emailController,
                                    decoration: InputDecoration(
                                      prefixIcon: Icon(Icons.email),
                                      hintText: "Enter your Email address",
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(14),
                                      ),
                                    ),
                                    style: TextStyle(height: 2),
                                  ),
                                  SizedBox(height: 30),
                                  TextField(
                                    controller: passController,
                                    obscureText: true,
                                    decoration: InputDecoration(
                                      prefixIcon: Icon(Icons.lock),
                                      hintText: "Enter your Password",
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(14),
                                      ),
                                    ),
                                    style: TextStyle(height: 2),
                                  ),
                                  SizedBox(height: 30),
                                  FilledButton(
                                    style: FilledButton.styleFrom(
                                      minimumSize: Size(double.infinity, 60),
                                    ),
                                    onPressed: () async {
                                      final error = await AuthController.authController
                                          .signUp(
                                            email: emailController.text,
                                            password: passController.text,
                                            userName: nameController.text,
                                          );
                                      if (error != null) {
                                          ScaffoldMessenger.of(
                                            context,
                                          ).showSnackBar(
                                            SnackBar(content: Text(error),backgroundColor: Colors.red,),
                                          );


                                      } else {
                                        Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) {
                                              return LoginPage();
                                            },
                                          ),
                                        );
                                      }
                                    },
                                    child: Text(
                                      "Sign up",
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
