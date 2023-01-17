import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:model_bottom/binding/binding.dart';
import 'package:model_bottom/routs.dart';
import 'package:model_bottom/screen/screen.dart';
import 'screen/notification/notification_service.dart';
import 'utill/shared_preferences_helper.dart';
import 'package:awesome_notifications/awesome_notifications.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // await Firebase.initializeApp();
  print('Handling a background message ${message.messageId}');
  print('background message ${message.data}');

  AwesomeNotifications().createNotificationFromJsonData(message.data);
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await sharedPreferencesHelper.getSharedPreferencesInstance();
  await Firebase.initializeApp();
  requestPermission();

  listenFCM();

  //awesome notification
  AwesomeNotifications().initialize(
    null,
    [
      NotificationChannel(
          channelKey: 'E-commerce',
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

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  runApp(const MyApp());
}

void requestPermission() async {
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  await messaging.subscribeToTopic('all');

  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );

  if (settings.authorizationStatus == AuthorizationStatus.authorized) {
    print('User granted permission');
  } else if (settings.authorizationStatus == AuthorizationStatus.provisional) {
    print('User granted provisional permission');
  } else {
    print('User declined or has not accepted permission');
  }
}

void listenFCM() async {
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    RemoteNotification? notification = message.notification;
    AndroidNotification? android = message.notification?.android;
    if (notification != null && android != null && !kIsWeb) {
      NotificationService.showNotification(
        id: 0,
        title: message.notification?.title,
        body:  message.notification?.body,
        //payload: "E-commerce",
      );
      // flutterLocalNotificationsPlugin.show(
      //   notification.hashCode,
      //   notification.title,
      //   notification.body,
      //   NotificationDetails(
      //     android: AndroidNotificationDetails(
      //       channel.id,
      //       channel.name,
      //       // TODO add a proper drawable resource to android, for now using
      //       //      one that already exists in example app.
      //       icon: 'launch_background',
      //     ),
      //   ),
      // );
    }
  });
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
      getPages: appPage,
    );
  }
}
