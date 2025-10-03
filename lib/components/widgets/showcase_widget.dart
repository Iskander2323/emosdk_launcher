import 'package:emosdk_launcher/components/widgets/simple_player_widget.dart';
import 'package:emosdk_launcher/components/widgets/video_thumb_widget.dart';
import 'package:flutter/material.dart';

class ShowcaseWidget extends StatefulWidget {
  const ShowcaseWidget({
    super.key,
    required this.imagesList,
    required this.videoPath,
    required this.pageIndex,
    required this.tabSelectedIndex,
    required this.gameName
  });
  final String videoPath;
  final List<String> imagesList;
  final int pageIndex;
  final int tabSelectedIndex;
  final String gameName;

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
        Text(widget.gameName, 
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w500,
          color: Colors.white,
        ),
        ),
        SizedBox(
          height: 600,
          child: PageView.builder(
            controller: _pageController,
            itemCount: widget.imagesList.length + 1,
            onPageChanged: (index) {
              setState(() => _selectedIndex = index);
            },
            itemBuilder: (context, index) {
    
              if (index == 0 && widget.videoPath.isNotEmpty) {
                return CustomVideoPlayer(
                  pageIndex: widget.pageIndex,
                  tabBarSelectedIndex: widget.tabSelectedIndex,
                  pageViewContentIndex: index,
                  pageViewContentSelectedIndex: _selectedIndex,
                  videoAsset: widget.videoPath,
                );
              }
              return Image.asset(
                widget.imagesList[ widget.videoPath.isNotEmpty ? index - 1 : index],
                fit: BoxFit.fitHeight,
              );
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10),
          child: SizedBox(
            height: 90,
            child: RawScrollbar(
              controller: _thumbScrollController,
              thumbVisibility: true,
              trackVisibility: true,
              thickness: 10,
              radius: const Radius.circular(20),
              thumbColor: Colors.blueAccent,
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
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 15),
                    child: GestureDetector(
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
                              index == 0 && widget.videoPath.isNotEmpty
                                  ?  VideoThumbWidget(
                                    videoPath: widget.videoPath,
                                  )
                                  : Image.asset(
                                    widget.imagesList[widget.videoPath.isNotEmpty ? index - 1 : index],
                                    fit: BoxFit.cover,
                                  ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}
