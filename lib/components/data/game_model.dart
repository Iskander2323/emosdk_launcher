class GameModel {
  final String gameName;
  final String description;
  final String processName;
  final String gamePath;
  final String videoPath;
  final String qrAssetPath;
  final List<String> imagesList;

  GameModel({
    required this.gameName,
    required this.description,
    required this.processName,
    required this.gamePath,
    required this.qrAssetPath,
    required this.videoPath,
    required this.imagesList,
  });
  
}