import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class NotificationModel extends Equatable {
  String id;
  final String title;
  final String body;
  final DateTime receivedTime;
  final bool isRead;

  NotificationModel({
    required this.id,
    required this.title,
    required this.body,
    required this.receivedTime,
    this.isRead = false,
  });

  NotificationModel markAsRead() => NotificationModel(
        id: id,
        title: title,
        body: body,
        receivedTime: receivedTime,
        isRead: true,
      );

  @override
  List<Object?> get props => [id, title, body, receivedTime, isRead];

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      id: json['id'] as String,
      title: json['title'] as String,
      body: json['body'] as String,
      receivedTime: (json['receivedTime'] as Timestamp).toDate(),
      isRead: json['isRead'] as bool,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'body': body,
      'receivedTime': Timestamp.fromDate(receivedTime),
      'isRead': isRead,
    };
  }
}
