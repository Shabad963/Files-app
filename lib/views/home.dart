import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_sample/config/size.dart';
import 'package:firebase_sample/controller/important_controller.dart';
import 'package:firebase_sample/controller/other_controller.dart';
import 'package:firebase_sample/main.dart';
import 'package:firebase_sample/utils/common.dart';
import 'package:firebase_sample/utils/utils.dart';
import 'package:firebase_sample/views/important/important.dart';
import 'package:firebase_sample/views/important/others.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';

import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String? title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  OtherFilesController othersController = Get.put(OtherFilesController());
  ImportantController importantController = Get.put(ImportantController());

  int _notifications = 0;

  AnimationController? _animationController;
  Animation<double>? _animation;
  bool _isBellRinging = false;

  @override
  void initState() {
    super.initState();

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null) {
        flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                channel.id,
                channel.name,
                color: Colors.blue,
                playSound: true,
                icon: '@mipmap/ic_lancher',
              ),
            ));
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('A new messageopen app event was published');
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null) {
        showDialog(
            context: context,
            builder: (_) {
              return AlertDialog(
                title: Text(notification.title!),
                content: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [Text(notification.body!)],
                  ),
                ),
              );
            });
      }
    });

    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));
    _animation = Tween<double>(begin: 0, end: 1).animate(_animationController!)
      ..addListener(() {
        setState(() {});
      });
  }

  void showNotification() {
    setState(() {
      _notifications++;
    });

    flutterLocalNotificationsPlugin.show(
        0,
        "Notification $_notifications",
        "This is an Flutter Push Notification",
        NotificationDetails(
            android: AndroidNotificationDetails(channel.id, channel.name,
                importance: Importance.high,
                color: Colors.blue,
                playSound: true,
                icon: '@mipmap/ic_launcher')));
  }

  @override
  void dispose() {
    _animationController!.dispose();
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;

    return Scaffold(
        appBar: AppBar(
          title: Text("Home", style: TextStyle(color: Colors.black)),
          backgroundColor: Colors.white,
          actions: [
            TextButton(
                onPressed: () {
                  FirebaseAuth.instance.signOut();
                  showNotification();
                },
                child: Text(
                  'Logout',
                  style: TextStyle(color: Colors.black),
                ))
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                FolderWidget(
                  title: 'Important files',
                  action: () {
                    Get.to(() => ImportantFiles());
                  },
                ),
                SizedBox(height: 3.0.hp),
                FolderWidget(
                  title: 'Other files',
                  action: () {
                    Get.to(() => OtherFiles());
                  },
                ),
                
              ],
            ),
          ),
        ),
    );
  }
}
