import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:model_bottom/binding/binding.dart';
import 'package:model_bottom/routs.dart';
import 'package:model_bottom/screen/screen.dart';

import 'utill/shared_preferences_helper.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print('Handling a background message ${message.messageId}');
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


