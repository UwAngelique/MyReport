import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DbHandler {
  static final _databaseName = 'myReport.db';
  static final _databaseVersion = 2;

  static final table = 'reports';

  static final columnId = '_id';
  static final columnName = 'name';
  static final columnUsername = 'username';
  static final columnEmail = 'email';
  static final columnPassword = 'password';

  // Make this a singleton class
  DbHandler._privateConstructor();
  static final DbHandler instance = DbHandler._privateConstructor();

  // Database object
  static Database? _database;

  // Get the database object
  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDatabase();
    return _database!;
  }

  // Initialize database
  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), _databaseName);
    Database database = await openDatabase(path, version: _databaseVersion, onCreate: _onCreate, onUpgrade: _onUpgrade);
    
    // Perform alteration if necessary
    int dbVersion = await database.getVersion();
    if (dbVersion < _databaseVersion) {
      await _onUpgrade(database, dbVersion, _databaseVersion);
    }

    return database;
  }

  // Create database table
  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $table (
        $columnId INTEGER PRIMARY KEY,
        $columnName TEXT NOT NULL,
        $columnEmail TEXT NOT NULL UNIQUE,
        $columnPassword TEXT NOT NULL
      )
    ''');
  }

  // Handle database upgrades
  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < 2) {
      // Alter the table to add the "username" column
      // await _alterTable(db);

      // Update database version
      await db.setVersion(newVersion);
    }
  }

  // Alter the table to add the "username" column
  // Future<void> _alterTable(Database db) async {
  //   await db.execute('ALTER TABLE $table ADD COLUMN $columnUsername TEXT');
  // }

  // Insert a record
  Future<int> insert(Map<String, dynamic> row) async {
    Database db = await instance.database;
    return await db.insert(table, row);
  }
  // Login function
  Future<bool> login(String email, String password) async {
    Database db = await instance.database;
    List<Map<String, dynamic>> results = await db.query(table, where: '$columnEmail = ? AND $columnPassword = ?', whereArgs: [email, password]);
    return results.isNotEmpty;
  }
}
