import 'dart:convert';

import 'package:googleapis_auth/auth_io.dart';

class GoogleAuth {
  static final scopes = ["https://www.googleapis.com/auth/firebase.messaging"];

  static Future<String> getAccessToken(String serviceAccountJson) async {
    final accountCredentials = ServiceAccountCredentials.fromJson(jsonDecode(serviceAccountJson));
    final credentials = await clientViaServiceAccount(accountCredentials, scopes);
    final accessToken = credentials.credentials.accessToken.data;
    return accessToken;
  }
}
