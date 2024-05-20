

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:minichat/services/auth/auth_services.dart';
import 'package:minichat/widgets/round_button.dart';
class Signupscreen extends StatelessWidget {
   Signupscreen({super.key, this.ontap,});
     final void Function()? ontap;

final  bool loading =false;

  final _formkey=GlobalKey<FormState>() ;

  final emailcontroller=TextEditingController();

  final passwordcontroller=TextEditingController();

    final _confirmpasswordcontroller=TextEditingController();


    void signUp(BuildContext context){
      final auth=Authservices();
       if(passwordcontroller.text==_confirmpasswordcontroller.text){
          try{
       
        auth.signUpwithemailandPassword(emailcontroller.text, passwordcontroller.text);

        
      }
      catch(e){
        showDialog(context:context , builder: (context){
          return AlertDialog(
            title: Text(e.toString()),
          );
        });
      }
        }else{
          showDialog(context:context , builder: (context){
          return AlertDialog(
            title: Text("password incorrect"),
          );
        });
        }
      
    }

  @override
  Widget build(BuildContext context) {
    
    return  Scaffold(
     
      
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
             children: [

//  SizedBox(
//                 height: 200,
//                 width: 300,
//                 child: Lottie.asset("assets/animations/Animation - 1705482962896.json",)),
                SizedBox(height: 20,),
              
         
              Form(
                key: _formkey,
                child: Column(children: [
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
                          border: OutlineInputBorder(
                            
                              borderRadius: BorderRadius.circular(10)),
                        prefixIcon: const Icon(Icons.email),
                          labelStyle: const TextStyle(color: Colors.black),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(color: Colors.black),
                          ),
                        ),
                      ),
          
          const SizedBox(height: 20,),
          
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
                       hintText: "password ",
                        border: OutlineInputBorder(
                          
                            borderRadius: BorderRadius.circular(10)),
                        prefixIcon: const Icon(Icons.lock_open_rounded),
                        labelStyle: const TextStyle(color: Colors.black),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(color: Colors.black),
                        ),
                      ),
                    ),
                      
          const SizedBox(height: 20,),
TextFormField(
  controller:_confirmpasswordcontroller,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Password is required';
                        }
                        return null;
                      },
                      cursorColor: Colors.black,
                      style: const TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                      hintText: "confirm password ",
                        border: OutlineInputBorder(
                          
                            borderRadius: BorderRadius.circular(10)),
                        prefixIcon: const Icon(Icons.lock_open_rounded),
                        labelStyle: const TextStyle(color: Colors.black),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(color: Colors.black),
                        ),
                      ),
                    ),

              ],)),
            
                      const SizedBox(height: 20,),

                       RoundButton(
                        loading: loading,
                        buttoncolor: Theme.of(context).colorScheme.primary, textcolor: Colors.white, title: "SignUp",
                       ontap: ()async{
                        if(_formkey.currentState!.validate()){

                          // sign up function call


                    signUp(context);
                        }
                       }),
                         Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
      const Text("Already have an account"),
       GestureDetector(
        onTap:ontap ,
        child: Text("Login",))
     ],)
    
             ],
          ),
        ),
      ),
    );
  }
}