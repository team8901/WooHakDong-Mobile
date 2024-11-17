import 'package:logger/logger.dart';

final logger = Logger(
  printer: PrettyPrinter(
    methodCount: 1,
    errorMethodCount: 4,
    lineLength: 160,
    printEmojis: true,
  ),
);
