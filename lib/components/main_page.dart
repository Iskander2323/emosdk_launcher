import 'dart:developer';

import 'package:emosdk_launcher/app_config.dart';
import 'package:emosdk_launcher/components/page_content_widget.dart';
import 'package:emosdk_launcher/simple_logger_service.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: AppConfig.enabledStudios.length,
      vsync: this,
    );

    _tabController.addListener(() {
      if (_tabController.indexIsChanging) {
        // Бұл жерде index ауысқанда бір рет шақырылады
        log("Таңдалған таб: ${_tabController.index}");
        LoggerService.logEvent('TabChanged', {
          'selectedIndex': _selectedIndex,
          'tab_name':  AppConfig.enabledStudios[_tabController.index],
        });
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
          color: Color.fromARGB(255, 20, 16, 55),
          child: TabBar(
            controller: _tabController,
              labelColor: Colors.white, 
              unselectedLabelColor: Colors.white,
              indicatorColor: Colors.purpleAccent,
            tabs: AppConfig.enabledStudios.map((studio) => Tab(text: studio)).toList(),
          ),
        ),
      ),
      body: Container(
        color: const Color.fromARGB(255, 20, 16, 55),
        child: TabBarView(
          controller: _tabController,
          children:
              AppConfig.enabledStudios.map((studio) {
                switch (studio) {
                  case "Visual Floss":
                    return PageContentWidget(
                      studioModel: AppConfig.visualFloss,
                      pageIndex: 0,
                      selectedIndex: _selectedIndex,
                      
                    );
                  case "Echo Games Lab":
                    return PageContentWidget(
                      studioModel: AppConfig.echoGamesLab,
                      pageIndex: 1,
                      selectedIndex: _selectedIndex,
                    
                    );
                  case "Sigil Games":
                    return PageContentWidget(
                      studioModel: AppConfig.sigilGames,
                      pageIndex: 2,
                      selectedIndex: _selectedIndex,
                    
                    );
                  case "Iz Hazard":
                    return PageContentWidget(
                      studioModel: AppConfig.izHazard,
                      pageIndex: 3,
                      selectedIndex: _selectedIndex,
                      
                    );
                  case "Flesh Insane Team":
                    return PageContentWidget(
                      studioModel: AppConfig.fleshInsaneTeam,
                      pageIndex: 4,
                      selectedIndex: _selectedIndex,
                      
                    );
                  case "Exceedium Games":
                    return PageContentWidget(
                      studioModel: AppConfig.exceediumGames,
                      pageIndex: 5,
                      selectedIndex: _selectedIndex,
                     
                    );
                  case "EmoSDK":
                    return PageContentWidget(
                      pageIndex: 5,
                      selectedIndex: _selectedIndex,
                      studioModel: AppConfig.emoSDK,
                    );
                  default:
                    return const Center(
                      child: Text(
                        'No studio available',
                        style: TextStyle(color: Colors.white),
                      ),
                    );
                }
              }).toList(),
        ),
      ),
    );
  }
}
