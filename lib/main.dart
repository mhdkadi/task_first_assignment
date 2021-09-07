import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:muhammad/helper/route/routes_generater.dart';
import 'package:muhammad/view/theme.dart';

void main() {
  AwesomeNotifications().initialize(
    null,
    [
        NotificationChannel(
            channelKey: 'hello_channel',
            channelName: 'Hello notifications',
            channelDescription: 'Notification channel for Hello notifications',
            defaultColor: Colors.blue,
            ledColor: Colors.white,
            importance: NotificationImportance.High,
            channelShowBadge: true,

        ),
        NotificationChannel(
            channelKey: 'bye_channel',
            channelName: 'Bye notifications',
            channelDescription: 'Notification channel for Bye notifications',
            defaultColor: Colors.blue,
            ledColor: Colors.white,
            importance: NotificationImportance.High,
            channelShowBadge: true,

        )
    ]
);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Assignment',
      theme: theme(),
      initialRoute: '\RoutPage',
      onGenerateRoute: Routes.routesGenerater,
    );
  }
}
