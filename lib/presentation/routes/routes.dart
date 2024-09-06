import 'package:flutter/material.dart';
import 'package:test_push_jeleapps/data/model/notification_model.dart';
import 'package:test_push_jeleapps/presentation/screens/home_screen.dart';
import 'package:test_push_jeleapps/presentation/screens/notification_screen.dart';

class AppRoutes {
  static const String home = '/';
  static const String notifications = '/notifications';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case home:
        return MaterialPageRoute(builder: (_) => HomeScreen());
      case notifications:
        final NotificationModel notificationModel =
            settings.arguments as NotificationModel;
            print(settings.arguments);
        return MaterialPageRoute(
          builder: (_) => NotificationScreen(notificationModel: notificationModel),
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
