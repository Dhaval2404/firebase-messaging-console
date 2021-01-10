//Ref: https://firebase.google.com/docs/reference/fcm/rest/v1/projects.messages
class FCMModel {
  FCMModel({
    this.serverKey,
    this.title,
    this.message,
    this.topic,
    this.ids,
    this.priority = "normal",
    this.data,
    this.clickAction = "firebase_fcm_tester",
    this.timeToLive,
    this.androidChannel,
    this.dryRun = false,
  });

  String title;
  String message;

  String topic;
  List<String> ids;
  String serverKey;

  //"normal" and "high."
  String priority;
  Map<String, String> data;

  String clickAction;
  int timeToLive;
  bool dryRun;
  String androidChannel;

  Map<String, dynamic> toJson() {
    var params = <String, dynamic>{
      "priority": priority,
      "notification": {
        "body": message,
      },
      "dry_run": dryRun,
    };

    var notification = <String, dynamic>{
      "body": message,
    };
    if (title != null && title.isNotEmpty) {
      params["title"] = title;
    }
    if (clickAction != null && clickAction.isNotEmpty) {
      params["click_action"] = clickAction;
    }
    params["notification"] = notification;

    if (data != null && data.isNotEmpty) {
      params["data"] = data;
    }

    if (topic != null && topic.isNotEmpty) {
      // params["to"] = "/topics/$topic";
    } else if (ids != null && ids.isNotEmpty) {
      params["registration_ids"] = ids;
    }

    if (androidChannel != null && androidChannel.isNotEmpty) {
      params["android"] = {
        "notification": {"channel_id": androidChannel}
      };
    }

    if (timeToLive > 0) params["time_to_live"] = timeToLive;

    print(params.toString());

    return params;
  }

  @override
  String toString() {
    return 'FCMModel{title: $title, message: $message, topic: $topic,'
        ' ids: $ids, priority: $priority, data: $data,'
        ' clickAction: $clickAction, timeToLive: $timeToLive,'
        ' dryRun: $dryRun, androidChannel: $androidChannel}';
  }
}
