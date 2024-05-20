import 'dart:io';
import 'dart:js_util';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:minichat/model/message_model.dart';

class Chatservices {
// get firestore instance
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseStorage storage = FirebaseStorage.instance;
  final ImagePicker imagePicker = ImagePicker();
  Future<void> pickimageUpload(String recieverId) async {
    final XFile? image =
        await imagePicker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      await uploadimage(image, recieverId);
    }
  }

  Future<void> uploadimage(XFile image, String recieverId) async {
    final currentuserId = auth.currentUser!.uid;
    final currentuserEmail = auth.currentUser!.email;
    final Timestamp timestamp = Timestamp.now();

    String filename = '${DateTime.now().microsecondsSinceEpoch}.png';

    UploadTask uploadTask =
        storage.ref('chat_images/$filename').putFile(File(image.path));

    TaskSnapshot taskSnapshot = await uploadTask;

    String downloadUrl = await taskSnapshot.ref.getDownloadURL();

    Message newmessage = Message(
        message: downloadUrl,
        senderId: currentuserId,
        senderEmail: currentuserEmail!,
        revciverId: recieverId,
        timestamp: timestamp);

    // create chatroom id
    List<String> ids = [currentuserId, recieverId];
    ids.sort();
    String chatroomId = ids.join("_");

    await firestore
        .collection("chat_room")
        .doc(chatroomId)
        .collection('messages')
        .add(newmessage.toMap()
        );
  }

// get user stream

  Stream<List<Map<String, dynamic>>> getuserstream() {
    return firestore.collection("Users").snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        final user = doc.data();
        return user;
      }).toList();
    });
  }

// send message

  Future<void> sendMessage(String recieverId, message) async {
// get current user email and id

    final currentUserId = auth.currentUser!.uid;
    final currentUserEmail = auth.currentUser!.email;
    final Timestamp timestamp = Timestamp.now();

// create new message

    Message newmessage = Message(
        message: message,
        senderId: currentUserId,
        senderEmail: currentUserEmail!,
        revciverId: recieverId,
        timestamp: timestamp);

// create chatroom id
    List<String> ids = [currentUserId, recieverId];
    ids.sort();

    String chatroomId = ids.join("_");
// add message to database
    await firestore
        .collection("chat_room")
        .doc(chatroomId)
        .collection("messages")
        .add(newmessage.toMap());
  }

// get message

  Stream<List<Message>> receivemessage(String userId, othersId) {
    List<String> ids = [userId, othersId];
    ids.sort();
    String chatroomId = ids.join("_");

    return firestore
        .collection("chat_room")
        .doc(chatroomId)
        .collection("messages")
        .orderBy("timestamp", descending: false)
        .snapshots().map((snapshot){
          return snapshot.docs.map((doc) {
final data=doc.data() as Map<String,dynamic>;
return Message(message: data['message'], senderId: data['senderId'], senderEmail: data['senderEmail'], revciverId: data['revciverId'], timestamp: data['timestamp'],type: data['type']??"text");
          }).toList();
        } );
  }
}
