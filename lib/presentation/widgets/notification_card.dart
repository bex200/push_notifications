import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_push_jeleapps/bloc/notification_bloc/notification_bloc.dart';
import 'package:test_push_jeleapps/data/model/notification_model.dart';
import 'package:test_push_jeleapps/presentation/routes/routes.dart';
import 'package:test_push_jeleapps/presentation/style/colors.dart';
import 'package:test_push_jeleapps/presentation/utils/time_formatter.dart';
import 'package:test_push_jeleapps/presentation/widgets/buttons.dart';

class NotificationCard extends StatefulWidget {
  final NotificationModel notificationModel;
  final String deviceToken;

  const NotificationCard({
    super.key,
    required this.notificationModel,
    required this.deviceToken,
  });

  @override
  _NotificationCardState createState() => _NotificationCardState();
}

class _NotificationCardState extends State<NotificationCard> {
  bool _isDeleting = false;

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    bool isDark = Theme.of(context).brightness == Brightness.dark;

    return TweenAnimationBuilder(
      tween: Tween<double>(begin: _isDeleting ? 1.0 : 0.0, end: _isDeleting ? 0.0 : 1.0),
      duration: const Duration(milliseconds: 300),
      builder: (context, double value, child) {
        return Opacity(
          opacity: value,
          child: Transform.translate(
            offset: Offset(0, (1 - value) * 50), // Slide out effect
            child: child,
          ),
        );
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 24),
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(
              color: isDark
                  ? AppColors.darkBodyMedium
                  : AppColors.darkLableSmall,
            ),
          ),
          color: !widget.notificationModel.isRead
              ? (isDark ? AppColors.darkCardBg : AppColors.lightCardBg)
              : (isDark ? AppColors.darkBg : AppColors.lightBg),
        ),
        child: containerChild(textTheme, context),
      ),
    );
  }

  Widget containerChild(TextTheme textTheme, BuildContext context) {
    String formattedTime = formatTime(widget.notificationModel.receivedTime);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (!widget.notificationModel.isRead)
              Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  color: AppColors.globalAccentBlue,
                  borderRadius: BorderRadius.circular(100),
                ),
              ),
            IconButton(
              style: IconButton.styleFrom(
                shape: const CircleBorder(
                  side: BorderSide(
                    color: AppColors.darkLableSmall
                  )
                )
              ),
              icon: const Icon(Icons.notifications_active_outlined),
              iconSize: 24,
              color: AppColors.darkLableSmall,
              onPressed: () {},
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.notificationModel.title,
                  style: textTheme.bodyMedium,
                ),
                const SizedBox(height: 4),
                Text(
                  widget.notificationModel.body,
                  style: textTheme.bodySmall,
                ),
                const SizedBox(height: 14),
                Row(
                  children: [
                    ButtonWidget(
                      type: ButtonType.primary,
                      text: 'Show',
                      onPressed: () {
                        context.read<NotificationBloc>().add(
                          MarkNotificationAsReadEvent(widget.notificationModel.id),
                        );
                        Navigator.pushNamed(
                          context,
                          AppRoutes.notifications,
                          arguments: {
                            'notificationModel': widget.notificationModel,
                            'deviceToken': widget.deviceToken,
                          },
                        );
                      },
                    ),
                    const SizedBox(width: 14),
                    ButtonWidget(
                      type: ButtonType.secondary,
                      text: 'Delete',
                      onPressed: () {
                        setState(() {
                          _isDeleting = true;
                        });

                        // Delay to let animation finish before deleting
                        Future.delayed(const Duration(milliseconds: 200), () {
                          context.read<NotificationBloc>().add(
                            DeleteNotificationEvent(widget.notificationModel.id),
                          );
                        });
                      },
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
        const SizedBox(width: 12),
        Text(
          formattedTime,
          style: textTheme.labelSmall,
        ),
      ],
    );
  }
}
