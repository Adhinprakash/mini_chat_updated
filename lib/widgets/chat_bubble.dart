import 'package:flutter/material.dart';

class ChatBubble extends StatelessWidget {
  final String message;
  final bool iscurrentUser;
  const ChatBubble({super.key, required this.message, required this.iscurrentUser});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          
    color: iscurrentUser?Colors.green:Colors.grey ,
       
        borderRadius: BorderRadius.circular(14)
      ),
      padding: const EdgeInsets.all(16),
      
      margin: const EdgeInsets.symmetric(vertical: 2.5,horizontal: 25),
      child: Text(message),
    ) ;
  }
}