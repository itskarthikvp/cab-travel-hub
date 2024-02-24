import 'package:flutter/material.dart';
import 'package:users_app/JsonModels/users.dart';
import 'package:users_app/SQLite/sqlite.dart';
import 'package:users_app/authentication/signup_screen_2.dart';
import 'package:users_app/views/notes.dart';

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
  bool isLoginTrue = false;
  final db = DatabaseHelper();
  
  login() async{
    var response = await db.login(Users(usrName: username.text, password: password.text));
    
    if(response == true) {
      //if login is correct then goto notes
      if(!mounted) return;
      Navigator.push(context, MaterialPageRoute(builder: (context) => const Notes()));
    } else {
      //set bool value true to print error message
      setState(() {
        isLoginTrue = true;
      });
    }
    
  }

  final formKey = GlobalKey<FormState>(); //create global key for our form
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            //We put all our text field to form to be controlled and not to be empty
            child: Form(
              key: formKey,
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
                      controller: username,
                      validator: (value){
                        if(value!.isEmpty) {
                          return "username is empty";
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                          icon: Icon(Icons.person),
                          border: InputBorder.none,
                          hintText: "Username"
                      ),
                    ),
                  ),

                  //Password Field
                  Container(
                    margin: const EdgeInsets.all(8),
                    padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 6),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.deepPurple.withOpacity(.2)
                    ),
                    child: TextFormField(
                      controller: password,
                      validator: (value){
                        if(value!.isEmpty) {
                          return "password is empty";
                        }
                        return null;
                      },
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
                  ),

                  //Login Button
                  const SizedBox(height: 10,),
                  Container(
                    height: 55,
                    width: MediaQuery.of(context).size.width * .9,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.deepPurple),
                    child: TextButton(
                        onPressed: () {
                          if(formKey.currentState!.validate()){
                            //Login method here
                            login();
                          }
                        } ,
                        child: const Text("LOGIN",
                          style: TextStyle(color: Colors.white),)),
                  ),

                  //Sign up button

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Don't have an account?"),
                      TextButton(onPressed: () {
                        //Navidate to Sign UP page
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> const SignUp()));

                      }, child: const Text("SIGN UP"))
                    ],
                  ),

                  //This message will be disabled by default, when username or password is incorrect, it will trigger
                  isLoginTrue? const Text(
                    "username or password is incorrect",
                    style: TextStyle(color: Colors.red),
                  ) : const SizedBox(),

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

