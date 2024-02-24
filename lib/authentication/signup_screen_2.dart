import 'package:flutter/material.dart';
import 'package:users_app/authentication/login_screen_2.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final username = TextEditingController();
  final password = TextEditingController();
  final confirmPassword = TextEditingController();
  bool isVisible = false;
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Center(
        child: SingleChildScrollView( //SingleChildScrollView is to have scroll in the screen
          child: Form(
            key: formKey,
            child:  Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center, //to put contents in center of the screen
                children: [
                  const ListTile(
                    title: Text("Register New Account",
                      style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(8),
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

                  //Confirm Password Field
                  Container(
                    margin: const EdgeInsets.all(8),
                    padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 6),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.deepPurple.withOpacity(.2)
                    ),
                    child: TextFormField(
                      controller: confirmPassword,
                      validator: (value){
                        if(value!.isEmpty) {
                          return "password is empty";
                        } else if(password.text != confirmPassword.text){
                          return "Password does not match";
                        }
                        return null;
                      },
                      obscureText: !isVisible,
                      decoration:  InputDecoration(
                          icon: const Icon(Icons.lock),
                          border: InputBorder.none,
                          hintText: "Confirm Password",
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

                  const SizedBox(height: 10,),
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
                          }
                        } ,
                        child: const Text("SIGN UP",
                          style: TextStyle(color: Colors.white),)),
                  ),

                  //Sign up button

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Already have an account?"),
                      TextButton(onPressed: () {
                        //Navidate to Sign UP page
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> const LoginScreen()));

                      }, child: const Text("Login"))
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
