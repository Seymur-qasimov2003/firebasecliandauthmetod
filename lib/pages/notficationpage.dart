import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NotficationPage extends StatefulWidget {
  RemoteMessage? messageee;

  NotficationPage({this.messageee});

  @override
  State<NotficationPage> createState() => _NotficationPageState();
}

class _NotficationPageState extends State<NotficationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notfication Page'),
      ),
      body: Center(
        child: Text('${widget.messageee!.notification!.title}'),
      ),
    );
  }
}
