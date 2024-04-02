import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  String senderId;
  String senderEmail;
  String recevierId;
  String message;
  Timestamp timeStamp;

  Message({
    required this.senderId,
    required this.senderEmail,
    required this.recevierId,
    required this.message,
    required this.timeStamp,
  });

  Map<String, dynamic> toMap() {
    return {
      'senderId': senderId,
      'senderEmail': senderEmail,
      'recevierId': recevierId,
      'message': message,
      'timeStamp': timeStamp,
    };
  }

}
