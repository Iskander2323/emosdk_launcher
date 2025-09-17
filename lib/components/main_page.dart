import 'package:emosdk_launcher/components/page_content_widget.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 8,
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(48),
          child: Container(
            color: Colors.white,
            child: const TabBar(
              tabs: [
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
          children: [
            PageContentWidget(),
            Container(height: 100, width: 100, color: Colors.blueAccent),
            Container(height: 100, width: 100, color: Colors.green),
            Container(height: 100, width: 100, color: Colors.red),
            Container(height: 100, width: 100, color: Colors.purple),
            Container(height: 100, width: 100, color: Colors.orange),
            Container(height: 100, width: 100, color: Colors.teal),
            Container(height: 100, width: 100, color: Colors.pink),
          ],
        ),
      ),
    );
  }
}
