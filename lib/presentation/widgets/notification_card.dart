import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_push_jeleapps/bloc/notification_bloc/notification_bloc.dart';
import 'package:test_push_jeleapps/data/model/notification_model.dart';
import 'package:test_push_jeleapps/presentation/routes/routes.dart';
import 'package:test_push_jeleapps/presentation/style/colors.dart';
import 'package:test_push_jeleapps/presentation/utils/time_formatter.dart';
import 'package:test_push_jeleapps/presentation/widgets/buttons.dart';

class NotificationCard extends StatelessWidget {
  final NotificationModel notificationModel;

  const NotificationCard({
    super.key,
    required this.notificationModel,
  });

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    bool isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 24),
      decoration: BoxDecoration(
        border: Border(
            top: BorderSide(
                color:
                    isDark ? AppColors.darkBodyMedium : AppColors.darkLableSmall)),
        color: !notificationModel.isRead
            ? (isDark ? AppColors.darkCardBg : AppColors.lightCardBg)
            : (isDark ? AppColors.darkBg : AppColors.lightBg),
      ),
      child: containerChild(textTheme, context),
    );
  }

  Widget containerChild(TextTheme textTheme, BuildContext context) {
    String formattedTime = formatTime(notificationModel.receivedTime);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (!notificationModel.isRead)
              Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  color: AppColors.globalAccentBlue,
                  borderRadius: BorderRadius.circular(100),
                ),
              ),
            IconButton.filled(
                style: IconButton.styleFrom(
                    backgroundColor: AppColors.lightBodyMedium),
                onPressed: () {},
                iconSize: 24,
                color: AppColors.darkLableSmall,
                icon: const Icon(
                  Icons.notifications_active_outlined,
                )),
            const SizedBox(
              width: 12,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  notificationModel.title,
                  style: textTheme.bodyMedium,
                ),
                const SizedBox(height: 4),
                Text(
                  notificationModel.body,
                  style: textTheme.bodySmall,
                ),
                const SizedBox(height: 14),
                Row(
                  children: [
                    ButtonWidget(
                        type: ButtonType.primary,
                        text: 'Show',
                        onPressed: () {
                          print(notificationModel.id);
                          context.read<NotificationBloc>().add(
                              MarkNotificationAsReadEvent(
                                  notificationModel.id));
                          Navigator.pushNamed(context, AppRoutes.notifications,
                              arguments: notificationModel);
                        }),
                    const SizedBox(width: 14),
                    ButtonWidget(
                        type: ButtonType.secondary,
                        text: 'Delete',
                        onPressed: () {
                          context.read<NotificationBloc>().add(
                              DeleteNotificationEvent(notificationModel.id));
                        }),
                  ],
                )
              ],
            ),
          ],
        ),
        const SizedBox(
          width: 12,
        ),
        Text(
          formattedTime,
          style: textTheme.labelSmall,
        ),
      ],
    );
  }
}
