//Ref: https://firebase.google.com/docs/reference/fcm/rest/v1/projects.messages
class FCMModel {
  FCMModel(
      {this.title,
      this.message,
      this.topic,
      this.ids,
      this.priority = "normal",
      this.data,
      this.clickAction = "firebase_fcm_tester",
      this.dryRun,
      this.timeToLive,
      this.androidChannel});

  String title;
  String message;

  String topic;
  List<String> ids;

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
        "title": title,
        "body": message,
        "click_action": clickAction
      },
      "data": data,
      "dry_run": dryRun,
    };

    if (topic != null && topic.trim().isNotEmpty) {
      params["to"] = "/topics/$topic";
    }

    if (ids != null) params["registration_ids"] = ids;
    if (timeToLive > 0) params["time_to_live"] = timeToLive;

    return params;
  }

  @override
  String toString() {
    return 'FCMModel{title: $title, message: $message, topic: $topic, ids: $ids, priority: $priority, data: $data, clickAction: $clickAction, timeToLive: $timeToLive, dryRun: $dryRun, androidChannel: $androidChannel}';
  }
}
