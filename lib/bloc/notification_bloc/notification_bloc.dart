import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:meta/meta.dart';
import 'package:test_push_jeleapps/api/firebase_api.dart';
import 'package:test_push_jeleapps/data/model/notification_model.dart';
import 'package:test_push_jeleapps/data/repository/notification_repo.dart';

part 'notification_event.dart';
part 'notification_state.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  final NotificationRepo notificationRepo;
  final FirebaseMessagingApi firebaseMessagingApi;

  NotificationBloc({
    required this.notificationRepo,
    required this.firebaseMessagingApi,
  }) : super(NotificationInitial()) {
    _setupFirebaseMessagingListener();
    on<GetNotificationListEvent>((event, emit) async {
      emit(NotificationLoading());

      // Listen to the Firestore stream
      await emit.forEach<List<NotificationModel>>(
        notificationRepo.getNotificationsStream()!,
        onData: (notificationList) {
          return NotificationsLoaded(notificationList);
        },
        onError: (error, stackTrace) {
          return NotificationLoadingError(error.toString());
        },
      );
    });
    on<GetSingleNotificationEvent>(_onGetSingleNotificationEvent);
    on<DeleteNotificationEvent>(_onDeleteNotificationEvent);
    on<SaveNotificationEvent>(_onSaveNotificationEvent);
    on<MarkNotificationAsReadEvent>(_onMarkNotificationAsReadEvent);
    on<UpdateNotificationsEvent>(_onUpdateNotificationsEvent);
  }

  void _setupFirebaseMessagingListener() {
    firebaseMessagingApi.initializeNotification((RemoteMessage message) {
      final notificationModel = NotificationModel(
        id: '',
        title: message.notification?.title ?? 'No Title',
        body: message.notification?.body ?? 'No Body',
        receivedTime: DateTime.now(),
        isRead: false,
      );

      add(SaveNotificationEvent(notificationModel));

      
    });
  }

  Future<void> _onGetNotificationListEvent(
      GetNotificationListEvent event, Emitter<NotificationState> emit) async {
    try {
      emit(NotificationLoading());
    } catch (e) {
      emit(NotificationLoadingError(e.toString()));
    } finally {}
  }

  Future<void> _onGetSingleNotificationEvent(
      GetSingleNotificationEvent event, Emitter<NotificationState> emit) async {
    try {
      emit(NotificationLoading());
      final notification =
          await notificationRepo.getSingleNotification(event.notificationId);
      emit(NotificationsLoaded([notification!]));
    } catch (e) {
      emit(NotificationLoadingError(e.toString()));
    } finally {}
  }

  Future<void> _onDeleteNotificationEvent(
      DeleteNotificationEvent event, Emitter<NotificationState> emit) async {
    try {
      emit(NotificationLoading());
      await notificationRepo.deleteNotification(event.notificationId);
      // Reload notifications after deletion
      add(GetNotificationListEvent());
    } catch (e) {
      emit(NotificationLoadingError(e.toString()));
    } finally {}
  }

  Future<void> _onSaveNotificationEvent(
      SaveNotificationEvent event, Emitter<NotificationState> emit) async {
    try {
      emit(NotificationLoading());

      await notificationRepo.saveNotification(event.notificationModel);
      // Reload notifications after saving
      add(GetNotificationListEvent());
    } catch (e) {
      emit(NotificationLoadingError(e.toString()));
    } finally {}
  }

  Future<void> _onMarkNotificationAsReadEvent(MarkNotificationAsReadEvent event,
      Emitter<NotificationState> emit) async {
    try {
      emit(NotificationLoading());
      await notificationRepo.markNotificationAsRead(event.notificationId);
      // Reload notifications after marking as read
      add(GetNotificationListEvent());
    } catch (e) {
      emit(NotificationLoadingError(e.toString()));
    } finally {}
  }

  Future<void> _onUpdateNotificationsEvent(
      UpdateNotificationsEvent event, Emitter<NotificationState> emit) async {
    emit(NotificationsUpdated(event.notificationList));
  }
}
