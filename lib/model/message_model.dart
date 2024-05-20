import 'package:cloud_firestore/cloud_firestore.dart';

class Message{
  final String senderId;
  final String senderEmail;
  final String revciverId;
  final String message;
  final  Timestamp timestamp;
  final String type;

  Message({required this.message, required this.senderId, required this.senderEmail, required this.revciverId, required this.timestamp,this.type='text'});
  



  Map<String,dynamic>toMap(){
    return  {
      "senderId":senderId,
      "senderEmail":senderEmail,
      "revciverId":revciverId,
      "message":message,
      "timestamp":timestamp,
      'type':type
   
    };
  }
}