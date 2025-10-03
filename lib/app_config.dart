import 'dart:developer';

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

  Future<void> load() async {
    try {
      await dotenv.load(fileName: 'assets/.env');
    } on Exception {
      log('Env load error');
    }
  }
}
