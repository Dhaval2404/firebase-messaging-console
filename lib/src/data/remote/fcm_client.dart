import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../data/model/fcm_model.dart';
import '../../data/model/fcm_response.dart';

part 'fcm_client.g.dart';

///flutter pub run build_runner build --delete-conflicting-outputs
@RestApi(baseUrl: "https://fcm.googleapis.com/fcm/")
abstract class FCMClient {
  factory FCMClient(Dio dio, {String baseUrl}) {
    dio.options = BaseOptions(receiveTimeout: 5000, connectTimeout: 5000);
    dio.options.headers["Content-Type"] =
        "application/json"; // config your dio headers globally
    return _FCMClient(dio, baseUrl: baseUrl);
  }

  @POST("/send")
  Future<HttpResponse<FCMResponse>> send(
      @Header("Authorization") String token, @Body() FCMModel model);
}
