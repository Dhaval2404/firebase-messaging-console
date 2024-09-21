// Firebase Messaging Reference
//  https://firebase.google.com/docs/reference/fcm/rest/v1/projects.messages

import 'dart:convert';

class FirebaseMessage {
  final Message? message;
  final bool validateOnly;

  FirebaseMessage({
    this.message,
    this.validateOnly = false,
  });

  Map<String, dynamic> toJson() => {
        "validate_only": validateOnly,
        "message": message?.toJson(),
      };

  String getJson() {
    return json.encode(this);
  }
}

class Message {
  final String? topic;
  final String? token;
  final NotificationData notification;
  final Map<String, String>? data;
  final AndroidConfig? android;

  Message({
    required this.topic,
    required this.token,
    required this.notification,
    this.data,
    this.android,
  });

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map["notification"] = notification.toJson();

    if (topic != null && topic?.isNotEmpty == true) map["topic"] = topic;
    if (token != null && token?.isNotEmpty == true) map["token"] = token;
    if (data != null && data?.isNotEmpty == true) map["data"] = data;
    if (android != null) map["android"] = android?.toJson();
    return map;
  }
}

class NotificationData {
  final String body;
  final String? title;
  final String? image;

  NotificationData({
    required this.body,
    this.title,
    this.image,
  });

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map["body"] = body;
    if (title != null && title?.isNotEmpty == true) map["title"] = title;
    if (image != null && image?.isNotEmpty == true) map["image"] = image;
    return map;
  }
}

class AndroidConfig {
  // clickAction, androidChannel
  final String priority;
  final int ttl;

  AndroidConfig({
    this.priority = "HIGH",
    this.ttl = 0,
  });

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map["priority"] = priority;
    // map["ttl"] = ttl;
    return map;
  }
}
