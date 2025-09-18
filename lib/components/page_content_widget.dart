import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:ps_list/ps_list.dart';

class PageContentWidget extends StatefulWidget {
  const PageContentWidget({super.key});

  @override
  State<PageContentWidget> createState() => _PageContentWidgetState();
}

class _PageContentWidgetState extends State<PageContentWidget> {
  Timer? _monitorTimer;
  bool _isAppRunning = false;
  bool _isChecking = false; // реентранттық тексеруді болдырмау үшін

  final String _processName = 'CalculatorApp.exe'; // қажет болса өзгерт
  final Duration _pollInterval = const Duration(seconds: 1);

  Future<void> _getAllProcesses() async {
    final processes = await PSList.getRunningProcesses();
    for (var element in processes) {
      log(element);
    }
  }

  /// ps_list арқылы процесс бар-жоғын тексеру
  Future<bool> _isProcessRunning(String imageName) async {
    try {
      final processes = await  PSList.getRunningProcesses();

      // Кейбір жүйелерде process.name null болуы мүмкін — сондықтан қауіпсіз түрде тексереміз
      return processes.any((p) {
        final name = p.toLowerCase();
        return name == imageName.toLowerCase();
      });
    } catch (e, st) {
      log('ps_list error: $e\n$st');
      return false;
    }
  }

  /// Бір тексеру операциясы бір уақытта ғана жұмыс істесін
  Future<void> _checkProcessOnce() async {
    if (_isChecking) return;
    _isChecking = true;
    try {
      final running = await _isProcessRunning(_processName);
      if (running != _isAppRunning) {
        _isAppRunning = running;
        if (mounted) setState(() {});
        log('Process running changed: $_isAppRunning');
      }
    } catch (e, st) {
      log('Error while checking process: $e\n$st');
    } finally {
      _isChecking = false;
    }
  }

  /// Мониторды бастау
  Future<void> _startMonitoring() async {
    // егер таймер белсенді болса, қайта бастамау
    if (_monitorTimer?.isActive == true) return;

    // бастапқы бір рет тексереміз
    await _checkProcessOnce();

    // периодтық тексеру
    _monitorTimer = Timer.periodic(_pollInterval, (_) {
      // асинхрон түрде бір-бірін қиылыспайтындай шақырамыз
      _checkProcessOnce();
    });
  }

  /// Мониторды тоқтату қажет болса қолдануға болады
  void _stopMonitoring() {
    _monitorTimer?.cancel();
    _monitorTimer = null;
  }

  /// Калькулятор ашу (тек Windows үшін)
  Future<void> _openCalculator() async {
    // ps_list тек desktop-та жұмыс істейді — мобильде бұндай мүмкіндік болмауы мүмкін
    if (!Platform.isWindows) {
      // Қолданушыға көрсету үшін SnackBar
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Бұл операция тек Windows жүйесінде қолжетімді')),
        );
      }
      log('Open calculator is supported only on Windows in this example.');
      return;
    }

    try {
      final running = await _isProcessRunning(_processName);
      if (running) {
        log('Calculator already running');
        // қажет болса терезені алға шығару үшін Win32 API қолдану керек болады
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Calculator already running')),
          );
        }
        return;
      }

      // calc.exe ашу — cmd start арқылы
      await Process.start('cmd', ['/c', 'start', 'calc.exe']);
      log('Start command sent for calc.exe');

      // Мониторды қосып, процесс пайда болуын күтеміз
      await _startMonitoring();
    } catch (e, st) {
      log('Error launching calculator: $e\n$st');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Қате іске қосу кезінде: $e')),
        );
      }
    }
  }

  @override
  void initState() {
    super.initState();
    // init кезінде мониторды іске қосамыз (desktop-та ғана мәні бар)
    _startMonitoring();
  }

  @override
  void dispose() {
    _stopMonitoring();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        left: 16,
        right: 16,
        top: 16 + 48,
        bottom: 16,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Material(
            borderRadius: BorderRadius.circular(16),
            color: _isAppRunning ? Colors.grey : Colors.green,
            child: InkWell(
              borderRadius: BorderRadius.circular(16),
              onTap: _openCalculator,
              child: Container(
                padding: const EdgeInsets.all(16),
                child: Text(
                  _isAppRunning ? 'Calculator is running' : 'Open Calculator',
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),
            Material(
            borderRadius: BorderRadius.circular(16),
            color: _isAppRunning ? Colors.grey : Colors.green,
            child: InkWell(
              borderRadius: BorderRadius.circular(16),
              onTap: _getAllProcesses,
              child: Container(
                padding: const EdgeInsets.all(16),
                child: Text(
                  'Get All Processes',
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
