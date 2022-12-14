import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:model_bottom/constant/image_path.dart';
import 'notification_service.dart';
import 'second_notification.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  NotificationService.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Notification Demo',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();

    NotificationService.init(initScheduled: true);
    listenNotification();

    NotificationService.showScheduleNotification(
            title: 'Hello',
            body: 'Good Morning',
            payload: 'good_morning',
            scheduleDate: DateTime.now().add(const Duration(seconds: 10)));
  }

  void listenNotification() {
    NotificationService.onNotifications.stream.listen(onClickedNotification);
  }

  void onClickedNotification(String? payload) =>
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => MySecondScreen(
                payload: payload,
              )));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Notification Demo"),
        elevation: 0,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 100),
            // Update with local image
            child: Image.asset(ImagePath.imageLogo, scale: 0.6),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                onPressed: () {
                  NotificationService.showNotification(
                    title: "E-commerce",
                    body: "Hello",
                    payload: "E-commerce",
                  );
                },
                child: const Text("Notification Now"),
              ),
              ElevatedButton(
                  onPressed: () {
                    NotificationService.showScheduleNotification(
                        title: 'good morning',
                        body: 'How R U',
                        payload: 'good_morning',
                        scheduleDate: DateTime.now().add(const Duration(seconds: 15)),
                    );

                    ScaffoldMessenger.of(context)
                      ..removeCurrentSnackBar()
                      ..showSnackBar(
                        const SnackBar(
                          content: Text(
                            "An Notification has been sent 10 Seconds",
                            style: TextStyle(fontSize: 18),
                          ),
                        ));

                  }, child: const Text("Schedule  Notification"))
            ],
          ),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceAround,
          //   children: [
          //     ElevatedButton(onPressed: () {}, child: const Text("Notification grouped")),
          //     ElevatedButton(onPressed: () {}, child: const Text("Cancel All Notification",),
          //     )
          //   ],
          // ),
        ],
      ),
    );
  }
}
