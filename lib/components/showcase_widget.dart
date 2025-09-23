import 'package:emosdk_launcher/components/simple_player_widget.dart';
import 'package:flutter/material.dart';
  
class ShowcaseWidget extends StatefulWidget {
  const ShowcaseWidget({super.key, required this.imagesList});
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

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 400,
          width: 600,
          child: PageView.builder(
            controller: _pageController,
            itemCount: widget.imagesList.length,
            onPageChanged: (index) {
              setState(() => _selectedIndex = index);
            },
            itemBuilder: (context, index) {
              if (index == 0) {
                return SizedBox(
                  child: CustomVideoPlayer(videoPath: 'C:\\Users\\iska2\\darling_in_franx_1.mkv'));
              }
              return Image.network(widget.imagesList[index], fit: BoxFit.cover);
            },
          ),
        ),
        SizedBox(height: 16),
        SizedBox(
          height: 90,
          width: 600, // Set a fixed width for horizontal ListView
          child: Scrollbar(
            controller: _thumbScrollController,
            thumbVisibility: true,
            child: ListView.builder(
              controller: _thumbScrollController,
              scrollDirection: Axis.horizontal,
              itemCount: widget.imagesList.length,
              itemBuilder: (context, index) {
                final isSelected = index == _selectedIndex;
                if(index == 0) {
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
                      child: const Icon(Icons.play_circle_fill, size: 100, color: Colors.black54),
                    ),
                  );
                }
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
                    child: Image.network(widget.imagesList[index], width: 100),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
