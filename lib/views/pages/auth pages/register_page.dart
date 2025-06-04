import 'package:flutter/material.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: Color(0xFF457b9d),
        appBar: AppBar(backgroundColor: Color(0xFF457b9d)),

        body: SafeArea(
          child: SingleChildScrollView(
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
                Container(
                  height: MediaQuery.of(context).size.height *0.668,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.vertical(top: Radius.circular(65)),
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
                          TextField(obscureText: true,
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
                            style: FilledButton.styleFrom(minimumSize: Size(260, 60)),
                            onPressed: () {},
                            child: Text("Sign up", style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),
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
      ),
    );
  }
}
