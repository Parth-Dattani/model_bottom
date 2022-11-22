import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:model_bottom/binding/binding.dart';
import 'package:model_bottom/routs.dart';
import 'package:model_bottom/screen/screen.dart';

import 'utill/shared_preferences_helper.dart';

Future<void> main()   async {
  WidgetsFlutterBinding.ensureInitialized();
  await sharedPreferencesHelper.getSharedPreferencesInstance();
  await Firebase.initializeApp();
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


