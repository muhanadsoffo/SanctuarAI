import 'package:flutter/material.dart';
import 'package:sanctuarai/controllers/auth_controller.dart';

class DeleteAccount extends StatefulWidget {
  const DeleteAccount({super.key});

  @override
  State<DeleteAccount> createState() => _DeleteAccountState();
}

class _DeleteAccountState extends State<DeleteAccount> {
  final emailController = TextEditingController();
  final passController = TextEditingController();
  bool isObscure = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(
        "Delete your Account",
        style: TextStyle(color: Colors.white),
      ),
        backgroundColor: Color(0xFF457b9d),),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(Icons.clear, color: Colors.red, size: 150),
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
                controller: passController,
                obscureText: isObscure,
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        isObscure = !isObscure;
                      });
                    },
                    icon: Icon(isObscure ? Icons.visibility_off : Icons.visibility),
                  ),
                  hintText: "Enter your password",
                  prefixIcon: Icon(Icons.password_outlined),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                style: TextStyle(height: 2),
              ),
              SizedBox(height: 20),
              FilledButton(
                onPressed: () async {
                  final error = await AuthController.authController.deleteAccount(
                    email: emailController.text,
                    password: passController.text,
                  );
                  if (error != null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(error), backgroundColor: Colors.red),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("Account has been deleted"),
                        backgroundColor: Colors.green,
                      ),
                    );
                    Navigator.of(context).popUntil((route) => route.isFirst);
                  }
                },
                style: FilledButton.styleFrom(minimumSize: Size(double.infinity, 60)),
                child: Text(
                  "Delete",
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
