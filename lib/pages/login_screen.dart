import 'package:flutter/material.dart';


import 'package:flutter/widgets.dart';
import 'package:minichat/services/auth/auth_services.dart';
import 'package:minichat/widgets/round_button.dart';

class LogiScreen extends StatelessWidget {
   LogiScreen({super.key, this.ontap});

 final  bool loading = false;

  final _formkey = GlobalKey<FormState>();

  final emailcontroller = TextEditingController();

  final passwordcontroller = TextEditingController();

 final void Function()? ontap;



void login(){
Authservices authservices=Authservices();


try{
  authservices.signInwithemailandpassword(emailcontroller.text, passwordcontroller.text);
}catch(e){
  AlertDialog(
    title: Text(e.toString()),
  );
}
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [


              // SizedBox(
              //   height: 200,
              //   width: 200,
              //   child: Lottie.asset("assets/animations/Animation - 1705480449535.json")),
                SizedBox(height: 20,),
              Form(
                  key: _formkey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: emailcontroller,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Email is required';
                          }
                          return null;
                        },
                        
                        cursorColor: Colors.black,
                        style: const TextStyle(color: Colors.black),
                        decoration: InputDecoration(
                          hintText: "Email",
                            prefixIcon: const Icon(Icons.email_outlined),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)),
                            labelStyle: const TextStyle(color: Colors.black),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(color: Colors.black),
                            ),
                            fillColor: Colors.white),
                          
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        
                        controller: passwordcontroller,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Password is required';
                          }
                          return null;
                        },
                        cursorColor: Colors.black,
                        style: const TextStyle(color: Colors.black),
                        decoration: InputDecoration(
                          hintText: "Password",
                            prefixIcon: const Icon(Icons.lock_open),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)),
                            labelStyle: const TextStyle(color: Colors.black),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(color: Colors.black),
                            ),
                            fillColor: Colors.white),
                      ),
                    ],
                  )),
              SizedBox(
                height: 20,
              ),
              RoundButton(
                  loading: loading,
                  buttoncolor: Theme.of(context).colorScheme.primary,
                  textcolor: Colors.white,
                  title: "Login",
                  ontap: () {
                    if (_formkey.currentState!.validate()) {
                    login();
                    }
                  }),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children:  [
                  Text("Don't have an account "),
                   
                  GestureDetector(
                    onTap: ontap,
                    
                    child: Text("SignUp",style: TextStyle(color: Colors.grey),))
                ],
              ),
              SizedBox(
                height: 20,
              ),
            
            ],
          ),
        ),
      ),
    );
  }
}
