//Ref: https://firebase.google.com/docs/cloud-messaging/http-server-ref#error-codes
class FCMResponse {
  FCMResponse({
    this.multicastId,
    this.success,
    this.failure,
    this.canonicalIds,
    this.results,
    this.messageId,
  });

  int multicastId;
  int success;
  int failure;
  int canonicalIds;
  int messageId;
  List<FCMResponseResult> results;

  factory FCMResponse.fromJson(Map<String, dynamic> json) {
    var response = FCMResponse(
      multicastId: json["multicast_id"],
      success: json["success"],
      failure: json["failure"],
      canonicalIds: json["canonical_ids"],
      messageId: json["message_id"],
    );

    if (json.containsKey("results")) {
      response.results = List<FCMResponseResult>.from(
          json["results"].map((x) => FCMResponseResult.fromJson(x)));
    }

    return response;
  }

  Map<String, dynamic> toJson() {
    var params = <String, dynamic>{};
    if (multicastId != null) params["multicast_id"] = multicastId;
    if (success != null) params["success"] = success;
    if (failure != null) params["failure"] = failure;
    if (canonicalIds != null) params["canonical_ids"] = canonicalIds;
    if (messageId != null) params["message_id"] = messageId;
    if (results != null) {
      params["results"] = List<dynamic>.from(results.map((x) => x.toJson()));
    }
    return params;
  }

  @override
  String toString() {
    return 'FCMResponse{multicastId: $multicastId, success: $success,'
        ' failure: $failure, canonicalIds: $canonicalIds, results: $results}';
  }
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

  Map<String, dynamic> toJson() {
    var param = <String, dynamic>{};
    if (error != null) {
      param["error"] = error;
    }
    if (messageId != null) {
      param["message_id"] = messageId;
    }
    return param;
  }

  @override
  String toString() {
    return 'FCMResponseResult{error: $error, messageId: $messageId}';
  }
}
