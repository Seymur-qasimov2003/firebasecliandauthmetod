import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutterfirebasecli/models/messagemodel.dart';

class ChatService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;

  Stream<List<Map<String, dynamic>>> getUsersStream() {
    ///burada signin olan user gelmeyecek
    return _firestore.collection('users').where(
      'uid',
      isNotEqualTo: _auth.currentUser!.uid,
    ).snapshots().map(
          (snapshots) => snapshots.docs.map((doc) => doc.data()).toList(),
        );
  }

  ///send message
  Future<void> sendMessage(String recevierId, message) async {
    var currentUserId = _auth.currentUser!.uid;
    var currentUserEmail = _auth.currentUser!.email;
    final Timestamp timeStamp = Timestamp.now();
    var newMessage = Message(
      senderId: currentUserId,
      senderEmail: currentUserEmail!,
      recevierId: recevierId,
      message: message,
      timeStamp: timeStamp,
    );

    List<String> ids = [currentUserId, recevierId];
    ids.sort();
    var chatRoomId = ids.join('_');
    await _firestore
        .collection('chat_rooms')
        .doc(chatRoomId)
        .collection('messages')
        .add(newMessage.toMap());
  }

  ///get messages
  Stream<QuerySnapshot> getMessages(String userId,  otherUserId) {
    List<String> ids = [userId, otherUserId];
    ids.sort();
    var chatRoomId = ids.join('_');
    return _firestore
        .collection('chat_rooms')
        .doc(chatRoomId)
        .collection('messages')
        .orderBy('timeStamp', descending: false)
        .snapshots();
  }
}
