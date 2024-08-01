// import "package:firebase_messaging/firebase_messaging.dart";

// class FirebaseApi {
//   //create an instance of the firebase Messaging

//   final _firebaseMessaging = FirebaseMessaging.instance;

// //request permission from user(will prompt user)

//   //function to initilize notification
//   Future<void> iniNotifcation() async {
//     await _firebaseMessaging.requestPermission();

//     //fetch the FCM token for the device
//     final fcMToken = await _firebaseMessaging.getToken();

// //print the token (normally you would send this to your server)
//     print('Token: $fcMToken');
//   }

//   //fucntion to handle received messages

//   //function to initialize foreground and background settings
// }
