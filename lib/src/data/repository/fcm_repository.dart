import 'dart:async';

import 'package:dio/dio.dart';
import 'package:retrofit/dio.dart';

import '../../data/model/fcm_model.dart';
import '../../data/model/fcm_response.dart';
import '../../data/remote/fcm_client.dart';

class FCMRepository {
  final FCMClient _fcmClient = FCMClient(Dio());

  final _controller = StreamController<String>();

  Stream<String> get status async* {
    yield* _controller.stream;
  }

  Future<HttpResponse<FCMResponse>> send(FCMModel model) async {
    assert(model != null);

    return _fcmClient.send("key=${model.serverKey}", model);
  }

  void dispose() => _controller.close();
}
