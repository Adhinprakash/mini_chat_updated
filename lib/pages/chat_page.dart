import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:minichat/services/auth/auth_services.dart';
import 'package:minichat/services/chat/chat_services.dart';
import 'package:minichat/utils/consts.dart';
import 'package:minichat/widgets/chat_bubble.dart';
import 'package:minichat/widgets/my_textfield.dart';

class ChatPage extends StatefulWidget {
  final String receiverEmail;
  final String receiverID;
  ChatPage({super.key, required this.receiverEmail, required this.receiverID});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final Chatservices chatservices = Chatservices();

  final Authservices authservices = Authservices();
  FocusNode myfocus = FocusNode();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    myfocus.dispose();
    _messagecontroller.dispose();
  }

  final TextEditingController _messagecontroller = TextEditingController();

  void sendmessage()async {
    if (_messagecontroller.text.isNotEmpty) {
     await chatservices.sendMessage(widget.receiverID, _messagecontroller.text);
      _messagecontroller.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(onPressed: (){
          Navigator.pop(context);
        }, icon: Icon(Icons.arrow_back_ios,color: Colors.white,)),
        backgroundColor: primarycolor,
        title: Text(
          
          widget.receiverEmail,
          style: const TextStyle(color: Colors.white,fontSize: 16),
          
        ),
      ),
      body: Column(children: [
        Expanded(
          child: _buildmessageList(),
        ),
        _buildUserInput()
      ]),
    );
  }

  Widget _buildmessageList() {
    String senderId = authservices.getcurrentuser()!.uid;
    return StreamBuilder(
        stream: chatservices.receivemessage(widget.receiverID, senderId),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text("failed to load...");
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          final List<QueryDocumentSnapshot> document = snapshot.data!.docs;

          return ListView.builder(
              itemCount: document.length,
              itemBuilder: (context, index) {
                final messages = document[index].data() as Map<String, dynamic>;

                bool iscurrentUser =
                    messages['senderId'] == authservices.getcurrentuser()!.uid;
                var alignment = iscurrentUser
                    ? Alignment.topRight
                    : Alignment.topLeft;
                return Container(
                  alignment: alignment,
                  child: Column(
                    crossAxisAlignment: iscurrentUser
                        ? CrossAxisAlignment.end
                        : CrossAxisAlignment.start,
                    children: [
                      ChatBubble(
                          message: messages['message'],
                          iscurrentUser: iscurrentUser),
                    ],
                  ),
                );
              });
        });
  }

  Widget _buildUserInput() {
    return Row(
      children: [
        Expanded(
            child: Padding(
          padding: const EdgeInsets.only(bottom: 14),
          child: Mytextfield(
              focusNode: myfocus,
              hintText: "type a message",
              controller: _messagecontroller),
        )),
        Container(
            decoration: const BoxDecoration(
                shape: BoxShape.circle, color: Colors.green),
            margin: const EdgeInsets.only(right: 25),
            child: IconButton(
                onPressed: sendmessage,
                icon: const Icon(
                  Icons.send,
                  color: Colors.white,
                )))
      ],
    );
  }
}
