import 'dart:io';

import 'package:flutter/material.dart';
import 'package:video_player_win/video_player_win.dart';

class VideoThumbWidget extends StatefulWidget {
  final String videoPath;

  const VideoThumbWidget({super.key, required this.videoPath});

  @override
  State<VideoThumbWidget> createState() => _VideoThumbWidgetState();
}

class _VideoThumbWidgetState extends State<VideoThumbWidget> {
  late WinVideoPlayerController _controller;
  bool _initialized = false;

  @override
  void initState() {
    super.initState();
    _controller = WinVideoPlayerController.file(
      // Windows-та absolute path қолдануға болады
      File(widget.videoPath),
    )..initialize().then((_) async {
        await _controller.pause();
        await _controller.seekTo(const Duration(seconds: 1)); // preview point
        setState(() {
          _initialized = true;
        });
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!_initialized) {
      return const Center(child: CircularProgressIndicator());
    }

    return Stack(
      alignment: Alignment.center,
      children: [
        AspectRatio(
          aspectRatio: _controller.value.aspectRatio,
          child: WinVideoPlayer(_controller),
        ),
        Container(
          decoration: const BoxDecoration(
            color: Colors.black54,
            shape: BoxShape.circle,
          ),
          padding: const EdgeInsets.all(12),
          child: const Icon(
            Icons.play_arrow,
            color: Colors.white,
            size: 48,
          ),
        ),
      ],
    );
  }
}
