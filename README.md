## flutter hafiza oyunu
![HafizaOyunu](https://user-images.githubusercontent.com/97352514/164082701-fd1ba3e5-41ce-44c1-afc4-a1320af4e6e4.gif)

##Hazırlayanlar:
1190505029 Musa Güney
1190505623 Berkant Yurtsever

##Projenin Amacı
Flutter Framework ile yapılmış bir Mobil Kart hafıza oyunu. Detayları için lib klasöründen inceleyebilirsiniz.

##Resimleri Aldığımız Link
[Wikipedia Commons] (https://commons.wikimedia.org/wiki/User:CFCF/Flat'n'round)

##Yardımcı Kaynaklar

[Flutter widget kataloğu] (https://docs.flutter.dev/development/ui/widgets)
[Using SQLite in Flutter] (https://medium.com/flutter-community/using-sqlite-in-flutter-187c1a82e8b)

##Oyunun Kuralları

Oyuna bir kartı çevirerek başlarız.
Eğer kartlar eşleşmezse kartlar tekrar ters çevrilir.
Çevirdiğimiz sonraki kart doğru eşleşirse +10 puan kazanır yanlış eşleşirse -2 puan kaybeder.
Oyun, tahtadaki tüm kartları eşleştirene kadar devam eder.
Ve oyun sonunda skoru ana menüde görünür.

##Proje Tasarımı Yaparken
1- Sayfaları 2 sayfa olarak tasarladık. 
-Ana sayfa (home_page) kısmı ve Oyun sayfası (game_page)

2- Widgetları ayrı dosyalar olarak tasarladık.

3- DataBase kısmını klasör olarak aldık. SQlite uygulamasını kullanmadan projenin içinde kullandık.
- Süreyi ve skoru oyun bitiminden db ekleyip oyunun ana sayfasına SON OYUN SKOR, SON OYUN SÜRE olan kısımlarda yazdırdık.

Ek olarak: İf else kullanarak yeni bir karıştırma algoritması yaptık.


## Getting Started
This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.


