import 'dart:io';

class CheckInternet{
  static Future<bool> checkInternetConnection()async {
    try {
      final result =await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        return true;
      }
      else {
        return false;
      }

    } on SocketException catch (_) {
      return false;
    }
    return false;
  }
}