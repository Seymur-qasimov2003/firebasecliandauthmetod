import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterfirebasecli/services/authservice.dart';
import 'package:flutterfirebasecli/services/chatservice.dart';

import 'chatpage.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  AuthService authService = AuthService();
  ChatService chatService = ChatService();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('User Email: ${authService.userName}'),
          actions: [
            IconButton(
              onPressed: () {
                authService.signOut(context);
              },
              icon: const Icon(Icons.exit_to_app),
            )
          ],
        ),
        body: buildUserList(),
      ),
    );
  }

  Widget buildUserList() {
    return StreamBuilder(
      stream: chatService.getUsersStream(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Center(
            child: Text('Bir hata oluştu'),
          );
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return ListView.builder(
          ///signin olan user gelmeyecek
          itemCount: snapshot.data?.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: EdgeInsets.all(8.0),
              child: Card(
                child: ListTile(
                  title: Text(snapshot.data?[index]['email']),
                  onTap: () {
                    Navigator.push(
                      context,
                      CupertinoPageRoute(
                        builder: (context) => ChatPage(
                          receiverId: snapshot.data?[index]['uid'],
                          receiverEmail: snapshot.data?[index]['email'],
                        ),
                      ),
                    );
                  },
                  trailing: const Icon(Icons.arrow_forward_ios),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
