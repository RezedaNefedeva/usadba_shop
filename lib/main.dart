
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_app/features/profile/widgets/shared_data.dart';
import 'package:firebase_app/local_services.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'firebase_options.dart';
import 'flutter_cart.dart';
import 'routers/routes.dart';
import 'theme/theme.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print("Handling a background message: ${message.messageId}");
}

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

void main() async {

  LocalNotificationServices.initialize(flutterLocalNotificationsPlugin);

  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  if(SharedData.userName != ''){
    getToken();
  }

  // final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'pushnotification', // id
    'High Importance Notifications', // title
    description: 'This channel is used for important notifications.', // description
    importance: Importance.max,
  );

  final androidPlugin = flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>();
  if(androidPlugin != null){
    await androidPlugin.createNotificationChannel(channel);
  }
  final messaging = FirebaseMessaging.instance;
  LocalNotificationServices.initialize(flutterLocalNotificationsPlugin);
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  FirebaseMessaging.onMessage.listen((RemoteMessage message){
    final notification = message.notification;
    final android = message.notification?.android;
    if(notification !=null && android != null){
      flutterLocalNotificationsPlugin.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              channel.id,
              channel.name,
              channelDescription: channel.description,
              icon: 'logo',
            )
          )
      );
    }
    });
  var cart = FlutterCart();
  await cart.initializeCart(isPersistenceSupportEnabled: true);


  runApp(MaterialApp(
    theme: theme,
    initialRoute: '/',
    routes: routes,
  ));


}

void getToken() async{
  await FirebaseMessaging.instance.getToken().then(
          (token) {
        saveToken(token!);
      }
  );
}

void saveToken(String token) async{
  await FirebaseFirestore.instance.collection('userTokens').doc(SharedData.userPhone).set({
    'token' : token,
  });

}



