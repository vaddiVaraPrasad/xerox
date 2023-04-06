import "package:sqflite/sqflite.dart";
import "package:path/path.dart" as pth;
import "package:xerox/model/user.dart";

class SQLHelpers {
  static Database? _database;
  static get getDatabase async {
    if (_database != null) return _database;
    _database = await initDatabase();
    return _database;
  }

  static Future<Database> initDatabase() async {
    String path = pth.join(await getDatabasesPath(), "xerox_user.db");
    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  static Future _onCreate(Database db, int version) async {
    await db.execute('''
CREATE TABLE users(
  userId TEXT PRIMARY KEY,
  userName TEXT,
  userEmail TEXT,
  userPlaceName TEXT,
  latitude DOUBLE,
  longitude DOUBLE,
  userProfileUrl TEXT,
  userContryName TEXT
)
''');
    print("on create was called");
  }

  static void getAllTableData(String tableName) async {
    print("get all data from table is called");
    Database db = await getDatabase;
    var data = await db.query(tableName);
    print(data);
  }

  static Future<Map<String, dynamic>> getLatestUser(String tableName) async {
    Database db = await getDatabase;
    var data = await db.query(tableName);
    print("in sql helper get latestUSer");
    if (data.isNotEmpty) {
      return data[data.length - 1];
    }
    return {};
  }

  static Future<void> insertUser(Users usr) async {
    Database db = await getDatabase;
    var map = usr.toMap;
    await db.insert("users", usr.toMap,
        conflictAlgorithm: ConflictAlgorithm.replace);
    SQLHelpers.getAllTableData("users");
  }

  static Future<Map<String, dynamic>> getUserById(String id) async {
    Database db = await getDatabase;
    var data = await db.rawQuery("SELECT * FROM users WHERE userId = ?", [id]);
    print(data);
    return data[0];
  }

  static Future<bool> checkUserPresent(String id) async {
    Database db = await getDatabase;
    var data = await db.rawQuery("SELECT * FROM users WHERE userId = ?", [id]);
    print(data);
    return data.isEmpty;
  }
}
