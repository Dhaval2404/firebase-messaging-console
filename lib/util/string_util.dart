import 'dart:convert';

class StringUtil {

  static bool isValidUrl(String url) {
    try {
      Uri uri = Uri.parse(url);
      // Check if the URI has a valid scheme (http or https)
      return (uri.scheme == 'http' || uri.scheme == 'https') && uri.host.isNotEmpty;
    } catch (e) {
      return false;
    }
  }

  static String? tryEncode(data) {
    try {
      return jsonEncode(data);
    } catch (e) {
      return null;
    }
  }

  static dynamic tryDecode(data) {
    try {
      return jsonDecode(data);
    } catch (e) {
      return null;
    }
  }
}