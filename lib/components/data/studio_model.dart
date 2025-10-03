import 'package:emosdk_launcher/components/data/game_model.dart';

class StudioModel {
  final String studioName;
  final List<GameModel> games;

  StudioModel({
    required this.studioName,
    required this.games,
  });
}
