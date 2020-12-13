import 'package:dio/dio.dart';
import 'package:firebase_messaging_tester/src/data/model/fcm_model.dart';
import 'package:firebase_messaging_tester/src/data/model/fcm_response.dart';
import 'package:firebase_messaging_tester/src/data/remote/fcm_client.dart';
import 'package:retrofit/retrofit.dart';

class FCMService {
  FCMClient _fcmClient;

  static final FCMService _singleton = FCMService._internal();

  factory FCMService() {
    return _singleton;
  }

  FCMService._internal() {
    final dio = Dio(); // Provide a dio instance
    _fcmClient = FCMClient(dio);
  }

  Future<HttpResponse<FCMResponse>> send(String token, FCMModel model) async {
    return _fcmClient.send("key=" + token, model);
  }

}
