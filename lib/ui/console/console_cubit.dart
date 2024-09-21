import 'package:fcm_app_tester/data/model/firebase_message.dart';
import 'package:fcm_app_tester/data/model/message_duration.dart';
import 'package:fcm_app_tester/data/model/service_account.dart';
import 'package:fcm_app_tester/data/network/call_result.dart';
import 'package:fcm_app_tester/data/network/console_repository.dart';
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

  MessageDuration duration = MessageDuration.weeks;
  int durationValue = 0;

  final Map<TextEditingController, TextEditingController> customData = {};

  late ConsoleRepository repository;

  ConsoleCubit() : super(ConsoleInitialState()) {
    repository = ConsoleRepository();
  }

  send() async {
    if (!_isValidForm()) return;

    emit(ConsoleLoadingState());

    final json = serviceAccountController.text;
    final result = await repository.getAccessToken(json);
    if (result is Failure<ServiceAccount>) {
      emit(ConsoleResultState(error: result.cause ?? "", code: result.code));
    } else if (result is Success<ServiceAccount>) {
      final response = await repository.send(
        message: _firebaseMessage(),
        serviceAccount: result.data,
      );
      logger.info(response.message);
      emit(ConsoleResultState(error: response.message ?? "", code: response.code));
    }
  }

  bool _isValidForm() {
    final notificationState = notificationFormKey.currentState?.validate();
    final targetState = targetFormKey.currentState?.validate();
    final additionalOptionState = additionalOptionFormKey.currentState?.validate();

    final isValidForm =
        targetState == true && notificationState == true && additionalOptionState == true;

    if (!isValidForm) {
      logger.warning(
        "Form validation failed: "
        "targetState == $targetState "
        "&& notificationState == $notificationState "
        "&& additionalOptionState == $additionalOptionState",
      );
    }

    return isValidForm;
  }

  FirebaseMessage _firebaseMessage() {
    var data = <String, String>{};
    customData.forEach((key, value) {
      if (key.text.isNotEmpty) {
        data[key.text.trim()] = value.text.trim();
      }
    });

    return FirebaseMessage(
      validateOnly: false,
      message: Message(
        topic: topicController.text.trim(),
        token: tokenController.text.trim(),
        notification: NotificationData(
          title: titleController.text.trim(),
          body: textController.text.trim(),
          image: imageController.text.trim(),
        ),
        android: AndroidConfig(
          ttl: duration.getDuration(durationValue).inSeconds
        ),
        data: data,
      ),
    );
  }
}
