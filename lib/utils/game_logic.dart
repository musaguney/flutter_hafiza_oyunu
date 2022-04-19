// ignore_for_file: non_constant_identifier_names

class GameCard {
  String? gameImg;
  bool? selected;

  GameCard({this.gameImg, this.selected = false});

  @override
  String toString() {
    return "GameCard($gameImg , $selected)";
  }
}
