// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fcm_client.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

class _FCMClient implements FCMClient {
  _FCMClient(this._dio, {this.baseUrl}) {
    ArgumentError.checkNotNull(_dio, '_dio');
    baseUrl ??= 'https://fcm.googleapis.com/fcm/';
  }

  final Dio _dio;

  String baseUrl;

  @override
  Future<HttpResponse<FCMResponse>> send(token, model) async {
    ArgumentError.checkNotNull(token, 'token');
    ArgumentError.checkNotNull(model, 'model');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(model?.toJson() ?? <String, dynamic>{});
    _data.removeWhere((k, v) => v == null);
    final _result = await _dio.request('/send',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{r'Authorization': token},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = FCMResponse.fromJson(_result.data);
    final httpResponse = HttpResponse(value, _result);
    return httpResponse;
  }
}
