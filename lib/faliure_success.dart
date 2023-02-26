import 'logger.dart';

class Failure {
  final dynamic message;

  Failure(this.message) {
    logger.e(message, StackTrace.current);
  }
}

class Success {
  final dynamic response;
  Success({this.response});
}
