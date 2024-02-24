import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
//below variables are to control the text when we enter
  final username = TextEditingController();
  final password = TextEditingController();

  bool isVisible = false; // variable to show and hide password
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [

                Image.asset("assets/images/final.png",
                width: 200,),
                const SizedBox(height: 15),
                
                //Username field
                Container(
                  margin: EdgeInsets.all(8),
                  padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 6),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.deepPurple.withOpacity(.2)
                  ),
                  child: TextFormField(
                    decoration: const InputDecoration(
                      icon: Icon(Icons.person),
                      border: InputBorder.none,
                      hintText: "Username"
                    ),
                  ),
                ),

                //Password Field
                Container(
                  margin: EdgeInsets.all(8),
                  padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 6),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.deepPurple.withOpacity(.2)
                  ),
                  child: TextFormField(
                    obscureText: !isVisible,
                    decoration:  InputDecoration(
                        icon: const Icon(Icons.lock),
                        border: InputBorder.none,
                        hintText: "Password",
                        suffixIcon: IconButton(
                            onPressed: () {
                              //code to show and hide password
                              setState(() {
                                isVisible = !isVisible;
                              });
                            }, icon: Icon(isVisible? Icons.visibility : Icons.visibility_off))
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

//Stopped at 8:13 --- https://www.youtube.com/watch?v=oZujEA99kXA&t=1614s