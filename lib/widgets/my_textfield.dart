import 'package:flutter/material.dart';

class Mytextfield extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final FocusNode? focusNode;
  final Future<void> Function()? onPressed;
  const Mytextfield({super.key, required this.hintText, required this.controller, this.focusNode,  this.onPressed});

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: TextField(
                         controller: controller, 
                          
                          cursorColor: Colors.black,
                          style: const TextStyle(color: Colors.black),
                          decoration: InputDecoration(
                              prefixIcon: IconButton(onPressed:onPressed

                            , icon: Icon(Icons.email_outlined)),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              labelStyle: const TextStyle(color: Colors.black),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: const BorderSide(color: Colors.black),
                              
                              ),
                              hintText:hintText,
                              
                              filled: true,
                              fillColor: Colors.white),
                        ),
    ) ;
  }
}