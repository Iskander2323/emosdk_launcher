import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player_win/video_player_win.dart';

class CustomVideoPlayer extends StatefulWidget {
  final String videoAsset;
  final int pageIndex;
  final int tabBarSelectedIndex;
  final int pageViewContentIndex;
  final int pageViewContentSelectedIndex;

  const CustomVideoPlayer({super.key, required this.videoAsset, required this.pageIndex, required this.tabBarSelectedIndex, required this.pageViewContentIndex, required this.pageViewContentSelectedIndex});

  @override
  State<CustomVideoPlayer> createState() => _CustomVideoPlayerState();
}

class _CustomVideoPlayerState extends State<CustomVideoPlayer>
    with AutomaticKeepAliveClientMixin {
  WinVideoPlayerController? _controller;
  bool _isInitialized = false;
  bool _showControls = false;
  Timer? _hideTimer;

  @override
  void initState() {
    super.initState();
    _initVideo(widget.videoAsset);
  }

   Future<void> _initVideo(String videoAsset) async {
     final controller = WinVideoPlayerController.asset(widget.videoAsset);
    await controller.initialize();
    setState(() {
          });
    controller.setLooping(true);
    controller.addListener(() {
      if (mounted) setState(() {});
    });

    setState(() {
      _controller = controller;
      _isInitialized = true;
    });
  }

  @override
  bool get wantKeepAlive => true; // 👈 бет dispose болмайды

  @override
  void didUpdateWidget(covariant CustomVideoPlayer oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.pageIndex != widget.pageIndex ||
        oldWidget.tabBarSelectedIndex != widget.tabBarSelectedIndex ||
        oldWidget.pageViewContentIndex != widget.pageViewContentIndex ||
        oldWidget.pageViewContentSelectedIndex !=
            widget.pageViewContentSelectedIndex) {
      if (_controller != null && _isInitialized) {
        _controller!.seekTo(Duration.zero);
        _controller!.pause();
        _showControls = false;
        _hideTimer?.cancel();
        setState(() {});
      }
    }
  }

  void _togglePlayPause() {
    if (_controller == null) return;

    if (_controller!.value.isPlaying) {
      _controller!.pause();
    } else {
      if (_controller!.value.position >= _controller!.value.duration) {
        _controller!.seekTo(Duration.zero);
      }
      _controller!.play();
    }
    _showControls = true;
    setState(() {});
    _startHideTimer();
  }

  void _startHideTimer() {
    _hideTimer?.cancel();
    _hideTimer = Timer(const Duration(seconds: 2), () {
      setState(() {
        _showControls = false;
      });
    });
  }

  Widget _buildBottomControls() {
    if (_controller == null) return const SizedBox.shrink();
      if (!_controller!.value.isInitialized) {
    return const SizedBox.shrink(); // әлі дайын емес болса ештеңе көрсетпе
  }
    final position = _controller!.value.position;
    final duration = _controller!.value.duration;

    String formatDuration(Duration d) {
      String twoDigits(int n) => n.toString().padLeft(2, '0');
      final minutes = twoDigits(d.inMinutes.remainder(60));
      final seconds = twoDigits(d.inSeconds.remainder(60));
      return '$minutes:$seconds';
    }

    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(color: Colors.black.withOpacity(0.4)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  formatDuration(position),
                  style: const TextStyle(color: Colors.white, fontSize: 12),
                ),
                Text(
                  formatDuration(duration),
                  style: const TextStyle(color: Colors.white, fontSize: 12),
                ),
              ],
            ),
            Slider(
              activeColor: Colors.deepPurpleAccent,
              inactiveColor: Colors.white54,
              value:
                  position.inMilliseconds
                      .clamp(0, duration.inMilliseconds)
                      .toDouble(),
              max: duration.inMilliseconds.toDouble(),
              onChanged: (value) {
                _controller!.seekTo(Duration(milliseconds: value.toInt()));
              },
            ),
          ],
        ),
      ),
    );
  }

  void _openFullScreen() async {
    // Navigator арқылы fullscreen бетке өту
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => FullScreenVideoPlayer(controller: _controller!),
      ),
    );
    // fullscreen-нен шыққанда UI-ді қалпына келтіру
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  }

  @override
  void dispose() {
    _controller!.dispose(); // тек бүкіл апп жабылғанда босайды
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    
    if (!_isInitialized || _controller == null) {
      return const Center(child: CircularProgressIndicator());
    }
    final isPlaying = _controller!.value.isPlaying;
    

    return Stack(
      alignment: Alignment.center,
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              _showControls = true;
            });
            _startHideTimer();
          },
          child: AspectRatio(
            aspectRatio: 16/9,
            child: WinVideoPlayer(_controller!),
          ),
        ),

        // Play/Pause/Replay button
        if (!isPlaying || _showControls)
          GestureDetector(
            onTap: _togglePlayPause,
            child: Container(
              width: 60,
              height: 60,
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: Icon(
                isPlaying
                    ? Icons.pause
                    : Icons.play_arrow,
                color: Colors.black,
              ),
            ),
          ),

        // Bottom controls
        if (_showControls) _buildBottomControls(),

        // Fullscreen button
        if (_showControls)
          Positioned(
            top: 8,
            right: 8,
            child: IconButton(
              icon: const Icon(Icons.fullscreen, color: Colors.white),
              onPressed: _openFullScreen,
            ),
          ),
      ],
    );
  }
}

