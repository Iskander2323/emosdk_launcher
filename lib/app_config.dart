import 'dart:developer';

import 'package:emosdk_launcher/app_assets.dart';
import 'package:emosdk_launcher/components/data/game_model.dart';
import 'package:emosdk_launcher/components/data/studio_model.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class AppConfig {
  factory AppConfig() {
    return _singleton;
  }

  AppConfig._();

  static final AppConfig _singleton = AppConfig._();
  //?
  static bool get VISUAL_FLOSS_ENABLED => dotenv.env['VISUAL_FLOSS_ENABLED'] == 'true';
  static bool get ECHO_GAMES_LAB_ENABLED => dotenv.env['ECHO_GAMES_LAB_ENABLED'] == 'true';
  static bool get EXCEEDIUM_GAMES_ENABLED => dotenv.env['EXCEEDIUM_GAMES_ENABLED'] == 'true';
  static bool get SIGIL_GAMES_ENABLED => dotenv.env['SIGIL_GAMES_ENABLED'] == 'true';
  static bool get IZ_HAZARD_ENABLED => dotenv.env['IZ_HAZARD_ENABLED'] == 'true';
  static bool get FLESH_INSANE_TEAM_ENABLED => dotenv.env['FLESH_INSANE_TEAM_ENABLED'] == 'true';
  static bool get EMOSDK_ENABLED => dotenv.env['EMOSDK_ENABLED'] == 'true';

    static List<String> get enabledStudios {
    final List<String> studios = [];
    if (VISUAL_FLOSS_ENABLED) studios.add("Visual Floss");
    if (ECHO_GAMES_LAB_ENABLED) studios.add("Echo Games Lab");
    if (SIGIL_GAMES_ENABLED) studios.add("Sigil Games");
    if (IZ_HAZARD_ENABLED) studios.add("Iz Hazard");
    if (FLESH_INSANE_TEAM_ENABLED) studios.add("Flesh Insane Team");
    if (EXCEEDIUM_GAMES_ENABLED) studios.add("Exceedium Games");
    if (EMOSDK_ENABLED) studios.add("EmoSDK");
    return studios;
  }

  static GameModel get theSacredMemory => GameModel(
        gameName: 'The Sacred Memory',
        description: AppAssets.visual_floss_description,
        gamePath: VISUAL_FLOSS_GAME_PATH,
        processName: VISUAL_FLOSS_PROCESS,
        qrAssetPath: AppAssets.visual_floss_qr,
        videoPath: AppAssets.visual_floss_video,
        imagesList: [
          AppAssets.visual_floss_src1,
          AppAssets.visual_floss_src2,
          AppAssets.visual_floss_src3,
          AppAssets.visual_floss_src4,
          AppAssets.visual_floss_src5,
        ],
      );

  static GameModel get reverb => GameModel(
        gameName: 'Reverb',
        description: AppAssets.echo_games_lab_description,
        gamePath: ECHO_GAMES_LAB_GAME_PATH,
        processName: ECHO_GAMES_LAB_PROCESS,
        qrAssetPath: AppAssets.echo_games_lab_qr,
        videoPath: AppAssets.echo_games_lab_video,
        imagesList: [
          AppAssets.echo_games_lab_src1,
          AppAssets.echo_games_lab_src2,
          AppAssets.echo_games_lab_src3,
          AppAssets.echo_games_lab_src4,
          AppAssets.echo_games_lab_src5,
          AppAssets.echo_games_lab_src6,
        ],
      );

  static GameModel get shakeIt => GameModel(
        gameName: 'Shake it',
        description: AppAssets.exceedium_games_description,
        gamePath: EXCEEDIUM_GAMES_GAME_PATH,
        processName: EXCEEDIUM_GAMES_PROCESS,
        qrAssetPath: AppAssets.exceedium_games_qr,
        videoPath: '', //AppAssets.exceedium_games_video,
        imagesList: [
          AppAssets.exceedium_games_src1,
          AppAssets.exceedium_games_src2,
          AppAssets.exceedium_games_src3,
          AppAssets.exceedium_games_src4,
        ],
      );

  static GameModel get divinum => GameModel(
        gameName: 'Divinum',
        description: AppAssets.sigil_games_description,
        gamePath: SIGIL_GAMES_GAME_PATH,
        processName: SIGIL_GAMES_PROCESS,
        qrAssetPath: AppAssets.sigil_games_qr,
        videoPath: AppAssets.sigil_games_video,
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

  static GameModel get gostOfTime => GameModel(
        gameName: 'GOST of Time',
        description: AppAssets.iz_hazard_description,
        gamePath: IZ_HAZARD_GAME_PATH,
        processName: IZ_HAZARD_PROCESS,
        qrAssetPath: AppAssets.iz_hazard_qr,
        videoPath: AppAssets.iz_hazard_video,
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

  static GameModel get fleshInsaneTeamGame => GameModel(
        gameName: 'Fleshinsane Forgotten Empire',
        description: AppAssets.flesh_insane_team_description,
        gamePath: FLESH_INSANE_TEAM_GAME_PATH,
        processName: FLESH_INSANE_TEAM_PROCESS,
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
  
  static GameModel get emoSDKGame => GameModel(
        gameName: 'EmoSDK',
        description: '',
        gamePath: EMOSDK_GAME_PATH,
        processName: EMOSDK_PROCESS,
        qrAssetPath: '',
        videoPath: '', //AppAssets.emosdk_video,
        imagesList: [
          AppAssets.emo_sdk_src1,
        ],
      );

  static String get VISUAL_FLOSS_PROCESS => dotenv.env['VISUAL_FLOSS_PROCESS'] ?? 'CalculatorApp.exe';
  static String get ECHO_GAMES_LAB_PROCESS => dotenv.env['ECHO_GAMES_LAB_PROCESS'] ?? 'CalculatorApp.exe';
  static String get EXCEEDIUM_GAMES_PROCESS => dotenv.env['EXCEEDIUM_GAMES_PROCESS'] ?? 'CalculatorApp.exe';
  static String get SIGIL_GAMES_PROCESS => dotenv.env['SIGIL_GAMES_PROCESS'] ?? 'CalculatorApp.exe';
  static String get IZ_HAZARD_PROCESS => dotenv.env['IZ_HAZARD_PROCESS'] ?? 'CalculatorApp.exe';
  static String get FLESH_INSANE_TEAM_PROCESS => dotenv.env['FLESH_INSANE_TEAM_PROCESS'] ?? 'CalculatorApp.exe';
  static String get EMOSDK_PROCESS => dotenv.env['EMOSDK_PROCESS'] ?? 'CalculatorApp.exe';

  static String get VISUAL_FLOSS_GAME_PATH => dotenv.env['VISUAL_FLOSS_GAME_PATH'] ?? 'calc.exe';
  static String get ECHO_GAMES_LAB_GAME_PATH => dotenv.env['ECHO_GAMES_LAB_GAME_PATH'] ?? 'calc.exe';
  static String get EXCEEDIUM_GAMES_GAME_PATH => dotenv.env['EXCEEDIUM_GAMES_GAME_PATH'] ?? 'calc.exe';
  static String get SIGIL_GAMES_GAME_PATH => dotenv.env['SIGIL_GAMES_GAME_PATH'] ?? 'calc.exe';
  static String get IZ_HAZARD_GAME_PATH => dotenv.env['IZ_HAZARD_GAME_PATH'] ?? 'calc.exe';
  static String get FLESH_INSANE_TEAM_GAME_PATH => dotenv.env['FLESH_INSANE_TEAM_GAME_PATH'] ?? 'calc.exe';
  static String get EMOSDK_GAME_PATH => dotenv.env['EMOSDK_GAME_PATH'] ?? 'calc.exe';

  static StudioModel get visualFloss => StudioModel(
        studioName: 'Visual Floss',
        games: [theSacredMemory, reverb],
      );

  static StudioModel get echoGamesLab => StudioModel(
        studioName: 'Echo Games Lab',
        games: [reverb],
      );

  static StudioModel get exceediumGames => StudioModel(
        studioName: 'Exceedium Games',
        games: [shakeIt],
      );

  static StudioModel get sigilGames => StudioModel(
        studioName: 'Sigil Games',
        games: [divinum],
      );

  static StudioModel get izHazard => StudioModel(
        studioName: 'Iz Hazard',
        games: [gostOfTime],
      );

  static StudioModel get fleshInsaneTeam => StudioModel(
        studioName: 'Flesh Insane Team',
        games: [fleshInsaneTeamGame],
      );

  static StudioModel get emoSDK => StudioModel(
        studioName: 'EmoSDK',
        games: [emoSDKGame],
      );

  Future<void> load() async {
    try {
      await dotenv.load(fileName: 'assets/.env');
    } on Exception {
      log('Env load error');
    }
  }
}
