
//Ref: https://firebase.google.com/docs/cloud-messaging/http-server-ref#error-codes
class FCMResponse {
  FCMResponse({
    this.multicastId,
    this.success,
    this.failure,
    this.canonicalIds,
    this.results,
  });

  int multicastId;
  int success;
  int failure;
  int canonicalIds;
  List<FCMResponseResult> results;

  factory FCMResponse.fromJson(Map<String, dynamic> json) => FCMResponse(
        multicastId: json["multicast_id"],
        success: json["success"],
        failure: json["failure"],
        canonicalIds: json["canonical_ids"],
        results: List<FCMResponseResult>.from(
            json["results"].map((x) => FCMResponseResult.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
    "multicast_id": multicastId,
    "success": success,
    "failure": failure,
    "canonical_ids": canonicalIds,
    "results": List<dynamic>.from(results.map((x) => x.toJson())),
  };
}

class FCMResponseResult {
  FCMResponseResult({
    this.messageId,
    this.error,
  });

  String error;
  String messageId;

  factory FCMResponseResult.fromJson(Map<String, dynamic> json) =>
      FCMResponseResult(
        error: json["error"],
        messageId: json["message_id"],
      );

  Map<String, dynamic> toJson() => {
    "error": error,
    "message_id": messageId,
  };
}
