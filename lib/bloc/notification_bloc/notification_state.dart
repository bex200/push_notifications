part of 'notification_bloc.dart';

@immutable
sealed class NotificationState {}

final class NotificationInitial extends NotificationState {}

final class NotificationsLoaded extends NotificationState {
  final List<NotificationModel> notificationList;

  NotificationsLoaded(this.notificationList);
}

final class NotificationsUpdated extends NotificationState {
  final List<NotificationModel> notificationList;

  NotificationsUpdated(this.notificationList);
}

final class NotificationLoading extends NotificationState {}

final class NotificationLoadingError extends NotificationState {
  final String errorMessage;

  NotificationLoadingError(this.errorMessage);
}
