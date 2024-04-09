// import 'dart:async';
//
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/cupertino.dart';
//
// import '../pages/notficationpage.dart';
//
// Future<void> backgroundHandler(RemoteMessage message) async {
//   print(message.data.toString());
//   print(message.notification!.title);
// }
//
// class FirebaseMessagingService {
//   final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
//
//   void handleMessages(RemoteMessage? message, BuildContext context) {
//     if (message == null) {
//       return;
//     }
//     Navigator.push(
//         context,
//         CupertinoPageRoute(
//             builder: (context) => NotficationPage(messageee: message)));
//   }
//
//   Future<void> initFirebaseMessaging() async {
//     ///request permission
//     var permission = await _firebaseMessaging.requestPermission();
//
//     ///token
//     ///
//     var token = await _firebaseMessaging.getToken();
//     print('Token: $token');
//     initPushNotification();
//   }
//
//   Future<void> initPushNotification() async {
//     await FirebaseMessaging.instance
//         .setForegroundNotificationPresentationOptions(
//       alert: true,
//       badge: true,
//       sound: true,
//     );
//     FirebaseMessaging.instance.getInitialMessage().then(handleMessages);
//     FirebaseMessaging.onMessageOpenedApp.listen(handleMessages as void Function(RemoteMessage message)?);
//     FirebaseMessaging.onBackgroundMessage(backgroundHandler);
//   }
// }
