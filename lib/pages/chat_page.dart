
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:minichat/model/message_model.dart';
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
        }, icon: const Icon(Icons.arrow_back_ios,color: Colors.white,)),
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
    return StreamBuilder<List<Message>>(
        stream: chatservices.receivemessage(widget.receiverID, senderId),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Text("failed to load...");
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
final messages=snapshot.data!;
          return ListView.builder(
              itemCount: messages.length,
              itemBuilder: (context, index) {
final message=messages[index];
                bool iscurrentUser =
                                    message.senderId == authservices.getcurrentuser()!.uid;
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
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        child: ChatBubble(
                          type: message.type,
                            message: message.message,
                            iscurrentUser: iscurrentUser),
                      ),
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
          padding:  EdgeInsets.only(bottom: 14),
          child: Mytextfield(
            onPressed: ()=>chatservices.pickimageUpload(widget.receiverID ),
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
