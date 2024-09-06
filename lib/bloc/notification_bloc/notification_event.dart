part of 'notification_bloc.dart';

@immutable
sealed class NotificationEvent extends Equatable {
  const NotificationEvent();

  @override
  List<Object> get props => [];
}

class GetNotificationListEvent extends NotificationEvent {}

class GetSingleNotificationEvent extends NotificationEvent {
  final String notificationId;

  const GetSingleNotificationEvent(this.notificationId);

  @override
  List<Object> get props => [notificationId];
}

class DeleteNotificationEvent extends NotificationEvent {
  final String notificationId;

  const DeleteNotificationEvent(this.notificationId);

  @override
  List<Object> get props => [notificationId];
}

class SaveNotificationEvent extends NotificationEvent {
  final NotificationModel notificationModel;

  const SaveNotificationEvent(this.notificationModel);

  @override
  List<Object> get props => [notificationModel];
}

class MarkNotificationAsReadEvent extends NotificationEvent {
  final String notificationId;

  const MarkNotificationAsReadEvent(this.notificationId);

  @override
  List<Object> get props => [notificationId];
}

class UpdateNotificationsEvent extends NotificationEvent {
  final List<NotificationModel> notificationList;

  const UpdateNotificationsEvent(this.notificationList);

  @override
  List<Object> get props => [notificationList];
}
