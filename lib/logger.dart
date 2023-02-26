import 'package:logger/logger.dart';

final AppLog logger = AppLog();

class AppLog {
  AppLog() {
    _logger = Logger(
      printer: PrettyPrinter(
          methodCount: 2,
          // number of method calls to be displayed
          errorMethodCount: 8,
          // number of method calls if stacktrace is provided
          lineLength: 120,
          // width of the output
          colors: true,
          // Colorful log messages
          printEmojis: true,
          // Print an emoji for each log message
          printTime: false // Should each log print contain a timestamp
          ),
      // output: MyConsoleOutput(
      //   packageName: packageName,
      // ),
    );
  }

  late Logger _logger;

  @override
  void d(object) {
    _logger.d(object);
  }

  @override
  void e(object, StackTrace s) {
    _logger.e(object, null, s);
  }

  @override
  void i(object) {
    _logger.i(object);
  }

  @override
  void v(object) {
    _logger.v(object);
  }

  @override
  void w(object) {
    _logger.w(object);
  }

  @override
  void wtf(object) {
    _logger.wtf(object);
  }
}
