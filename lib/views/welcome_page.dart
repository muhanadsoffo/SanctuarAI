import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:sanctuarai/views/register_page.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,

          children: [
            Container(
              width: double.infinity,

              child: Lottie.asset(
                'assets/lotties/edited.json',
                fit: BoxFit.fill,
              ),
            ),

            Text(
              "WELCOME TO SANCTUARAI",
              style: TextStyle(fontSize: 25, fontStyle: FontStyle.italic),
            ),
            const SizedBox(height: 50),
            FilledButton(
              onPressed: () {},
              child: Text("Login", style: TextStyle(fontSize: 20)),
              style: FilledButton.styleFrom(
                minimumSize: Size(double.infinity, 60),
              ),
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
    );
  }
}
