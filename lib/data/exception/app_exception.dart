class AppException implements Exception {
  final _prefix;
  final _message;

  AppException([this._prefix, this._message]);

  @override
  String toString() {
    return "$_message$_prefix";
  }
}

class NoInternetConnection extends AppException {
  NoInternetConnection([String? message])
      : super(message, "No Internet Connection");
}

class RequestionTimeOut extends AppException {
  RequestionTimeOut([String? message]) : super(message, "Requestion Time Out");
}

class InternalServerException extends AppException {
  InternalServerException([String? message])
      : super(message, "Internal Server Error");
}
