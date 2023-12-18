import 'package:finanseeup/models/piece.dart';

class PieChartController {
  List<Piece> currentPieces = [];
  String graph = "";

  PieChartController({required this.graph, required this.currentPieces});

  void updatePieces(List<Piece> newPieces) {
    currentPieces = newPieces;
  }
}
