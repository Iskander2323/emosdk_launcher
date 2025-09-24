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
              Tab(text: 'Another 1'),
              Tab(text: 'Another 2'),
              Tab(text: 'Another 3'),
              Tab(text: 'Another 4'),
              Tab(text: 'Another 5'),
              Tab(text: 'Another 6'),
              Tab(text: 'Another 7'),
            ],
          ),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          PageContentWidget(pageIndex: 0, selectedIndex: _selectedIndex),
          PageContentWidget(pageIndex: 1, selectedIndex: _selectedIndex),
          Container(height: 100, width: 100, color: Colors.green),
          Container(height: 100, width: 100, color: Colors.red),
          Container(height: 100, width: 100, color: Colors.purple),
          Container(height: 100, width: 100, color: Colors.orange),
          Container(height: 100, width: 100, color: Colors.teal),
          Container(height: 100, width: 100, color: Colors.pink),
        ],
      ),
    );
  }
}
