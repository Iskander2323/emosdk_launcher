import 'package:emosdk_launcher/components/widgets/simple_player_widget.dart';
import 'package:emosdk_launcher/components/widgets/video_thumb_widget.dart';
import 'package:flutter/material.dart';

class ShowcaseWidget extends StatefulWidget {
  const ShowcaseWidget({
    super.key,
    required this.imagesList,
    required this.videoPath,
  });
  final String videoPath;
  final List<String> imagesList;

  @override
  State<ShowcaseWidget> createState() => _ShowcaseWidgetState();
}

class _ShowcaseWidgetState extends State<ShowcaseWidget> {
  final PageController _pageController = PageController();
  final ScrollController _thumbScrollController = ScrollController();
  int _selectedIndex = 0;

  void _onThumbnailTap(int index) {
    setState(() => _selectedIndex = index);
    _pageController.jumpToPage(index);
  }

  void _onArrowPressed(bool isRight) {
    const double scrollAmount = 200.0;
    final newOffset =
        isRight
            ? _thumbScrollController.offset + scrollAmount
            : _thumbScrollController.offset - scrollAmount;

    _thumbScrollController.animateTo(
      newOffset.clamp(0.0, _thumbScrollController.position.maxScrollExtent),
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 400,
          width: 680,
          child: PageView.builder(
            controller: _pageController,
            itemCount: widget.imagesList.length + 1,
            onPageChanged: (index) {
              setState(() => _selectedIndex = index);
            },
            itemBuilder: (context, index) {
              if (index == 0) {
                return SizedBox(
                  child: CustomVideoPlayer(videoPath: widget.videoPath),
                );
              }
              return Image.network(
                widget.imagesList[index - 1],
                fit: BoxFit.cover,
              );
            },
          ),
        ),
        SizedBox(height: 16),
        SizedBox(
          height: 90,
          width: 680,
          child: RawScrollbar(
            controller: _thumbScrollController,
            thumbVisibility: true,
            trackVisibility: true,
            thickness: 10,
            radius: const Radius.circular(20),
            thumbColor: Colors.black.withOpacity(0.7),
            mainAxisMargin: 6, // тік бағытта аздап бос орын
            crossAxisMargin: 2, // көлденең бағытта бос орын
            child: ListView.builder(
              controller: _thumbScrollController,
              scrollDirection: Axis.horizontal,
              itemCount:
                  widget.videoPath.isNotEmpty
                      ? widget.imagesList.length + 1
                      : widget.imagesList.length,
              itemBuilder: (context, index) {
                final isSelected = index == _selectedIndex;
                return GestureDetector(
                  onTap: () => _onThumbnailTap(index),
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: isSelected ? Colors.blue : Colors.grey,
                        width: isSelected ? 3 : 1,
                      ),
                    ),
                    child: AspectRatio(
                      aspectRatio: 16 / 9,
                      child:
                          index == 0
                              ? VideoThumbWidget(videoPath: widget.videoPath)
                              : Image.network(
                                widget.imagesList[index - 1],
                                fit: BoxFit.cover,
                              ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
        SizedBox(
          height: 40,
          width: 680,
          child: Row(
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () => _onArrowPressed(false),
              ),
              Expanded(
                child: SizedBox(
                  width:
                      widget.imagesList.length *
                      120, // жалпы ені (миниатюраларға пропорционалды)
                  height: 20,
                ),
              ),
              IconButton(
                icon: const Icon(Icons.arrow_forward),
                onPressed: () => _onArrowPressed(true),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
