
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:minichat/pages/chat_page.dart';
import 'package:minichat/services/auth/auth_services.dart';
import 'package:minichat/services/chat/chat_services.dart';
import 'package:minichat/widgets/my_drawer.dart';
import 'package:minichat/widgets/usertile_widget.dart';

class ScreenHome extends StatelessWidget {
  ScreenHome({super.key});
  final FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    final Chatservices chatservices = Chatservices();
    final Authservices auth = Authservices();

    return Scaffold(
      drawer: Mydrawer(),
      appBar: AppBar(
        // centerTitle: true,
        backgroundColor: Colors.black,

        title: const Text(
          "MINI CHAT",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            StreamBuilder(
                stream: chatservices.getuserstream(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return const Text("failed to load");
                  } else if (snapshot.connectionState ==
                      ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }
                  List<Map<String, dynamic>> userdata = snapshot.data ?? [];

                  return Expanded(
                    child: ListView.builder(
                        itemCount: userdata.length,
                        itemBuilder: (context, index) {
                          Map<String, dynamic> data = userdata[index];
                          if (data['email'] != auth.getcurrentuser()!.email) {
                            return Usertile(text: data["email"],
                            ontap: (){
                                Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ChatPage(
                        receiverEmail: data['email'],
                        receiverID: data['uid'],
                      )));
                            },
                            );
                          } else {
                            return Container();
                          }
                        }),
                  );
                })
          ],
        ),
      ),
    );
  }
}
