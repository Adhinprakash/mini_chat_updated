import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class Authservices{

FirebaseAuth auth =FirebaseAuth.instance;
final FirebaseFirestore firestore=FirebaseFirestore.instance;


User? getcurrentuser(){
 return auth.currentUser;
}




Future<UserCredential>signInwithemailandpassword(String email,String password)async{
  try{
     UserCredential userCredential=await auth.signInWithEmailAndPassword(email: email, password: password);
   firestore.collection("Users").doc(userCredential.user!.uid).set({
    "uid":userCredential.user!.uid,
    "email":email
   });
  return userCredential;
  }on FirebaseException catch(e){
    throw Exception(e.code);
  }
}



Future<UserCredential>signUpwithemailandPassword(String email,String password)async{
try{
  UserCredential userCredential=await auth.createUserWithEmailAndPassword(email: email, password: password);
  firestore.collection("Users").doc(userCredential.user!.uid).set({
    "uid":userCredential.user!.uid,
    "email":email
   });
return userCredential;
}on FirebaseException catch(e){
  throw Exception(e.code);
}
}

void logout(){
  auth.signOut();
}



}