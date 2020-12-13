
//Ref: https://firebase.google.com/docs/reference/fcm/rest/v1/projects.messages
class FCMModel {
  FCMModel({
    this.title,
    this.message,
    this.to,
    this.ids,
    this.priority = "normal",
    this.data,
    this.clickAction = "firebase_fcm_tester",
    this.dryRun,
    this.timeToLive,
  });

  String title;
  String message;

  String to;
  List<String> ids;

  //"normal" and "high."
  String priority;
  Map<String, String> data;

  String clickAction;
  int timeToLive;
  bool dryRun;

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

    if (to != null) params["to"] = to;
    if (ids != null) params["registration_ids"] = ids;
    if (timeToLive > 0) params["time_to_live"] = timeToLive;

    return params;
  }
}
