//Ref: https://firebase.google.com/docs/reference/fcm/rest/v1/projects.messages
class FCMModel {
  FCMModel({
    this.serverKey,
    this.title,
    this.message,
    this.image,
    this.topic,
    this.deviceToken,
    this.priority = "HIGH",
    this.data,
    this.clickAction,
    this.timeToLive = 0,
    this.androidChannel,
    this.dryRun = false,
  });

  String? serverKey;

  String? title;
  String? message;
  String? image;

  String? topic;
  String? deviceToken;

  String priority;
  Map<String, String>? data;

  String? clickAction;
  int timeToLive;
  bool dryRun;
  String? androidChannel;

  Map<String, dynamic> toJson() {
    var messageParams = <String, dynamic>{};

    var params = <String, dynamic>{
      "message": messageParams,
      "validate_only": dryRun,
    };

    if (topic != null && topic?.trim().isNotEmpty == true) {
      messageParams["topic"] = topic;
    } else if (deviceToken != null && deviceToken?.trim().isNotEmpty == true) {
      messageParams["token"] = deviceToken;
    }

    var notification = <String, dynamic>{
      "body": message,
    };

    if (title != null && title?.isNotEmpty == true) {
      notification["title"] = title;
    }

    if (image != null && image?.isNotEmpty == true) {
      notification["image"] = image;
    }

    messageParams["notification"] = notification;
    messageParams["android"] = {
      "priority": priority
    };

    if (data != null && data?.isNotEmpty == true) {
      messageParams["data"] = data;
    }

    if (timeToLive > 0) messageParams["ttl"] = timeToLive;

    return params;
  }

  @override
  String toString() {
    return 'FCMModel{title: $title, message: $message, topic: $topic,'
        ' deviceToken: $deviceToken, priority: $priority, data: $data,'
        ' clickAction: $clickAction, timeToLive: $timeToLive,'
        ' dryRun: $dryRun, androidChannel: $androidChannel}';
  }
}
