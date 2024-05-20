
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter/material.dart';
import 'package:minichat/utils/toast_message.dart';

class Mydrawer extends StatefulWidget {
  const Mydrawer({super.key});

  @override
  State<Mydrawer> createState() => _MydrawerState();
}

class _MydrawerState extends State<Mydrawer> {

    final _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return  Drawer(
      backgroundColor: Theme.of(context).colorScheme.background,
child: Column(
  mainAxisAlignment: MainAxisAlignment.spaceBetween,
  children: [

    Column(
      children: [
          DrawerHeader(child: Center(
      child: Icon(Icons.message,color:Colors.black,size: 40,),
    )),
Padding(
  padding: const EdgeInsets.only(left: 25),
  child: ListTile(
    title: const Text("H O M E"),
    leading: const Icon(Icons.home),
    onTap: (){
Navigator.pop(context);
    },
  ),
),
 Padding(
  padding: EdgeInsets.only(left: 25),
  child: ListTile(
    onTap: (){
// Navigator.push(
//               context,
//               MaterialPageRoute(
//                   builder: (context) => SettingsPage()));
    },
    title: Text("S E T T I N G S"),
    leading: Icon(Icons.settings),
  ),
)
      ],
    ),
   Padding(
  padding: const EdgeInsets.only(left: 25,bottom: 20),
  child: ListTile(
    onTap: (){
         _auth.signOut().then((value) {
                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (context) => const LogiScreen()));
                  }).onError((error, stackTrace) {
                    Utils().toastmessage(error.toString());
                  });
    },
    title: const Text("LO G O U T"),
    leading: const Icon(Icons.logout),
  ),
)

  ],
),
    );  
  }
}
