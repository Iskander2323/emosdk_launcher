import 'dart:developer';

import 'package:emosdk_launcher/app_assets.dart';
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
              Tab(text: 'Exceedium Games'),
              Tab(text: 'Emosdk'),
              Tab(text: 'АКИРА'),
            ],
          ),
        ),
      ),
      body: Container(
        color: const Color.fromARGB(255, 20, 16, 55),
        child: TabBarView(
            controller: _tabController,
            children: [
              PageContentWidget(
                gameName: 'THE SACRED MEMORY',
                gameDescription: AppAssets.visual_floss_description,
                pageIndex: 0, selectedIndex: _selectedIndex,
                videoPath: AppAssets.visual_floss_video,
                qrAssetPath: AppAssets.visual_floss_qr,
                imagesList: [
                 AppAssets.visual_floss_src1,
                 AppAssets.visual_floss_src2,
                  AppAssets.visual_floss_src3,
                  AppAssets.visual_floss_src4,
                  AppAssets.visual_floss_src5,
                ],
                ),
              PageContentWidget(
                gameName: 'Reverb',
                gameDescription: AppAssets.echo_games_lab_description,
                pageIndex: 1, selectedIndex: _selectedIndex,
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
                ),
              PageContentWidget(
                gameName: 'Divinum',
                gameDescription: AppAssets.sigil_games_description,
                pageIndex: 2, selectedIndex: _selectedIndex,
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
                ),
              PageContentWidget(
                gameName: 'OVIVO, GOST of time',
                gameDescription: AppAssets.iz_hazard_description,
                pageIndex: 3, selectedIndex: _selectedIndex,
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
                ),
              PageContentWidget(
                gameName: 'Fleshinsane',
                gameDescription: AppAssets.flesh_insane_team_description,
                pageIndex: 4, selectedIndex: _selectedIndex,
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
                ),
                 PageContentWidget(
                gameName: 'Exceedium Games',
                gameDescription: '',
                pageIndex: 5, selectedIndex: _selectedIndex,
                videoPath: '',
                qrAssetPath: AppAssets.exceedium_games_qr,
                imagesList: [
                 AppAssets.exceedium_games_src1,
                 AppAssets.exceedium_games_src2,
                  AppAssets.exceedium_games_src3,
                  AppAssets.exceedium_games_src4,
                ],
                ),
              PageContentWidget(
                gameName: 'Emosdk',
                gameDescription: '',
                pageIndex: 5, selectedIndex: _selectedIndex,
                videoPath: AppAssets.visual_floss_video,
                qrAssetPath: AppAssets.visual_floss_qr,
                imagesList: [
                 
                ],
                ),
              PageContentWidget(
                gameName: 'АКИРА',
                gameDescription: '',
                pageIndex: 6, selectedIndex: _selectedIndex,
                videoPath: AppAssets.visual_floss_video,
                qrAssetPath: AppAssets.visual_floss_qr,
                imagesList: [
                 
                ],
                ),
            ],
          ),
      ),
  
    );
  }
}
