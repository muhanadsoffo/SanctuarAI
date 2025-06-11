import 'package:flutter/material.dart';
import 'package:sanctuarai/controllers/auth_controller.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({super.key});

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  final emailController = TextEditingController();
  final currentPassController = TextEditingController();
  final newPassController = TextEditingController();
  bool isObscure = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Change your password",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Color(0xFF457b9d),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(Icons.key, color: Color(0xFF457b9d), size: 150),
              SizedBox(height: 50),
              TextField(
                controller: emailController,
                decoration: InputDecoration(
                  hintText: "Enter your Email",
                  prefixIcon: Icon(Icons.email),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                style: TextStyle(height: 2),
              ),
              SizedBox(height: 20),
              TextField(
                controller: currentPassController,
                obscureText: isObscure,
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        isObscure = !isObscure;
                      });
                    },
                    icon: Icon(
                      isObscure ? Icons.visibility_off : Icons.visibility,
                    ),
                  ),
                  hintText: "Enter your current password",
                  prefixIcon: Icon(Icons.password_outlined),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                style: TextStyle(height: 2),
              ),
              SizedBox(height: 20),
              TextField(
                controller: newPassController,
                obscureText: isObscure,
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        isObscure = !isObscure;
                      });
                    },
                    icon: Icon(
                      isObscure ? Icons.visibility_off : Icons.visibility,
                    ),
                  ),
                  hintText: "Enter your new password",
                  prefixIcon: Icon(Icons.password_rounded),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                style: TextStyle(height: 2),
              ),
              SizedBox(height: 20),
              FilledButton(
                onPressed: () async {
                  final error = await AuthController.authController
                      .changePassword(
                        email: emailController.text,
                        currentPassword: currentPassController.text,
                        newPassword: newPassController.text,
                      );
                  if (error != null){
                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(
                      SnackBar(
                        content: Text(error),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }else {
                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(
                      SnackBar(
                        content: Text("Password changed Successfully"),
                        backgroundColor: Colors.green,
                      ),
                    );
                    Navigator.pop(context);
                  }
                },
                style: FilledButton.styleFrom(minimumSize: Size(260, 60)),
                child: Text(
                  "Change",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
