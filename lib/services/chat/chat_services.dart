import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:minichat/model/message_model.dart';

class Chatservices {
// get firestore instance
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;

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

  Stream<QuerySnapshot> receivemessage(String userId, othersId) {
    List<String> ids = [userId, othersId];
    ids.sort();
    String chatroomId = ids.join("_");

    return firestore
        .collection("chat_room")
        .doc(chatroomId)
        .collection("messages")
        .orderBy("timestamp", descending: false)
        .snapshots();
  }
}
