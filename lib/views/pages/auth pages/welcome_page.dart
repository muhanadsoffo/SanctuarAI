import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:sanctuarai/views/pages/auth%20pages/login_page.dart';
import 'package:sanctuarai/views/pages/auth%20pages/register_page.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF457b9d),

      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: IntrinsicHeight(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                
                  children: [
                    SizedBox(height: 50,),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
                        ),
                        height: 370,
                        width: double.infinity,
                
                        child: Lottie.asset(
                          'assets/lotties/Ai.json',
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.vertical(top: Radius.circular(65)),
                          color: Colors.white,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              SizedBox(height: 30),
                              Text(
                                "WELCOME TO SANCTUARAI",
                                style: TextStyle(
                                    fontSize: 25,
                                    fontStyle: FontStyle.italic,
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                              Text("Your safe place and sanctuary",style: TextStyle(fontSize: 20,),),
                              const SizedBox(height: 70),
                              FilledButton(
                                onPressed: () {
                                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                                    return LoginPage();
                                  },));
                                },
                
                                style: FilledButton.styleFrom(
                                  minimumSize: Size(double.infinity, 60),
                                ), child: Text("Login", style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),
                              ),
                              const SizedBox(height: 25),
                              RichText(
                                text: TextSpan(
                                  style: TextStyle(fontSize: 15, color: Colors.black),
                                  children: <TextSpan>[
                                    TextSpan(text: "You don't have an account? "),
                                    TextSpan(
                                      text: "Register Here!",
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
    );
  }
}
