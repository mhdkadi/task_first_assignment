import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:muhammad/helper/notifications.dart';
import 'package:muhammad/helper/size.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String? email;
  String? fcmToken;

  void getPrefs() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    email = _prefs.getString('email');
    fcmToken = _prefs.getString('FCM_token');
    setState(() {});
  }

  void notificationStream() {
    AwesomeNotifications().actionStream.listen((notification) {
      if (notification.buttonKeyPressed == 'closes_the_app') {
        SystemNavigator.pop();
      }
    });
  }

  void notificationPermission() {
    AwesomeNotifications().isNotificationAllowed().then(
      (isAllowed) {
        if (!isAllowed) {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text('Allow Notifications'),
              content: Text('Our app would like to send you notifications'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    'Don\'t Allow',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: ScreenSize(context: context)
                          .getProportionateScreenWidth(18),
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () => AwesomeNotifications()
                      .requestPermissionToSendNotifications()
                      .then((_) => Navigator.pop(context)),
                  child: Text(
                    'Allow',
                    style: TextStyle(
                      color: Colors.teal,
                      fontSize: ScreenSize(context: context)
                          .getProportionateScreenWidth(18),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          );
        }
      },
    );
  }

  @override
  void initState() {
    super.initState();
    getPrefs();
    notificationStream();
    notificationPermission();
  }

  @override
  void dispose() {
    super.dispose();
    AwesomeNotifications().dispose();
    AwesomeNotifications().actionSink.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            "Profile",
            style: TextStyle(
              fontSize:
                  ScreenSize(context: context).getProportionateScreenWidth(26),
            ),
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal:
              ScreenSize(context: context).getProportionateScreenWidth(30),
          vertical:
              ScreenSize(context: context).getProportionateScreenHeight(20),
        ),
        child: Column(
          children: [
            SizedBox(
              height: ScreenSize(context: context)
                  .getProportionateScreenHeight(115),
              width:
                  ScreenSize(context: context).getProportionateScreenWidth(115),
              child: Stack(
                fit: StackFit.expand,
                clipBehavior: Clip.none,
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.blue,
                  ),
                ],
              ),
            ),
            SizedBox(
              height:
                  ScreenSize(context: context).getProportionateScreenHeight(20),
            ),
            Container(
              child: Row(
                children: [
                  Icon(
                    Icons.email,
                    color: Colors.blue,
                  ),
                  SizedBox(
                    width: ScreenSize(context: context)
                        .getProportionateScreenWidth(20),
                  ),
                  Expanded(
                    child: Text("$email", overflow: TextOverflow.ellipsis),
                  ),
                ],
              ),
              padding: EdgeInsets.symmetric(
                horizontal: ScreenSize(context: context)
                    .getProportionateScreenWidth(20),
                vertical: ScreenSize(context: context)
                    .getProportionateScreenHeight(20),
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Color(0xFFF5F6F9),
              ),
            ),
            TextButton(
              onPressed: () async {
                // Since i don't have a signOut Api Url, so this onPressed will do nothing
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text('Sign Out'),
                  SizedBox(
                    width: ScreenSize(context: context)
                        .getProportionateScreenWidth(10),
                  ),
                  Icon(Icons.arrow_forward),
                ],
              ),
            ),
            SizedBox(
              height: ScreenSize(context: context)
                  .getProportionateScreenHeight(100),
            ),
            Text('Notifications'),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    CreateNotification().createHelloNotification();
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: ScreenSize(context: context)
                          .getProportionateScreenWidth(10),
                    ),
                    child: Text('Hello'),
                  ),
                ),
                SizedBox(
                  width: ScreenSize(context: context)
                      .getProportionateScreenWidth(20),
                ),
                ElevatedButton(
                  onPressed: () {
                    CreateNotification().createByeNotification();
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: ScreenSize(context: context)
                          .getProportionateScreenWidth(10),
                    ),
                    child: Text('Bye'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
