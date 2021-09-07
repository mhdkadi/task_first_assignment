import 'package:awesome_notifications/awesome_notifications.dart';

class CreateNotification {
  Future<void> createHelloNotification() async {
    await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: DateTime.now().millisecondsSinceEpoch.remainder(100000),
        channelKey: 'hello_channel',
        title: 'Hello',
        body: 'How are you my friend',
        notificationLayout: NotificationLayout.Messaging,
      ),
    );
  }

  Future<void> createByeNotification() async {
    await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: DateTime.now().millisecondsSinceEpoch.remainder(100000),
        channelKey: 'bye_channel',
        title: 'Good Bye me friend',
        body: 'Sure you want to exit the app?',
        notificationLayout: NotificationLayout.Inbox,
      ),
      actionButtons: [
        NotificationActionButton(
          key: 'closes_the_app',
          label: 'Yes',
        ),
        NotificationActionButton(
          key: 'do_nothing',
          label: 'No',
        ),
      ],
    );
  }
}