// Fullscreen бетін жасау
class FullScreenVideoPlayer extends StatefulWidget {
  final WinVideoPlayerController controller;
  const FullScreenVideoPlayer({super.key, required this.controller});

  @override
  State<FullScreenVideoPlayer> createState() => _FullScreenVideoPlayerState();
}

class _FullScreenVideoPlayerState extends State<FullScreenVideoPlayer> {
  bool _showControls = true;
  Timer? _hideTimer;
  late VoidCallback _listener;

  @override
  void initState() {
    super.initState();
    // экранды landscape-ке ауыстыру
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    _listener = () {
      if (mounted) {
        setState(() {}); // Видео жүрісі өзгерген сайын UI жаңарады
      }
    };
    widget.controller.addListener(_listener);
  }

  Widget _buildBottomControls() {
    final position = widget.controller.value.position;
    final duration = widget.controller.value.duration;

    String formatDuration(Duration d) {
      String twoDigits(int n) => n.toString().padLeft(2, '0');
      final minutes = twoDigits(d.inMinutes.remainder(60));
      final seconds = twoDigits(d.inSeconds.remainder(60));
      return '$minutes:$seconds';
    }

    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.4),
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(12),
            bottomRight: Radius.circular(12),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  formatDuration(position),
                  style: const TextStyle(color: Colors.white, fontSize: 12),
                ),
                Text(
                  formatDuration(duration),
                  style: const TextStyle(color: Colors.white, fontSize: 12),
                ),
              ],
            ),
            Slider(
              activeColor: Colors.deepPurpleAccent,
              inactiveColor: Colors.white54,
              value:
                  position.inMilliseconds
                      .clamp(0, duration.inMilliseconds)
                      .toDouble(),
              max: duration.inMilliseconds.toDouble(),
              onChanged: (value) {
                widget.controller.seekTo(Duration(milliseconds: value.toInt()));
              },
            ),
          ],
        ),
      ),
    );
  }

  void _startHideTimer() {
    _hideTimer?.cancel();
    _hideTimer = Timer(const Duration(seconds: 3), () {
      setState(() {
        _showControls = false;
      });
    });
  }

  @override
  void dispose() {
    widget.controller.removeListener(_listener);
    _hideTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final controller = widget.controller;
    final isPlaying = controller.value.isPlaying;
    final isEnded = controller.value.position >= controller.value.duration;

    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            GestureDetector(
              onTap: () {
                setState(() {
                  _showControls = !_showControls;
                });
                if (_showControls) _startHideTimer();
              },
              child: AspectRatio(
                aspectRatio: controller.value.aspectRatio,
                child: WinVideoPlayer(controller),
              ),
            ),
            if (_showControls)
              Positioned(
                top: 20,
                right: 20,
                child: IconButton(
                  icon: const Icon(Icons.fullscreen_exit, color: Colors.white),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
            if (_showControls) _buildBottomControls(),
            if (_showControls || !isPlaying || isEnded)
              GestureDetector(
                onTap: () {
                  if (isPlaying) {
                    controller.pause();
                  } else {
                    if (isEnded) {
                      controller.seekTo(Duration.zero);
                    }
                    controller.play();
                  }
                  setState(() {
                    _showControls = true;
                  });
                  _startHideTimer();
                },
                child: Container(
                  width: 60,
                  height: 60,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    isEnded
                        ? Icons.replay
                        : isPlaying
                        ? Icons.pause
                        : Icons.play_arrow,
                    color: Colors.black,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
