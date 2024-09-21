import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:fcm_app_tester/data/model/console_response.dart';
import 'package:fcm_app_tester/data/model/firebase_message.dart';
import 'package:fcm_app_tester/data/model/service_account.dart';
import 'package:fcm_app_tester/data/network/call_result.dart';
import 'package:googleapis_auth/auth_io.dart' as auth;
import 'package:logging/logging.dart';

class ConsoleRepository {
  late Dio dio;
  final logger = Logger('ConsoleRepository');

  ConsoleRepository() {
    dio = Dio();
    dio.options.headers['content-Type'] = 'application/json';
    dio.options.responseType = ResponseType.plain;
    dio.options.persistentConnection = true;
  }

  Future<ConsoleResponse> send({
    required FirebaseMessage message,
    required ServiceAccount serviceAccount,
  }) async {
    final url = "https://fcm.googleapis.com/v1/projects/${serviceAccount.projectId}/messages:send";
    dio.options.headers['Authorization'] = 'Bearer ${serviceAccount.accessToken}';

    try {
      final json = message.toJson();
      logger.info("\n$json");
      final response = await dio.post(url, data: json);
      logger.info(response.statusCode);
      logger.info("\n${response.data}");

      return ConsoleResponse(message: response.data, code: response.statusCode ?? 0);
    } on DioException catch (e) {
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
      if (e.response != null) {
        logger.info(e.response?.statusCode);
        logger.info("\n${e.response?.data}");
        return ConsoleResponse(message: e.response?.data, code: e.response?.statusCode ?? 0);
      } else {
        // Something happened in setting up or sending the request that triggered an Error
        logger.info("Something went wrong!");
        return ConsoleResponse(
          message: e.message,
        );
      }
    }
  }

  Future<CallResult<ServiceAccount>> getAccessToken(String json) async {
    Map<String, dynamic>? serviceAccountMap = jsonDecode(json);
    if (serviceAccountMap == null || !serviceAccountMap.containsKey('project_id')) {
      return Failure();
    }

    try {
      final scopes = ["https://www.googleapis.com/auth/firebase.messaging"];
      final accountCredentials = auth.ServiceAccountCredentials.fromJson(jsonDecode(json));
      final credentials = await auth.clientViaServiceAccount(accountCredentials, scopes);
      final accessToken = credentials.credentials.accessToken.data;
      final account = ServiceAccount(
        accessToken: accessToken,
        projectId: serviceAccountMap["project_id"].toString(),
      );
      return Success(account);
    } on Exception catch (e) {
      return Failure(cause: e.toString());
    } catch (e) {
      return Failure(cause: e.toString());
    }
  }
}
