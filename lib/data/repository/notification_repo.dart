import 'package:test_push_jeleapps/data/model/notification_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class NotificationRepo {
  final FirebaseFirestore firestoreInstance = FirebaseFirestore.instance;
  final String collectionPath = 'notifications';
  final CollectionReference _notificationCollection =
      FirebaseFirestore.instance.collection('notifications');
  //fetch allll notifications
  Stream<List<NotificationModel>>? getNotificationsStream() {
    try {
      return _notificationCollection.snapshots().map((snapshot) {
        return snapshot.docs
            .map((doc) =>
                NotificationModel.fromJson(doc.data() as Map<String, dynamic>))
            .toList();
      });
    } catch (e) {
      print(e.toString());
    }
    return null;
  }
  // write new notifications to firestore +++

  Future<void> saveNotification(NotificationModel notificationModel) async {
    notificationModel.id = firestoreInstance.collection(collectionPath).doc().id;
    try {
      await firestoreInstance
          .collection(collectionPath)
          .doc(notificationModel.id)
          .set(notificationModel.toJson());
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> deleteNotification(String notificationId) async {
    try {
      await firestoreInstance
          .collection(collectionPath)
          .doc(notificationId)
          .delete();
    } catch (e) {
      print(e.toString());
    }
  }

  Future<NotificationModel?> getSingleNotification(
      String notificationId) async {
    try {
      DocumentSnapshot notification = await firestoreInstance
          .collection(collectionPath)
          .doc(notificationId)
          .get();
      return NotificationModel.fromJson(
          notification.data() as Map<String, dynamic>);
    } catch (e) {
      print(e.toString());
    }
    return null;
  }

  Future<void> markNotificationAsRead(String notificationId) async {
    try {
      await firestoreInstance
          .collection(collectionPath)
          .doc(notificationId)
          .update({'isRead': true});
    } catch (e) {
      print(e.toString());
    }
  }
}
