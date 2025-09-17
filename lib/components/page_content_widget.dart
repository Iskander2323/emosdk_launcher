import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';

class PageContentWidget extends StatefulWidget {
  const PageContentWidget({super.key});

  @override
  State<PageContentWidget> createState() => _PageContentWidgetState();
}

class _PageContentWidgetState extends State<PageContentWidget> {
  Process? _calcProcess;

  Future<void> _openCalculator() async {
    try {
      log(_calcProcess.toString());
      if (_calcProcess != null) {
        log(_calcProcess!.pid.toString());
        final hasExited = await _calcProcess!.exitCode
            .then((_) => false)
            .catchError((_) => true);

        log(hasExited.toString());

        if (!hasExited) {
          log("Calculator already running.");
          return;
        } else {
          _calcProcess = null; // бұрынғы процесс жабылған
        }
      }

      final process = await Process.start("calc.exe", []);
      _calcProcess = process;
      log("Calculator started with PID: ${process.pid}");
    } catch (e) {
      log("Error: $e");
    }
  }

  @override
  void initState() {
    super.initState();
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
            color: Colors.green,
            child: InkWell(
              borderRadius: BorderRadius.circular(16),
              onTap: _openCalculator,
              child: Container(
                padding: EdgeInsets.all(16),
                child: Text('TRIGGER EVENT BUTTON'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
