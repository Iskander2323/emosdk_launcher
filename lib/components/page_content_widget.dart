import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';

class PageContentWidget extends StatefulWidget {
  const PageContentWidget({super.key});

  @override
  State<PageContentWidget> createState() => _PageContentWidgetState();
}

class _PageContentWidgetState extends State<PageContentWidget> {
  void _openCalculator() async {
    try {
      await Process.start("calc.exe", []); // 👈 Windows калькуляторын ашу
    } catch (e) {
      log(e.toString(), name: 'Error: $e');
      // debugPrint("Error: $e");
    }
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
