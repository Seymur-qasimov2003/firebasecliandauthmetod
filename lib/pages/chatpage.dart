import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../services/authservice.dart';
import '../services/chatservice.dart';

class ChatPage extends StatefulWidget {
  String receiverId;
  String receiverEmail;

  ChatPage({required this.receiverId, required this.receiverEmail});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  var chatService = ChatService();
  var authServie = AuthService();
  final _auth = FirebaseAuth.instance;
  TextEditingController messageController = TextEditingController();

  void sendMessage() async {
    if (messageController.text.isNotEmpty) {
      await chatService.sendMessage(widget.receiverId, messageController.text);
      messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.receiverEmail),
        actions: [
          ///goruntulu arama ve sesli arama eklenecek
          IconButton(
            onPressed: () {
              // Navigator.push(
              //     context,
              //     CupertinoPageRoute(
              //         builder: (context) => VideoCallPage(
              //               receiverId: widget.receiverId,
              //             )));
            },
            icon: const Icon(Icons.video_call),
          ),
          IconButton(
            onPressed: () {
              // Navigator.push(
              //     context,
              //     CupertinoPageRoute(
              //         builder: (context) => VoiceCallPage(
              //               receiverId: widget.receiverId,
              //             )));
            },
            icon: const Icon(Icons.call),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(child: buildMessageList()),
          buildInputArea(),
        ],
      ),
    );
  }

  Widget buildMessageList() {
    var senderId = _auth.currentUser!.uid;
    return StreamBuilder(
      stream: chatService.getMessages(widget.receiverId, senderId!),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Center(
            child: Text('Bir hata oluştu'),
          );
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: Text('Yükleniyor...'),
          );
        }
        return ListView(
          children:
              snapshot.data!.docs.map((doc) => buildMessageItem(doc)).toList(),
        );
      },
    );
  }

  Widget buildMessageItem(DocumentSnapshot doc) {
    var data = doc.data() as Map<String, dynamic>;
    bool isMe = data['senderId'] == _auth.currentUser!.uid;
   // var alignment = isMe ? Alignment.centerRight : Alignment.centerLeft;
    return Column(
      crossAxisAlignment: isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        ///tarihi date time a çevir ve ekle


        Container(
          margin: const EdgeInsets.all(8),
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: isMe ? Colors.greenAccent : Colors.grey[300],
            borderRadius: BorderRadius.circular(8),
          ),
        //  alignment: alignment,
          child: Text(data['message']),
        ),
      ],
    );
  }

  Widget buildInputArea() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(20),
        ),
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            Expanded(
              child: TextField(

                controller: messageController,
                decoration: const InputDecoration(
                  hintText: 'Mesajınızı girin',
                  border: InputBorder.none,
                ),
              ),
            ),
            IconButton(
              onPressed: sendMessage,
              icon: const Icon(Icons.send),
            )
          ],
        ),
      ),
    );
  }
}
