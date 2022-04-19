import 'package:flutter/material.dart';
import 'package:flutter_application_1/db/sql_helper.dart';
import 'package:flutter_application_1/views/game_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  SQLHelper sqlHelper = SQLHelper();
  int skor = 0;
  int sonOyunSkor = 0;
  int sonOyunSure = 0;
  @override
  void initState() {
    super.initState();
    sonVerileriAl();
  }

  void oyunBaslat(int zorluk) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => GamePage(
                zorluk: zorluk,
                score: (scoreValue) {
                  skor = scoreValue;
                  sonVerileriAl();
                },
              )),
    );
  }

  String sureYazdir(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
  }

  void sonVerileriAl() async {
    List<Map<String, dynamic>> items = await sqlHelper.skorlarListesi();
    sonOyunSkor = items.last["skor"];
    sonOyunSure = items.last["sure"];
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Hafıza Oyunu"),
      ),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("YENİ OYUN", style: const TextStyle(fontSize: 30)),
              const SizedBox(height: 10),
              Text("SKOR : " + skor.toString(),
                  style: const TextStyle(fontSize: 20)),
              const SizedBox(height: 50),
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.blue.shade100,
                ),
                child: Text(" SON OYUN SKOR : " + sonOyunSkor.toString(),
                    style: const TextStyle(fontSize: 16)),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.blue.shade100,
                ),
                child: Text(
                    " SON OYUN SÜRE : " +
                        sureYazdir(Duration(seconds: sonOyunSure)),
                    style: const TextStyle(fontSize: 16)),
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () {
                  oyunBaslat(1);
                },
                child: Container(
                  width: 200,
                  height: 50,
                  alignment: Alignment.center,
                  child: const Text("Kolay Seviye"),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  oyunBaslat(2);
                },
                child: Container(
                  width: 200,
                  height: 50,
                  alignment: Alignment.center,
                  child: const Text("Zor Seviye"),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
