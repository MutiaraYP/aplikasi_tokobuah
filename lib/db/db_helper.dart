import 'package:toko_buah/model/buah.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBHelper {
  static final DBHelper _instance = DBHelper._internal();
  static Database? _database;

  final String tableName = 'tableNama';
  final String columnId = 'id';
  final String columnNama = 'nama';
  final String columnJumlah = 'jumlah';
  final String columnHarga = 'harga';
  final String columnIsi = 'isi';

  DBHelper._internal();
  factory DBHelper() => _instance;

  Future<Database?> get _db async {
    if (_database != null) {
      return _database;
    }
    _database = await _initDb();
    return _database;
  }

  Future<Database?> _initDb() async {
    String databasePath = await getDatabasesPath();
    String path = join(databasePath, 'buah_db');

    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future<void> _onCreate(Database db, int version) async {
    var sql = "CREATE TABLE $tableName($columnId INTEGER PRIMARY KEY,"
        "$columnNama TEXT,"
        "$columnJumlah TEXT,"
        "$columnHarga TEXT,"
        "$columnIsi TEXT)";
    await db.execute(sql);
  }

  Future<int?> saveBuah(Buah buah) async {
    var dbClient = await _db;
    return await dbClient!.insert(tableName, buah.toMap());
  }

  Future<List?> getAllBuah() async {
    var dbClient = await _db;
    var result = await dbClient!.query(tableName,
        columns: [columnId, columnNama, columnJumlah, columnHarga, columnIsi]);
    return result.toList();
  }

  Future<int?> updateBuah(Buah buah) async {
    var dbClient = await _db;
    return await dbClient!.update(tableName, buah.toMap(),
        where: '$columnId = ?', whereArgs: [buah.id]);
  }

  Future<int?> deleteBuah(int id) async {
    var dbClient = await _db;
    return await dbClient!
        .delete(tableName, where: '$columnId = ?', whereArgs: [id]);
  }
}
