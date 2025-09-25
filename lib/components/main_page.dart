import 'dart:developer';

import 'package:emosdk_launcher/components/page_content_widget.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}


class _MainPageState extends State<MainPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 8, vsync: this);

    _tabController.addListener(() {
    if (_tabController.indexIsChanging) {
      // Бұл жерде index ауысқанда бір рет шақырылады
      log("Таңдалған таб: ${_tabController.index}");
      setState(() {
        _selectedIndex = _tabController.index;
      });
    }
  });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(48),
        child: Container(
          color: Colors.white,
          child: TabBar(
            controller: _tabController,
            tabs: const [
              Tab(text: 'VISUAL FLOSS'),
              Tab(text: 'Reverb'),
              Tab(text: 'Divinum'),
              Tab(text: 'OVIVO, GOST of time'),
              Tab(text: 'Fleshinsane'),
              Tab(text: 'Qazaq Dino War'),
              Tab(text: 'Emosdk'),
              Tab(text: 'АКИРА'),
            ],
          ),
        ),
      ),
      body: TabBarView(
          controller: _tabController,
          children: [
            PageContentWidget(
              gameName: 'THE SACRED MEMORY',
              pageIndex: 0, selectedIndex: _selectedIndex,
              videoPath: 'C:\\Users\\iska2\\darling_in_franx_1.mkv',
              ),
            PageContentWidget(
              gameName: 'Reverb',
              pageIndex: 1, selectedIndex: _selectedIndex,
              videoPath: 'C:\\Users\\iska2\\darling_in_franx_1.mkv',
              ),
            PageContentWidget(
              gameName: 'Divinum',
              pageIndex: 2, selectedIndex: _selectedIndex,
              videoPath: 'C:\\Users\\iska2\\darling_in_franx_1.mkv',
              ),
            PageContentWidget(
              gameName: 'OVIVO, GOST of time',
              pageIndex: 3, selectedIndex: _selectedIndex,
              videoPath: 'C:\\Users\\iska2\\darling_in_franx_1.mkv',
              ),
            PageContentWidget(
              gameName: 'Fleshinsane',
              pageIndex: 4, selectedIndex: _selectedIndex,
              videoPath: 'C:\\Users\\iska2\\darling_in_franx_1.mkv',
              ),
            PageContentWidget(
              gameName: 'Qazaq Dino War',
              pageIndex: 5, selectedIndex: _selectedIndex,
              videoPath: 'C:\\Users\\iska2\\darling_in_franx_1.mkv',
              ),
            PageContentWidget(
              gameName: 'Emosdk',
              pageIndex: 6, selectedIndex: _selectedIndex,
              videoPath: 'C:\\Users\\iska2\\darling_in_franx_1.mkv',
              ),
            PageContentWidget(
              gameName: 'АКИРА',
              pageIndex: 7, selectedIndex: _selectedIndex,
              videoPath: 'C:\\Users\\iska2\\darling_in_franx_1.mkv',
              ),
          ],
        ),
  
    );
  }
}
