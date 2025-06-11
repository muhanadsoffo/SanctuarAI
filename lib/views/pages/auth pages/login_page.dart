import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:sanctuarai/controllers/auth_controller.dart';
import 'package:sanctuarai/services/auth_service.dart';
import 'package:sanctuarai/views/pages/auth%20pages/register_page.dart';
import 'package:sanctuarai/views/widget_tree.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(backgroundColor: Color(0xFF457b9d)),
        backgroundColor: Color(0xFF457b9d),
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
                            "LOGIN",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 60,
                              fontWeight: FontWeight.bold,
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
                            child: Column(
                              children: [
                                SizedBox(height: 25),
                                Text(
                                  "Welcome back!",
                                  style: TextStyle(
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(height: 30),
                                    TextField(
                                      controller: emailController,
                                      decoration: InputDecoration(
                                        prefixIcon: Icon(Icons.email),
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(
                                            14,
                                          ),
                                        ),
                                        hintText: "Enter your Email address",
                                      ),
                                      style: TextStyle(height: 2),
                                    ),
                                    SizedBox(height: 30),
                                    TextField(
                                      controller: passwordController,
                                      obscureText: true,
                                      decoration: InputDecoration(
                                        prefixIcon: Icon(Icons.lock),
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(
                                            14,
                                          ),
                                        ),
                                        hintText: "Enter your Password",
                                      ),
                                      style: TextStyle(height: 2),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 30),
                                FilledButton(
                                  style: FilledButton.styleFrom(
                                    minimumSize: Size(260, 60),
                                  ),
                                  onPressed: () async {
                                    final error = await AuthController
                                        .authController
                                        .login(
                                          email: emailController.text,
                                          password: passwordController.text,
                                        );
                                    if (error != null) {
                                        ScaffoldMessenger.of(
                                          context,
                                        ).showSnackBar(
                                          SnackBar(
                                            content: Text(error),
                                            backgroundColor: Colors.red,
                                          ),
                                        );
                                    }else if (error == null) Navigator.pop(context);
                                  },
                                  child: Text(
                                    "Login",
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 30),
                                RichText(
                                  text: TextSpan(
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.black,
                                    ),
                                    children: <TextSpan>[
                                      TextSpan(text: "Forgot your password? "),
                                      TextSpan(
                                        text: "Click Here!",
                                        style: TextStyle(
                                          color: Colors.blue,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        recognizer:
                                            TapGestureRecognizer()
                                              ..onTap = () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) {
                                                      return RegisterPage();
                                                    },
                                                  ),
                                                );
                                              },
                                      ),
                                    ],
                                  ),
                                ),
                              ],
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
