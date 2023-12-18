import 'package:flutter/material.dart';
import 'package:finanseeup/models/coordinate.dart';

class LineBarGraphController {
  List<Coordinate> currentCoordinates = [];
  List<Coordinate> currentCoordinates2 = [];
  List<String>? legends;
  String graph = "";

  LineBarGraphController({
    required this.graph,
    required this.currentCoordinates,
    this.currentCoordinates2 = const [],
    this.legends,
  });

  void initialize(List<Coordinate> coordinates, List<Coordinate>? coordinates2,
      List<String>? legends, String graph) {
    currentCoordinates = coordinates;
    if (coordinates2 != null && coordinates2.isNotEmpty) {
      currentCoordinates2 = coordinates2;
    }
    if (legends != null && legends.isNotEmpty) {
      this.legends = legends;
    }
    this.graph = graph;
  }

  void updateCoordinates(
      List<Coordinate> newCoordinates, List<Coordinate>? newCoordinates2) {
    currentCoordinates = newCoordinates;
    if (newCoordinates2 != null && newCoordinates2.isNotEmpty) {
      currentCoordinates2 = newCoordinates2;
    }
  }
}
