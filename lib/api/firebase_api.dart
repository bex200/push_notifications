import 'package:firebase_messaging/firebase_messaging.dart';

class FirebaseMessagingApi {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  Future<String> getDeviceToken() async {
    return (await _firebaseMessaging.getToken())!;
  }

  Future<void> initializeNotification(
      Function(RemoteMessage) onMessageReceived) async {
    await _firebaseMessaging.requestPermission();

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      if (message.notification != null) {
        onMessageReceived(message);
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      onMessageReceived(message);
    });

    // Handle notification when app is launched from a terminated state
    RemoteMessage? initialMessage =
        await _firebaseMessaging.getInitialMessage();
    if (initialMessage != null) {
      onMessageReceived(initialMessage);
    }
  }
}
