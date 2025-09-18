import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class LoggerService {
  // сырттан қолдану үшін статикалық интерфейс
  static final _core = _LoggerCore();

  /// міндетті түрде қосымшаның басында init шақырыңдар:
  /// await LoggerService.init();
  static Future<void> init({String fileName = 'events_log.txt'}) => _core.init(fileName: fileName);

  /// Қарапайым event жазу
  static void logEvent(String eventName, [Map<String, dynamic>? data]) {
    _core.logEvent(eventName, data);
  }

  /// Таза мәтін жазу
  static void logRaw(String line) => _core.logRaw(line);

  /// Қолданба жабылғанда шақыр
  static Future<void> dispose() => _core.dispose();

  /// UI-да файл жолын көрсету үшін
  static String? get logFilePath => _core.logFilePath;
}

class _LoggerCore {
  IOSink? _sink;
  final _queue = StreamController<String>(sync: true);
  File? _logFile;
  bool _initialized = false;
  Completer<void>? _initCompleter;

  Future<void> init({String fileName = 'events_log.txt'}) {
    if (_initialized) return Future.value();
    if (_initCompleter != null) return _initCompleter!.future;

    _initCompleter = Completer<void>();
    _initialize(fileName).then((_) {
      _initialized = true;
      _initCompleter?.complete();
    }).catchError((e, st) {
      _initCompleter?.completeError(e, st);
    });

    return _initCompleter!.future;
  }

  Future<void> _initialize(String fileName) async {
    Directory dir;
    try {
      dir = await getApplicationSupportDirectory();
    } catch (_) {
      // fallback: HOME/USERPROFILE
      final home = Platform.environment['USERPROFILE'] ?? Platform.environment['HOME'] ?? '.';
      dir = Directory(home);
    }

    _logFile = File('${dir.path}${Platform.pathSeparator}$fileName');

    if (!await _logFile!.parent.exists()) {
      await _logFile!.parent.create(recursive: true);
    }

    _sink = _logFile!.openWrite(mode: FileMode.append, encoding: utf8);

    // queue-дан келген жолдарды жазу
    _queue.stream.listen((line) {
      try {
        _sink?.writeln(line);
      } catch (_) {
        // swallow — файл жазуда қате, қажет болса қосымша өңдеуге шығару
      }
    }, onError: (_) {
      // handle if needed
    }, onDone: () {
      // when queue closed
    });
  }

  void logEvent(String eventName, [Map<String, dynamic>? data]) {
    final record = {
      'ts': DateTime.now().toUtc().toIso8601String(),
      'event': eventName,
      'data': data ?? {}
    };
    final line = jsonEncode(record);

    // егер 아직 инициализатция болмаса — бастау үшін шақырып қою (lazy init)
    if (!_initialized && _initCompleter == null) {
      // Инициализация фондық түрде басталады — бірақ толық дайын болмағанша жазбалар queue-да тұрады
      init().catchError((_) {});
    }

    if (!_queue.isClosed) {
      _queue.add(line);
    }
  }

  void logRaw(String line) {
    if (!_initialized && _initCompleter == null) {
      init().catchError((_) {});
    }
    if (!_queue.isClosed) _queue.add(line);
  }

  Future<void> dispose() async {
    try {
      await _queue.close();
      await _sink?.flush();
      await _sink?.close();
    } catch (_) {}
    _initialized = false;
    _initCompleter = null;
  }

  String? get logFilePath => _logFile?.path;
}
