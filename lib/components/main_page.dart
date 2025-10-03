import 'dart:developer';

import 'package:emosdk_launcher/app_assets.dart';
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
                      gameName: 'THE SACRED MEMORY',
                      gameDescription: AppAssets.visual_floss_description,
                      pageIndex: 0,
                      selectedIndex: _selectedIndex,
                      processName: AppConfig.VISUAL_FLOSS_PROCESS,
                      gamePath: AppConfig.VISUAL_FLOSS_GAME_PATH,
                      videoPath: AppAssets.visual_floss_video,
                      qrAssetPath: AppAssets.visual_floss_qr,
                      imagesList: [
                        AppAssets.visual_floss_src1,
                        AppAssets.visual_floss_src2,
                        AppAssets.visual_floss_src3,
                        AppAssets.visual_floss_src4,
                        AppAssets.visual_floss_src5,
                      ],
                    );
                  case "Echo Games Lab":
                    return PageContentWidget(
                      gameName: 'Reverb',
                      gameDescription: AppAssets.echo_games_lab_description,
                      gamePath: AppConfig.ECHO_GAMES_LAB_GAME_PATH,
                      processName: AppConfig.ECHO_GAMES_LAB_PROCESS,
                      pageIndex: 1,
                      selectedIndex: _selectedIndex,
                      videoPath: AppAssets.echo_games_lab_video,
                      qrAssetPath: AppAssets.echo_games_lab_qr,
                      imagesList: [
                        AppAssets.echo_games_lab_src1,
                        AppAssets.echo_games_lab_src2,
                        AppAssets.echo_games_lab_src3,
                        AppAssets.echo_games_lab_src4,
                        AppAssets.echo_games_lab_src5,
                        AppAssets.echo_games_lab_src6,
                      ],
                    );
                  case "Sigil Games":
                    return PageContentWidget(
                      gameName: 'Divinum',
                      gameDescription: AppAssets.sigil_games_description,
                      gamePath: AppConfig.SIGIL_GAMES_GAME_PATH,
                      processName: AppConfig.SIGIL_GAMES_PROCESS,
                      pageIndex: 2,
                      selectedIndex: _selectedIndex,
                      videoPath: AppAssets.sigil_games_video,
                      qrAssetPath: AppAssets.sigil_games_qr,
                      imagesList: [
                        AppAssets.sigil_games_src1,
                        AppAssets.sigil_games_src2,
                        AppAssets.sigil_games_src3,
                        AppAssets.sigil_games_src4,
                        AppAssets.sigil_games_src5,
                        AppAssets.sigil_games_src6,
                        AppAssets.sigil_games_src7,
                        AppAssets.sigil_games_src8,
                        AppAssets.sigil_games_src9,
                        AppAssets.sigil_games_src10,
                        AppAssets.sigil_games_src11,
                        AppAssets.sigil_games_src12,
                        AppAssets.sigil_games_src13,
                      ],
                    );
                  case "Iz Hazard":
                    return PageContentWidget(
                      gameName: 'OVIVO, GOST of time',
                      gameDescription: AppAssets.iz_hazard_description,
                      gamePath: AppConfig.IZ_HAZARD_GAME_PATH,
                      processName: '',
                      pageIndex: 3,
                      selectedIndex: _selectedIndex,
                      videoPath: AppAssets.iz_hazard_video,
                      qrAssetPath: AppAssets.iz_hazard_qr,
                      imagesList: [
                        AppAssets.iz_hazard_src1,
                        AppAssets.iz_hazard_src2,
                        AppAssets.iz_hazard_src3,
                        AppAssets.iz_hazard_src4,
                        AppAssets.iz_hazard_src5,
                        AppAssets.iz_hazard_src6,
                        AppAssets.iz_hazard_src7,
                        AppAssets.iz_hazard_src8,
                      ],
                    );
                  case "Flesh Insane Team":
                    return PageContentWidget(
                      gameName: 'Fleshinsane',
                      gameDescription: AppAssets.flesh_insane_team_description,
                      gamePath: AppConfig.FLESH_INSANE_TEAM_GAME_PATH,
                      pageIndex: 4,
                      selectedIndex: _selectedIndex,
                      processName: '',
                      qrAssetPath: AppAssets.flesh_insane_team_qr,
                      videoPath: AppAssets.flesh_insane_team_video,
                      imagesList: [
                        AppAssets.flesh_insane_team_src1,
                        AppAssets.flesh_insane_team_src2,
                        AppAssets.flesh_insane_team_src3,
                        AppAssets.flesh_insane_team_src4,
                        AppAssets.flesh_insane_team_src5,
                        AppAssets.flesh_insane_team_src6,
                        AppAssets.flesh_insane_team_src7,
                        AppAssets.flesh_insane_team_src8,
                        AppAssets.flesh_insane_team_src9,
                      ],
                    );
                  case "Exceedium Games":
                    return PageContentWidget(
                      gameName: 'Exceedium Games',
                      gameDescription: '',
                      gamePath: AppConfig.EXCEEDIUM_GAMES_GAME_PATH,
                      processName: AppConfig.EXCEEDIUM_GAMES_PROCESS,
                      pageIndex: 5,
                      selectedIndex: _selectedIndex,
                      videoPath: '',
                      qrAssetPath: AppAssets.exceedium_games_qr,
                      imagesList: [
                        AppAssets.exceedium_games_src1,
                        AppAssets.exceedium_games_src2,
                        AppAssets.exceedium_games_src3,
                        AppAssets.exceedium_games_src4,
                      ],
                    );
                  case "EmoSDK":
                    return PageContentWidget(
                      gameName: 'EmoSDK',
                      gameDescription: '',
                      gamePath: AppConfig.EMOSDK_GAME_PATH,
                      processName: AppConfig.EMOSDK_PROCESS,
                      pageIndex: 5,
                      selectedIndex: _selectedIndex,
                      videoPath: '',
                      qrAssetPath: '',
                      imagesList: [
                        AppAssets.emo_sdk_src1,
                      ],
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
