import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:fcm_app_tester/data/fcm_model.dart';
import 'package:fcm_app_tester/util/google_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logging/logging.dart';

import 'state/console_state.dart';

class ConsoleCubit extends Cubit<ConsoleState> {
  final logger = Logger('FirebaseConsole');

  final targetFormKey = GlobalKey<FormState>();
  final notificationFormKey = GlobalKey<FormState>();
  final dataFormKey = GlobalKey<FormState>();
  final additionalOptionFormKey = GlobalKey<FormState>();

  final serviceAccountController = TextEditingController();
  final titleController = TextEditingController();
  final textController = TextEditingController();

  final topicController = TextEditingController();
  final tokenController = TextEditingController();

  final imageController = TextEditingController();

  final Map<TextEditingController, TextEditingController> customData = {};

  ConsoleCubit() : super(ConsoleInitialState());

  validate() {
    var notificationState = notificationFormKey.currentState?.validate();
    var targetState = targetFormKey.currentState?.validate();
    var additionalOptionState = additionalOptionFormKey.currentState?.validate();
    if (targetState == true && notificationState == true && additionalOptionState == true) {
      try {
        _sendMessage();
      } on Exception catch (exception, stacktrace) {
        logger.info("Error: $exception \nStacktrace: $stacktrace");
      } catch (error, stacktrace) {
        logger.info("Error: $error \nStacktrace: $stacktrace");
      }
    }
  }

  _sendMessage() async {
    logger.warning("_sendMessage");
    emit(ConsoleLoadingState());

    var serviceAccountJson = serviceAccountController.text;
    Map<String, dynamic>? serviceAccountMap = jsonDecode(serviceAccountJson);
    if (serviceAccountMap == null || !serviceAccountMap.containsKey('project_id')) {
      emit(ConsoleResultState(error: "Please provide valid service account json", code: 10));
      logger.warning("Please provide valid service account json");
      return;
    }

    final projectId = serviceAccountMap["project_id"];

    String accessToken;
    try{
       accessToken = await GoogleAuth.getAccessToken(serviceAccountController.text);
       if (accessToken.isEmpty) {
         emit(ConsoleResultState(error: "Please provide valid service account json", code: 11));
         logger.warning("provide provide valid service account json");
         return;
       }
    } on Exception catch (e) {
      emit(ConsoleResultState(error: e.toString(), code: 12));
      logger.warning(e.toString());
      return;
    } catch (e) {
      emit(ConsoleResultState(error: e.toString(), code: 13));
      logger.warning(e.toString());
      return;
    }

    final url = "https://fcm.googleapis.com/v1/projects/$projectId/messages:send";
    final dio = Dio();
    dio.options.headers['Authorization'] = 'Bearer  $accessToken';
    dio.options.headers['content-Type'] = 'application/json';
    dio.options.responseType = ResponseType.plain;
    dio.options.persistentConnection = true;
    dio.options.persistentConnection = true;

    var data = <String, String>{};
    customData.forEach((key, value) {
      if (key.text.isNotEmpty) {
        data[key.text.trim()] = value.text.trim();
      }
    });

    final fcmModel = FCMModel(
      title: titleController.text.trim(),
      message: textController.text.trim(),
      image: imageController.text.trim(),
      topic: topicController.text.trim(),
      deviceToken: tokenController.text.trim(),
      data: data,
    );

    JsonEncoder encoder = const JsonEncoder.withIndent('  ');
    String prettyprint = encoder.convert(fcmModel.toJson());
    logger.info("\n$prettyprint");

    try {
      final response = await dio.post(url, data: fcmModel.toJson());
      logger.info(response.statusCode);
      logger.info("\n${response.data}");
      emit(ConsoleResultState(error: response.data, code: response.statusCode ?? 0));
    } on DioException catch (e) {
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
      if (e.response != null) {
        logger.info(e.response?.statusCode);
        logger.info("\n${e.response?.data}");
        emit(ConsoleResultState(error: e.response?.data, code: e.response?.statusCode ?? 0));
      } else {
        // Something happened in setting up or sending the request that triggered an Error
        logger.info("Something went wrong!");
        emit(ConsoleResultState(error: "Something went wrong!", code: 14));
      }


    }
  }
}
