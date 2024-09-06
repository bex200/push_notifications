import 'package:flutter/material.dart';
import 'package:test_push_jeleapps/data/model/notification_model.dart';
import 'package:test_push_jeleapps/presentation/screens/home_screen.dart';
import 'package:test_push_jeleapps/presentation/screens/notification_screen.dart';

class AppRoutes {
  static const String home = '/home';
  static const String notifications = '/notifications';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case home:
        final Map argsMap = settings.arguments as Map;
        return MaterialPageRoute(
            builder: (_) => HomeScreen(
                  deviceToken: argsMap['deviceToken'],
                ));
      case notifications:
        final Map argsMap = settings.arguments as Map;
        final NotificationModel notificationModel = argsMap['notificationModel'];
        final String deviceToken = argsMap['deviceToken'];
        print(argsMap);
        return MaterialPageRoute(
          builder: (_) => NotificationScreen(
            notificationModel: notificationModel,
            deviceToken: deviceToken,
          ),
        );
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('Can`t find anything for ${settings.name} :('),
            ),
          ),
        );
    }
  }
}
