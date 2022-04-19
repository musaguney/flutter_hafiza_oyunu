import 'package:sqflite/sqflite.dart' as sql;

class SQLHelper{
  Future<sql.Database> db() async {
    return sql.openDatabase(
      'hafizaoyunu.db',
      version: 1,
      onCreate: (sql.Database database, int version) async {
        await yeniTabloOlustur(database);
      },
    );
  }

   Future<void> yeniTabloOlustur(sql.Database database) async {
    await database.execute("""CREATE TABLE hafizaoyunu(
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        skor INTEGER,
        sure INTEGER,
        createdAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
      )
      """);
  }

   Future<int> yeniSkorEkle(int skor, int sure) async {
    final db = await this.db();

    final data = {'skor': skor, 'sure': sure};
    final id = await db.insert('hafizaoyunu', data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
    return id;
  }

   Future<List<Map<String, dynamic>>> skorlarListesi() async {
    final db = await this.db();
    return db.query('hafizaoyunu', orderBy: "id");
  }

}