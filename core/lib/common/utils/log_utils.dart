import 'dart:convert';
import 'package:logger/logger.dart';

import '../config.dart';

class MyFilter extends LogFilter {
  @override
  bool shouldLog(LogEvent event) {
    return true;
  }
}

class LogUtils {
  static final LogPrinter printer = PrettyPrinter(
    printTime: false,
    errorMethodCount: 16,
    printEmojis: false,
    colors: false,
  );

  static final LogPrinter noStackPrinter = PrettyPrinter(
    printTime: false,
    methodCount: 0,
    printEmojis: false,
    colors: false,
  );

  static final logs = <AppLog>[];

  static final Logger _logger = Logger(
    filter: MyFilter(),
    printer: printer,
  );

  static final Logger _loggerNoStackDebug = Logger(
    printer: noStackPrinter,
  );

  static final Logger _loggerNoStack = Logger(
    filter: MyFilter(),
    printer: noStackPrinter,
  );

  static String prettyprint(dynamic message){
    const encoder = JsonEncoder.withIndent('  ');
    return encoder.convert(message);
  }

  static void d(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    _appendLog(message, Level.debug, error, stackTrace);
    if (Config.instance.appConfig.developmentMode == true) {
      _loggerNoStackDebug.d(prettyprint(message), error: error, stackTrace: stackTrace);
    }
  }

  static void e(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    _appendLog(message, Level.error, error, stackTrace);
    if (Config.instance.appConfig.developmentMode == true) {
      _logger.e(prettyprint(message), error: error, stackTrace: stackTrace);
    }
  }

  static T? eCatch<T>(
    dynamic message, [
    dynamic error,
    StackTrace? stackTrace,
  ]) {
    _appendLog(message, Level.warning, error, stackTrace);
    if (Config.instance.appConfig.developmentMode == true) {
      _logger.w(prettyprint(message), error: error, stackTrace: stackTrace);
    }
    return null;
  }

  static void i(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    _appendLog(message, Level.info, error, stackTrace);
    if (Config.instance.appConfig.developmentMode == true) {
      _loggerNoStack.i(prettyprint(message), error: error, stackTrace: stackTrace);
    }
  }

  static void w(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    _appendLog(message, Level.warning, error, stackTrace);
    if (Config.instance.appConfig.developmentMode == true) {
      _loggerNoStack.w(prettyprint(message), error: error, stackTrace: stackTrace);
    }
  }

  static void _appendLog(
    dynamic message,
    Level level, [
    dynamic error,
    StackTrace? stackTrace,
  ]) {
    if (!Config.instance.appConfig.isDevBuild) {
      return;
    }
    const limitLogs = 50;

    if (logs.length == limitLogs) {
      logs.removeAt(0);
    }

    logs.add(AppLog(message, level, error, stackTrace));
  }
}

class AppLog {
  final dynamic message;
  final dynamic error;
  final StackTrace? stackTrace;
  final Level level;

  AppLog(this.message, this.level, [this.error, this.stackTrace]);

  List<String> get logStrings {
    final logEvent =
        LogEvent(level, message, error: error, stackTrace: stackTrace);
    switch (level) {
      case Level.error:
        return LogUtils.printer.log(logEvent);
      default:
        return LogUtils.noStackPrinter.log(logEvent);
    }
  }
}
