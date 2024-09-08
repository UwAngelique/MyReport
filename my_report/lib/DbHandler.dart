// import 'package:path/path.dart';
// import 'package:sqflite/sqflite.dart';

// class DbHandler {
//   static const _databaseName = 'myReport.db';
//   static const _databaseVersion = 2;

//   static const table = 'reports';

//   static const columnId = '_id';
//   static const columnName = 'name';
//   static const columnUsername = 'username';
//   static const columnEmail = 'email';
//   static const columnPassword = 'password';

//   // Make this a singleton class
//   DbHandler._privateConstructor();
//   static final DbHandler instance = DbHandler._privateConstructor();

//   // Database object
//   static Database? _database;

//   // Get the database object
//   Future<Database> get database async {
//     if (_database != null) return _database!;

//     _database = await _initDatabase();
//     return _database!;
//   }

//   // Initialize database
//   Future<Database> _initDatabase() async {
//     String path = join(await getDatabasesPath(), _databaseName);
//     Database database = await openDatabase(path, version: _databaseVersion, onCreate: _onCreate, onUpgrade: _onUpgrade);
    
//     // Perform alteration if necessary
//     int dbVersion = await database.getVersion();
//     if (dbVersion < _databaseVersion) {
//       await _onUpgrade(database, dbVersion, _databaseVersion);
//     }

//     return database;
//   }

//   // Create database table
//   Future<void> _onCreate(Database db, int version) async {
//     await db.execute('''
//       CREATE TABLE $table (
//         $columnId INTEGER PRIMARY KEY,
//         $columnName TEXT NOT NULL,
//         $columnEmail TEXT NOT NULL UNIQUE,
//         $columnPassword TEXT NOT NULL
//       )
//     ''');
//   }

//   // Handle database upgrades
//   Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
//     if (oldVersion < 2) {
//       // Alter the table to add the "username" column
//       // await _alterTable(db);

//       // Update database version
//       await db.setVersion(newVersion);
//     }
//   }

//   // Alter the table to add the "username" column
//   // Future<void> _alterTable(Database db) async {
//   //   await db.execute('ALTER TABLE $table ADD COLUMN $columnUsername TEXT');
//   // }

//   // Insert a record
//   Future<int> insert(Map<String, dynamic> row) async {
//     Database db = await instance.database;
//     return await db.insert(table, row);
//   }
//   // Login function
//   Future<bool> login(String email, String password) async {
//     Database db = await instance.database;
//     List<Map<String, dynamic>> results = await db.query(table, where: '$columnEmail = ? AND $columnPassword = ?', whereArgs: [email, password]);
//     return results.isNotEmpty;
//   }
// }
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:intl/intl.dart';
class DbHandler {
  static const _databaseName = 'myReport.db';
  static const _databaseVersion = 2;

  static const tableReports = 'reports';
  static const tableServiceTarget = 'service_target';
  static const table = 'reports';
  static const columnId = '_id';
  static const columnName = 'name';
  static const columnUsername = 'username';
  static const columnEmail = 'email';
  static const columnPassword = 'password';
  static const columnServiceName = 'service_name';
  static const columnServiceDescription = 'service_description';
  static const columnStartDate = 'start_date';
  static const columnEndDate = 'end_date';
  static const columnTargethours='target_hours';
  static const columnUserAccount='user_account';

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

  // Create database tables
  // Future<void> _onCreate(Database db, int version) async {
  //   await db.execute('''
  //     CREATE TABLE $tableReports (
  //       $columnId INTEGER PRIMARY KEY,
  //       $columnName TEXT NOT NULL,
  //       $columnEmail TEXT NOT NULL UNIQUE,
  //       $columnPassword TEXT NOT NULL
  //     )
  //   ''');

  //   await db.execute('''
  //     CREATE TABLE $tableServiceTarget (
  //       $columnId INTEGER PRIMARY KEY,
  //       $columnServiceName TEXT NOT NULL,
  //       $columnServiceDescription TEXT NOT NULL,
  //       $columnStartDate TEXT NOT NULL,
  //       $columnEndDate TEXT NOT NULL
  //     )
  //   ''');
  // }
  Future<void> _onCreate(Database db, int version) async {
  print('Creating tables...');
  
  await db.execute('''
    CREATE TABLE $tableReports (
      $columnId INTEGER PRIMARY KEY AUTOINCREMENT,
      $columnName TEXT NOT NULL,
      $columnEmail TEXT NOT NULL UNIQUE,
      $columnPassword TEXT NOT NULL
    )
  ''');

  await db.execute('''
    CREATE TABLE $tableServiceTarget (
      $columnId INTEGER PRIMARY KEY AUTOINCREMENT,
      $columnServiceName TEXT NOT NULL,
      $columnServiceDescription TEXT NOT NULL,
      $columnStartDate TEXT NOT NULL,
      $columnEndDate TEXT NOT NULL,
      $columnTargethours TEXT NOT NULL,
      $columnUserAccount TEXT NOT NULL
    )
  ''');
  
  print('Tables created.');
}


  // Handle database upgrades
  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < 2) {
      // Implement any needed upgrades here
      await db.setVersion(newVersion);
    }
  }

  // Insert a record into the service_target table
  Future<int> insertServiceTarget(Map<String, dynamic> row) async {
    Database db = await instance.database;
    return await db.insert(tableServiceTarget, row);
  }
  // Insert a record
  Future<int> insert(Map<String, dynamic> row) async {
    Database db = await instance.database;
    return await db.insert(table, row);
  }
  // Login function
  Future<bool> login(String email, String password) async {
    Database db = await instance.database;
    List<Map<String, dynamic>> results = await db.query(tableReports, where: '$columnEmail = ? AND $columnPassword = ?', whereArgs: [email, password]);
    return results.isNotEmpty;
  }
   // Method to select records where date range includes the current month
  Future<List<Map<String, dynamic>>> getServiceTargetsForCurrentMonth() async {
     String user_account="uwibambeange@gmail.com";
    Database db = await instance.database;

    // Get the first and last dates of the current month
    DateTime now = DateTime.now();
    DateTime firstDayOfMonth = DateTime(now.year, now.month, 1);
    DateTime lastDayOfMonth = DateTime(now.year, now.month + 1, 0); // Last day of the month

    // Format dates to string for querying
    String formattedFirstDay = DateFormat('yyyy-MM-dd').format(firstDayOfMonth);
    String formattedLastDay = DateFormat('yyyy-MM-dd').format(lastDayOfMonth);

    // Query the database
    List<Map<String, dynamic>> results = await db.rawQuery('''
      SELECT * FROM $tableServiceTarget
      WHERE (start_date <= ? AND end_date >= ? AND user_account=?)
    ''', [formattedLastDay, formattedFirstDay,user_account]);

    return results;
  }
}
