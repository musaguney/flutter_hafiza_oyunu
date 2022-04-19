
import 'package:flutter/material.dart';
import 'package:flutter_application_1/db/sql_helper.dart';
import 'package:flutter_application_1/utils/game_logic.dart';
import 'package:flutter_application_1/widgets/sure.dart';

class GamePage extends StatefulWidget {
  const GamePage({Key? key, required this.zorluk, required this.score})
      : super(key: key);
  final int zorluk;
  final Function(int score) score;

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  SQLHelper sqlHelper = SQLHelper();
  late final int zorluk;

  List<String> cards_list = [
    "assets/images/aslan.png",
    "assets/images/at.png",
    "assets/images/balık.png",
    "assets/images/coala.png",
    "assets/images/fare.png",
    "assets/images/flamingo.png",
    "assets/images/inek.png",
    "assets/images/kanguru.png",
    "assets/images/kurt.png",
    "assets/images/leopar.png",
    "assets/images/monkey.png",
    "assets/images/panda.png",
    "assets/images/papağan.png",
    "assets/images/penguen.png",
    "assets/images/tilki.png",
    "assets/images/yılan.png",
    "assets/images/yunus.png",
    "assets/images/zebra.png"
  ];

  List<GameCard> game_list = [];
  List<GameCard> match_list = [];
  List<GameCard> matched_card = [];

  bool select = false;
  bool complate = false;

  int lastCardIndex = 100;
  int hamle = 0;
  int eslesme = 0;
  int skor = 0;

  int sure = 0;

  @override
  void initState() {
    zorluk = widget.zorluk;
    oyunBaslat();
    super.initState();
  }

  void oyunBaslat() {
    cards_list.shuffle();
    if (zorluk == 1) {
      if (cards_list.length >= 8) {
        for (var i = 0; i < 8; i++) {
          GameCard newcard1 = GameCard(gameImg: cards_list[i], selected: false);
          GameCard newcard2 = GameCard(gameImg: cards_list[i], selected: false);
          game_list.add(newcard1);
          game_list.add(newcard2);
        }
        game_list.shuffle();
      }
    }
    if (zorluk == 2) {
      if (cards_list.length >= 18) {
        for (var i = 0; i < 18; i++) {
          GameCard newcard1 = GameCard(gameImg: cards_list[i], selected: false);
          GameCard newcard2 = GameCard(gameImg: cards_list[i], selected: false);
          game_list.add(newcard1);
          game_list.add(newcard2);
        }
        game_list.shuffle();
      }
    }
  }

  String sureYazdir(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
  }

  alertGoster(BuildContext context) {
    Widget okButton = TextButton(
      child: Text("TEKRAR OYNA"),
      onPressed: () {
        Navigator.of(context).pop();
        Navigator.of(context).pop();
      },
    );

    AlertDialog alert = AlertDialog(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("OYUN BİTTİ"),
        ],
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text("Tebrikler Oyunu Bitirdiniz"),
          Text("Süre : ${sureYazdir(Duration(seconds: sure))}")
        ],
      ),
      actions: [
        okButton,
      ],
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Hafıza Oyunu"),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              children: [
                Expanded(
                    child: Container(
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.orange.shade100,
                  ),
                  child: Text(
                    "Skor: $skor",
                    style: TextStyle(fontSize: 20),
                  ),
                )),
                SizedBox(
                  width: 10,
                ),
                Expanded(child: SureWidget(sureDeger: (time) {
                  sure = time;
                })),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              children: [
                Expanded(
                    child: Container(
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.orange.shade100,
                  ),
                  child: Text(
                    "Eşleşme: $eslesme / ${(game_list.length / 2).toInt()}",
                    style: TextStyle(fontSize: 20),
                  ),
                )),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                    child: Container(
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.orange.shade100,
                  ),
                  child: Text(
                    "Hamle: $hamle",
                    style: TextStyle(fontSize: 20),
                  ),
                )),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: GridView.builder(
                  itemCount: game_list.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: zorluk == 1 ? 4 : 6,
                    crossAxisSpacing: 16.0,
                    mainAxisSpacing: 16.0,
                  ),
                  itemBuilder: (context, index) {
                    bool match = false;
                    GameCard currentCard = game_list[index];
                    for (var i = 0; i < match_list.length; i++) {
                      if (match_list[i] == currentCard) {
                        match = true;
                      }
                    }
                    return currentCard.selected == true
                        ? match == true
                            ? Container(
                                child: Image.asset(currentCard.gameImg ?? ""),
                              )
                            : Container(
                                child: Image.asset(currentCard.gameImg ?? ""),
                              )
                        : GestureDetector(
                            onTap: () async {
                              hamle++;
                              print("HAMLE : $hamle");
                              select = true;
                              setState(() {});
                              if (lastCardIndex == 100) {
                                lastCardIndex = index;
                                currentCard.selected = true;
                                setState(() {});
                              } else {
                                if (complate == false) {
                                  if (game_list[lastCardIndex].gameImg !=
                                      currentCard.gameImg) {
                                    currentCard.selected = true;

                                    setState(() {});
                                    if (select == true) {
                                      complate = true;
                                      setState(() {});
                                      Future.delayed(Duration(seconds: 1))
                                          .then((value) {
                                        game_list[lastCardIndex].selected =
                                            false;
                                        currentCard.selected = false;
                                        lastCardIndex = 100;
                                        select = false;
                                        complate = false;
                                        skor -= 2;
                                        setState(() {});
                                      });
                                    }
                                  } else {
                                    int value = zorluk == 1 ? 8 : 18;

                                    matched_card.add(game_list[index]);
                                    skor += 10;
                                    eslesme++;
                                    currentCard.selected = true;
                                    lastCardIndex = 100;
                                    setState(() {});
                                    if (matched_card.length == value) {
                                      await sqlHelper.yeniSkorEkle(skor, sure);
                                      alertGoster(context);
                                    }
                                  }
                                  widget.score(skor);
                                }
                              }
                            },
                            child: Container(
                              color: Colors.orange,
                              child: Image.asset("assets/images/hidden.png"),
                            ),
                          );
                  }),
            ),
          )
        ],
      ),
    );
  }
}
