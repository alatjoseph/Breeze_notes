import 'package:flutter/material.dart';
import 'package:notes_app/authentication/signin.dart';

class Loginpg extends StatelessWidget {
  const Loginpg({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[700],
        body: Center(
          child: Column(
            children: [
              const SizedBox(
                height: 50,
              ),
              const Text(
                'BreezeNotes',
                style: TextStyle(
                  fontFamily: 'lato',
                  fontWeight: FontWeight.bold,
                  fontSize: 40,
                  color: Colors.white,
                ),
              ),
              Expanded(
                child: Container(
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('lib/assets/images/cover.png'))),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(bottom: 30),
                child: Text(
                  "Write It Down, Make It Real.",
                  style: TextStyle(
                  fontFamily: 'lato', 
                  fontSize: 22,
                  color: Colors.white),
                  textAlign: TextAlign.center,
                  
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 40),
                child: Padding(
                  
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                    ),
                      onPressed: () {
                        signInWithGoogle(context);
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Continue with Google',
                            style: TextStyle(fontFamily: 'lato',
                             fontSize: 18,
                             color: Colors.black,
                             
                            ),
                          ),
                          const SizedBox(
                            width: 30,
                          ),
                          Image.asset(
                            "lib/assets/images/google.png",
                            height: 30,
                          )
                        ],
                      )),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
