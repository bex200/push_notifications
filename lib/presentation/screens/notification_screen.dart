import 'package:flutter/material.dart';
import 'package:test_push_jeleapps/api/firebase_api.dart';
import 'package:test_push_jeleapps/data/model/notification_model.dart';
import 'package:test_push_jeleapps/presentation/utils/time_formatter.dart';

class NotificationScreen extends StatefulWidget {
  final NotificationModel notificationModel;
  final String deviceToken;

  const NotificationScreen({
    super.key,
    required this.notificationModel,
    required this.deviceToken,
  });

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    String formmatedTime =
        formatDateTime(widget.notificationModel.receivedTime);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Notification Details',
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Title: ${widget.notificationModel.title}',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              'Body: ${widget.notificationModel.body}',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              'Received Time: $formmatedTime',
              style: Theme.of(context).textTheme.bodySmall,
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              'Device-Token: ${widget.deviceToken}',
              style: Theme.of(context).textTheme.labelSmall,
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
