import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:model_bottom/binding/binding.dart';
import 'package:model_bottom/routs.dart';
import 'package:model_bottom/screen/screen.dart';
import 'utill/shared_preferences_helper.dart';
import 'package:awesome_notifications/awesome_notifications.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print('Handling a background message ${message.messageId}');
  print('background message ${message.data}');
  
  AwesomeNotifications().createNotificationFromJsonData(message.data);
}

Future<void> main()   async {
  WidgetsFlutterBinding.ensureInitialized();
  await sharedPreferencesHelper.getSharedPreferencesInstance();
  await Firebase.initializeApp();
  FirebaseMessaging messaging = await FirebaseMessaging.instance;
  NotificationSettings settings = await messaging.requestPermission(
      sound: true,
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false
  );

  //try this condition for when u did not receiving notification
  if(settings.authorizationStatus == AuthorizationStatus.authorized){
    print("Permission Granted");
  }
  else if(settings.authorizationStatus == AuthorizationStatus.provisional){
    print("Permission provisional Granted");
  }
  else{
    print("Permission Not Granted");
  }

  FirebaseMessaging.onBackgroundMessage((message) => _firebaseMessagingBackgroundHandler(message));

  //awesome notification
  AwesomeNotifications().initialize(
    Emojis.emotion_blue_heart,
    debug: true,
    [
      NotificationChannel(
          channelKey: '101',
          channelName: 'E-commerce',
          channelDescription: 'Notification tests as alerts',
          playSound: true,
          onlyAlertOnce: true,
          enableLights: true,
          enableVibration: true,
          groupAlertBehavior: GroupAlertBehavior.Children,
          importance: NotificationImportance.High,
          defaultPrivacy: NotificationPrivacy.Private,
          defaultColor: Colors.red,
          ledColor: Colors.deepPurple)
    ],
  );
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});



  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: SplashScreen.pageId,
      initialBinding: SqliteDbBindings(),
      getPages:appPage,
    );
  }
}


