import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'package:emosdk_launcher/components/widgets/custom_ink_well_button.dart';
import 'package:emosdk_launcher/components/widgets/showcase_widget.dart';
import 'package:emosdk_launcher/simple_logger_service.dart';
import 'package:flutter/material.dart';
import 'package:ps_list/ps_list.dart';

class PageContentWidget extends StatefulWidget {
  const PageContentWidget({
    super.key,
    required this.pageIndex,
    required this.selectedIndex,
    required this.gameName,
    required this.gameDescription,
    required this.videoPath,
    required this.qrAssetPath,
    required this.imagesList,
  });

  final int selectedIndex;
  final int pageIndex;
  final String gameName;
  final String gameDescription;
  final String qrAssetPath;
  final String videoPath;
  final List<String> imagesList;

  @override
  State<PageContentWidget> createState() => _PageContentWidgetState();
}

class _PageContentWidgetState extends State<PageContentWidget> {
  Timer? _monitorTimer;
  bool _isAppRunning = false;
  bool _isChecking = false; // реентранттық тексеруді болдырмау үшін
  bool _canTap = true;

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
      final processes = await PSList.getRunningProcesses();

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

  Future<void> _debouncedTap(Function action) async {
    if (!_canTap) return;
    _canTap = false;
    action();
    await Future.delayed(const Duration(seconds: 1));
    _canTap = true;
  }

  /// Калькулятор ашу (тек Windows үшін)
  Future<void> _openCalculator() async {
    // ps_list тек desktop-та жұмыс істейді — мобильде бұндай мүмкіндік болмауы мүмкін
    if (!Platform.isWindows) {
      // Қолданушыға көрсету үшін SnackBar
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Бұл операция тек Windows жүйесінде қолжетімді'),
          ),
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
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Қате іске қосу кезінде: $e')));
      }
    }
  }

  @override
  void dispose() {
    LoggerService.logEvent('app_exit');
    LoggerService.dispose();
    _stopMonitoring();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    // init кезінде мониторды іске қосамыз (desktop-та ғана мәні бар)
    _startMonitoring();
  }

  @override
  void didUpdateWidget(covariant PageContentWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.selectedIndex != widget.selectedIndex) {
      log(
        'selectedIndex from ${oldWidget.selectedIndex} to ${widget.selectedIndex}',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 100),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: ShowcaseWidget(
              gameName: widget.gameName,
              videoPath: widget.videoPath,
              pageIndex: widget.pageIndex,
              tabSelectedIndex: widget.selectedIndex,
              imagesList: widget.imagesList,
            ),
          ),
          SizedBox(width: 16),
          Container(
            width: 240 + 16,
            height: 600,
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: Container(
                      color: Colors.blue,
                      child: Image.asset(
                        widget.qrAssetPath,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            color: Colors.grey,
                            alignment: Alignment.center,
                            child: const Icon(
                              Icons.error,
                              color: Colors.red,
                              size: 48,
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Text(widget.gameDescription,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    )),
                const Spacer(),
                CustomInkWellButton(
                  buttonText: 'Play',
                  isEnabled: !_isAppRunning,
                  onPressed: () {
                    _debouncedTap(() {
                      _openCalculator();
                    });
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
