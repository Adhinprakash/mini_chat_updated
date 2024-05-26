import 'package:flutter/material.dart';

class ChatBubble extends StatelessWidget {
  final String message;
  final bool iscurrentUser;
  final String type;
  const ChatBubble({super.key, required this.message, required this.iscurrentUser, required this.type});

  @override
  Widget build(BuildContext context) {
    
    if(type=='text'){
    return Container(
      decoration: BoxDecoration(
          
    color: iscurrentUser?Colors.green:Colors.grey ,
       
        borderRadius: BorderRadius.circular(14)
      ),
      padding: const EdgeInsets.all(16),
      
      margin: const EdgeInsets.symmetric(vertical: 2.5,horizontal: 20),
      child: Text(message),
    ) ;

    }else if (type == 'image') {
      return Container(
        height: 300,
        width: 300,
        margin: const EdgeInsets.symmetric(vertical: 5, horizontal:10),
        child: ClipRRect(
           
          borderRadius: BorderRadius.circular(10),
          child: Image.network(
            message,
            loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
              if (loadingProgress == null) return child;
              return Center(
                child: CircularProgressIndicator(
                  value: loadingProgress.expectedTotalBytes != null
                      ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
                      : null,
                ),
              );
            },
            errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
              return const Text('Failed to load image');
            },
          ),
        ),
      );
    } else {
      return Container();
    }
    
     
  }
}